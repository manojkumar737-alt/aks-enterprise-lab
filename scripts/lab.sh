#!/bin/bash

set -e

ACTION=$1
ENV=$2

if [[ -z "$ACTION" || -z "$ENV" ]]; then
    echo "Usage: ./scripts/lab.sh <plan|apply|destroy|verify> <dev|qa|prod>"
    exit 1
fi

if [[ "$ENV" != "dev" && "$ENV" != "qa" && "$ENV" != "prod" ]]; then
    echo "Environment must be: dev | qa | prod"
    exit 1
fi

case $ACTION in

plan)
    echo "======================================="
    echo "Running Plan for $ENV"
    echo "======================================="
    ./scripts/plan.sh "$ENV"
;;

apply)
    echo "======================================="
    echo "Applying Changes to $ENV"
    echo "======================================="
    ./scripts/apply.sh "$ENV"
    ./scripts/post-deploy.sh
    ./scripts/verify.sh
;;

destroy)
    echo "======================================="
    echo "Destroying $ENV Infrastructure"
    echo "======================================="
    ./scripts/destroy.sh "$ENV"
;;

verify)
    echo "======================================="
    echo "Verifying $ENV Cluster"
    echo "======================================="
    ./scripts/verify.sh
;;

*)
    echo "Unknown action: $ACTION"
    exit 1
;;

esac