#!/bin/bash

set -e

echo "======================================="
echo "AKS Verification"
echo "======================================="

kubectl get nodes

kubectl get ns

kubectl get pods -A

kubectl get svc -A

echo ""
echo "AKS Cluster is Ready."

echo ""
echo "Next Steps"

echo "1. Install FluxCD"

echo "2. Install NGINX Ingress"

echo "3. Deploy Applications"

echo "4. Verify Monitoring"