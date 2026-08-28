#!/bin/bash

set -e

ENV=$1

if [[ "$ENV" != "dev" && "$ENV" != "qa" && "$ENV" != "prod" ]]; then
    echo "Usage: ./scripts/apply.sh {dev|qa|prod}"
    exit 1
fi

echo "======================================="
echo "Terraform Apply ($ENV)"
echo "======================================="

terraform init \
    -reconfigure \
    -backend-config=backend/${ENV}.hcl

if [[ ! -f "tfplan-${ENV}" ]]; then
    echo "Terraform plan not found."
    echo "Run: ./scripts/plan.sh ${ENV}"
    exit 1
fi

terraform apply "tfplan-${ENV}"

echo ""
echo "Reading Terraform Outputs..."

RESOURCE_GROUP=$(terraform output -raw resource_group_name)
AKS_CLUSTER=$(terraform output -raw aks_cluster_name)

echo "Resource Group : ${RESOURCE_GROUP}"
echo "AKS Cluster    : ${AKS_CLUSTER}"

echo ""
echo "Updating kubeconfig..."

az aks get-credentials \
    --resource-group "${RESOURCE_GROUP}" \
    --name "${AKS_CLUSTER}" \
    --overwrite-existing

echo ""
echo "Waiting for Kubernetes API..."

until kubectl cluster-info >/dev/null 2>&1
do
    echo "Waiting..."
    sleep 10
done

echo ""
echo "Waiting for AKS nodes..."

kubectl wait \
    --for=condition=Ready node \
    --all \
    --timeout=10m

echo ""
echo "======================================="
echo "Cluster Information"
echo "======================================="

kubectl get nodes -o wide

kubectl get ns

echo ""
echo "Terraform Apply Completed Successfully."