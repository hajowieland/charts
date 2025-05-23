#!/usr/bin/env bash

set -euo pipefail

echo "Add Helm Repositories for cnpg and prometheus-operator-crds ..."
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "Check for coredns to be ready ..."
kubectl wait --for=condition=Ready -n kube-system pod -l k8s-app=kube-dns

echo "Deploying cnpg ..."
helm upgrade --install cnpg cnpg/cloudnative-pg --wait

echo "Deploying Postgres Cluster ..."
cat << EOF > /tmp/values.yaml
type: postgresql
mode: standalone
version:
  postgresql: "16"
cluster:
  instances: 1
EOF

helm upgrade --install test-db cnpg/cluster -f /tmp/values.yaml --wait

echo "Wait for Cluster to be ready ..."
kubectl wait --for=condition=Ready cluster/test-db-cluster --timeout=60s

echo "Deploy prometheus-operator-crds ..."
helm upgrade --install prometheus-crds prometheus-community/prometheus-operator-crds --wait

echo "Create miniflux admin Secret ..."
kubectl create secret generic miniflux-admin --from-literal=password=superpwsecret
