#!/usr/bin/env  bash

ROOT_DIR=`pwd`

. $ROOT_DIR/bin/utils.sh
. $ROOT_DIR/bin/template.sh

# these variables are always set by default in the CI (circleci)
CI_SHA1=$(git rev-parse --short HEAD)
CI_BUILD_NUM=$CI_SHA1
CI_TAG=$CI_SHA1

info "Linting configuration files"

k8s-lint

info "Building docker image"

docker-build

info "Push built image to registry"

docker-push

info "Deploy appliaton to kubernetes"

# k8s-deploy-and-verify
minikube-deploy
