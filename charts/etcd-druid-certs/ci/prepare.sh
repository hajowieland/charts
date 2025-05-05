#!/usr/bin/env bash

set -euo pipefail

echo "Deploying cert-manager ..."
helm repo add jetstack https://charts.jetstack.io
helm repo update
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.17.2/cert-manager.crds.yaml
sleep 3
helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.17.2
