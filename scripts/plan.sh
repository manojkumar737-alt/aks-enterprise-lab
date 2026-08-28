#!/bin/bash

set -e

ENV=$1

if [[ "$ENV" != "dev" && "$ENV" != "qa" && "$ENV" != "prod" ]]; then
    echo "Usage: ./scripts/plan.sh {dev|qa|prod}"
    exit 1
fi

terraform init \
    -reconfigure \
    -backend-config=backend/${ENV}.hcl

terraform plan \
    -var-file=environments/${ENV}.tfvars \
    -out=tfplan-${ENV}

echo ""
echo "Plan saved as tfplan-${ENV}"