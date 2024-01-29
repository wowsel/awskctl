#!/usr/bin/env bash
set -euo pipefail

echo "Retrieving Docker Credentials for the AWS ECR Registry ${AWS_ACCOUNT}"
DOCKER_REGISTRY_SERVER=https://${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
DOCKER_PASSWORD=$(aws ecr get-login-password --region ${AWS_REGION})
DOCKER_USER=AWS

IFS=', ' read -r -a namespace_array <<< "${TARGET_NAMESPACES:-default}"

for namespace in "${namespace_array[@]}"; do
    echo "Working in namespace: $namespace"

    echo "Removing previous secret in namespace $namespace"
    kubectl --namespace=$namespace delete secret aws-registry || true

    echo "Creating new secret in namespace $namespace"
    kubectl create secret docker-registry aws-registry \
            --docker-server=$DOCKER_REGISTRY_SERVER \
            --docker-username=$DOCKER_USER \
            --docker-password=$DOCKER_PASSWORD \
            --docker-email=no@email.local \
            --namespace=$namespace

    # Проверяем, что текущее пространство имен - 'default' и переменная SECRET_COPIER установлена в 'true'
    if [ "$namespace" = "default" ] && [ "${SECRET_COPIER:-false}" = "true" ]; then
        echo "Applying annotations and labels for secret copier in default namespace"
        kubectl annotate secret aws-registry --namespace=default \
          secret-copier.deckhouse.io/target-namespace-selector="aws-registry=true"
        
        kubectl label secret aws-registry --namespace=default \
          secret-copier.deckhouse.io/enabled=""
    elif [ "$namespace" = "default" ]; then
        echo "Skipping annotations and labels for secret copier in default namespace because SECRET_COPIER is not 'true'"
    else
        echo "Skipping annotations and labels for secret copier as current namespace is not 'default'"
    fi

    echo "Secret updated in namespace: $namespace"
    echo
done
