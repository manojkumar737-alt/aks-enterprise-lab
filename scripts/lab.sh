#!/bin/bash

set -e

ACTION=$1
ENV=$2

if [[ -z "$ACTION" || -z "$ENV" ]]; then
    echo "Usage:"
    echo "./scripts/lab.sh plan <dev|qa|prod>"
    echo "./scripts/lab.sh apply <dev|qa|prod>"
    echo "./scripts/lab.sh destroy <dev|qa|prod>"
    echo "./scripts/lab.sh verify <dev|qa|prod>"
    echo "./scripts/lab.sh create <dev|qa|prod>"
    exit 1
fi

if [[ "$ENV" != "dev" && "$ENV" != "qa" && "$ENV" != "prod" ]]; then
    echo "Environment must be: dev | qa | prod"
    exit 1
fi

case $ACTION in

plan)
    echo "======================================="
    echo "Initializing & Planning $ENV Environment"
    echo "======================================="
    ./scripts/init.sh "$ENV"
    ./scripts/plan.sh "$ENV"
;;

apply)
    echo "======================================="
    echo "Applying Changes to $ENV Environment"
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
    ./scripts/init.sh "$ENV"
    ./scripts/destroy.sh "$ENV"
;;

verify)
    echo "======================================="
    echo "Verifying $ENV Environment"
    echo "======================================="
    ./scripts/verify.sh
;;

create)
    echo "======================================="
    echo "Complete Run (Plan & Apply) for $ENV"
    echo "======================================="
    ./scripts/init.sh "$ENV"
    ./scripts/plan.sh "$ENV"
    ./scripts/apply.sh "$ENV"
    ./scripts/post-deploy.sh
    ./scripts/verify.sh
;;

*)
    echo "Unknown action: $ACTION"
    exit 1
;;

esac