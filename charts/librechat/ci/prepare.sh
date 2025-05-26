#!/usr/bin/env bash

set -euo pipefail

echo "Add Helm Repository for mongodb ..."
helm repo add mongo https://mongodb.github.io/helm-charts
helm repo update

echo "Check for coredns to be ready ..."
kubectl wait --for=condition=Ready -n kube-system pod -l k8s-app=kube-dns

echo "Deploy mongo-community-operator ..."
helm upgrade --install mongo-community-operator mongo/community-operator --set operator.watchNamespace='*' --wait

echo "Create librechat-mongo-admin Secret ..."
kubectl create secret generic librechat-mongo-admin --from-literal=password=librechat-mongo-test

echo "Deploy MongoDB Cluster ..."
cat << EOF > /tmp/mongodb.yaml
apiVersion: mongodbcommunity.mongodb.com/v1
kind: MongoDBCommunity
metadata:
  name: test-mongo-cluster
spec:
  members: 1
  type: ReplicaSet
  version: "8.0.8"
  security:
    authentication:
      modes: ["SCRAM"]
  users:
    - name: librechat
      db: admin
      passwordSecretRef:
        name: librechat-mongo-admin
      roles:
        - name: clusterAdmin
          db: admin
        - name: userAdminAnyDatabase
          db: admin
        - name: dbAdmin
          db: admin
        - name: readWrite
          db: admin
      scramCredentialsSecretName: librechat-mongo-scram
  additionalMongodConfig:
    storage.wiredTiger.engineConfig.journalCompressor: zlib
EOF

kubectl apply -f /tmp/mongodb.yaml

echo "Create librechat Secret ..."
# https://www.librechat.ai/toolkit/creds_generator
kubectl create secret generic librechat --from-literal=OPENAI_API_KEY=librechat-mongo-test --from-literal=CREDS_KEY=6bec5a083cec7a143cd71fe26ec65bf76e32581edd6cdbcc7c6b349ed6c8a8cc --from-literal=CREDS_IV=02407e6a1fcfba87eaa05827fef92d90 --from-literal=JWT_SECRET=6ff349c773db6a0c67150372ef04357f687870d46bf8ec1c6b737068c9c9f2dd --from-literal=JWT_REFRESH_SECRET=710a3611c9e1b5e012256746021cb1ea9e61a49033736b27cc48b36cef3a5bb1

echo "Deploy dependencies (rag-api) ..."
CURRENT_DIR=$(dirname -- "${BASH_SOURCE[0]}")
source "$CURRENT_DIR/../../librechat-rag-api/ci/prepare.sh"

echo "Wait for MongoDBCommunity to be ready ..."
kubectl wait --for=jsonpath='{.status.phase}'=Running MongoDBCommunity/test-mongo-cluster --timeout=180s
