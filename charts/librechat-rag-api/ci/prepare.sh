#!/usr/bin/env bash

set -euo pipefail

echo "Add Helm Repository for cnpg ..."
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm repo update

echo "Check for coredns to be ready ..."
kubectl wait --for=condition=Ready -n kube-system pod -l k8s-app=kube-dns

echo "Deploy cnpg ..."
helm upgrade --install cnpg cnpg/cloudnative-pg --wait

echo "Deploy Postgres Cluster ..."
cat << EOF > /tmp/values.yaml
type: postgresql
mode: standalone
version:
  postgresql: "16"
cluster:
  instances: 1
EOF

helm upgrade --install test-db cnpg/cluster -f /tmp/values.yaml --wait

echo "Create test Secret ..."
kubectl create secret generic test --from-literal=OPENAI_API_KEY=test

echo "Wait for Cluster to be ready ..."
kubectl wait --for=condition=Ready cluster/test-db-cluster --timeout=60s
