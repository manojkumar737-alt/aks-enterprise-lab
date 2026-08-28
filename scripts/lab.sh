#!/bin/bash

set -e

ACTION=$1
ENV=$2

if [[ "$ACTION" != "create" && "$ACTION" != "destroy" && "$ACTION" != "verify" ]]; then
    echo "Usage:"
    echo "./scripts/lab.sh create dev"
    echo "./scripts/lab.sh destroy dev"
    echo "./scripts/lab.sh verify dev"
    exit 1
fi

if [[ "$ENV" != "dev" && "$ENV" != "qa" && "$ENV" != "prod" ]]; then
    echo "Environment must be: dev | qa | prod"
    exit 1
fi

case $ACTION in

create)

    echo "======================================="
    echo "Creating $ENV Environment"
    echo "======================================="

    ./scripts/init.sh "$ENV"

    ./scripts/plan.sh "$ENV"

    ./scripts/apply.sh "$ENV"

    ./scripts/post-deploy.sh

    ./scripts/verify.sh

;;

destroy)

    echo "======================================="
    echo "Destroying $ENV Environment"
    echo "======================================="

    ./scripts/destroy.sh "$ENV"

;;

verify)

    ./scripts/verify.sh

;;

esac
