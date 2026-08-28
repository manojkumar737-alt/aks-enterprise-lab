#!/bin/bash

set -e

ENV=$1

if [[ "$ENV" != "dev" && "$ENV" != "qa" && "$ENV" != "prod" ]]; then
    echo "Usage: ./scripts/init.sh {dev|qa|prod}"
    exit 1
fi

echo "======================================="
echo "Terraform Init ($ENV)"
echo "======================================="

terraform init \
    -reconfigure \
    -backend-config=backend/${ENV}.hcl

echo ""
echo "Terraform initialized successfully."