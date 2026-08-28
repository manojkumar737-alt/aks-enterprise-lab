#!/bin/bash

set -e

ENV=$1

if [[ "$ENV" != "dev" && "$ENV" != "qa" && "$ENV" != "prod" ]]; then
    echo "Usage: ./scripts/destroy.sh {dev|qa|prod}"
    exit 1
fi

echo "======================================="
echo "Terraform Destroy ($ENV)"
echo "======================================="

terraform init \
    -reconfigure \
    -backend-config=backend/${ENV}.hcl

echo ""
echo "Reading Terraform Outputs..."

RESOURCE_GROUP=$(terraform output -raw resource_group_name 2>/dev/null || echo "")
AKS_CLUSTER=$(terraform output -raw aks_cluster_name 2>/dev/null || echo "")

terraform destroy \
    -var-file=environments/${ENV}.tfvars \
    -auto-approve

echo ""
echo "Cleaning kubeconfig..."

if [[ -n "$AKS_CLUSTER" ]]; then
    kubectl config delete-context "$AKS_CLUSTER" 2>/dev/null || true
    kubectl config delete-cluster "$AKS_CLUSTER" 2>/dev/null || true
fi

if [[ -n "$RESOURCE_GROUP" && -n "$AKS_CLUSTER" ]]; then
    kubectl config delete-user \
        "clusterUser_${RESOURCE_GROUP}_${AKS_CLUSTER}" \
        2>/dev/null || true
fi

echo ""
echo "Checking Resource Group..."

if az group exists --name "$RESOURCE_GROUP" | grep -q false; then
    echo "✅ Resource Group deleted successfully."
else
    echo "⚠️ Resource Group still exists."
fi

echo ""
echo "Destroy Completed Successfully."