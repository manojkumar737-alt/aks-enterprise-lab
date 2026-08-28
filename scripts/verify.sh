#!/bin/bash

set -e

echo "======================================="
echo "AKS Health Check"
echo "======================================="

echo ""
echo "Nodes"

kubectl get nodes

echo ""
echo "Namespaces"

kubectl get ns

echo ""
echo "Pods"

kubectl get pods -A

echo ""
echo "Services"

kubectl get svc -A

echo ""
echo "Ingress"

kubectl get ingress -A || true

echo ""
echo "Persistent Volumes"

kubectl get pv || true

echo ""
echo "Persistent Volume Claims"

kubectl get pvc -A || true

echo ""
echo "Cluster Verification Completed."