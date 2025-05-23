#!/usr/bin/env bash

set -euo pipefail

echo "Check for coredns to be ready ..."
kubectl wait --for=condition=Ready -n kube-system pod -l k8s-app=kube-dns

echo "Create web-check API keys Secret ..."
kubectl create secret generic web-check-test --from-literal=BUILT_WITH_API_KEY=test --from-literal=GOOGLE_CLOUD_API_KEY=test --from-literal=REACT_APP_SHODAN_API_KEY=test
