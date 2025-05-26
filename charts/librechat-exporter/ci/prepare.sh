#!/usr/bin/env bash

set -euo pipefail

echo "Add Helm Repositories for mongodb and prometheus-operator-crds..."
helm repo add mongo https://mongodb.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
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
  name: test-db-cluster
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

echo "Deploy prometheus-operator-crds ..."
helm upgrade --install prometheus-crds prometheus-community/prometheus-operator-crds --wait

echo "Wait for MongoDBCommunity to be ready ..."
kubectl wait --for=jsonpath='{.status.phase}'=Running MongoDBCommunity/test-db-cluster --timeout=300s
