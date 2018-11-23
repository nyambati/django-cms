#!/usr/bin/env bash

set -eo pipefail

ROOT_DIR=`pwd`

. $ROOT_DIR/bin/utils.sh

activate_google_service_account() {
    require PROJECT_ID $PROJECT_ID
    require COMPUTE_ZONE $COMPUTE_ZONE
    require CLUSTER_NAME $CLUSTER_NAME
    require GCLOUD_SERVICE_KEY $GCLOUD_SERVICE_KEY

    info "Activate Google Service Account"

    echo $GCLOUD_SERVICE_KEY | base64 --decode > $SERVICE_KEY_PATH
    # setup kubectl auth
    gcloud auth activate-service-account --key-file $SERVICE_KEY_PATH
    gcloud --quiet config set project ${PROJECT_ID}
    gcloud --quiet config set compute/zone ${COMPUTE_ZONE}
    gcloud --quiet container clusters get-credentials ${CLUSTER_NAME}
}

build_and_push_docker_image() {
    require AUTH_USERNAME $AUTH_USERNAME
    require AUTH_PASSWORD $AUTH_PASSWORD
    info "Building docker image for $NAMESPACE environment"
    gcloud auth configure-docker
    docker-build
    info "Pushing built docker image to container registry"
    docker-push
}

$@
