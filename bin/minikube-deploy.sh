#!/usr/bin/env  bash

ROOT_DIR=`pwd`

. $ROOT_DIR/bin/utils.sh
. $ROOT_DIR/bin/template.sh

# these variables are always set by default in the CI (circleci)
export CI_SHA1=$(git rev-parse --short HEAD)
export CI_BUILD_NUM=$CI_SHA1
export CI_TAG=$CI_SHA1

info "Linting configuration files"
find_tempate_files "TEMPLATES"
find_and_replace_variables
k8s-lint
is_success "Linting completed successfuly"

info "Building docker image"
docker-build
is_success "Image was built successfuly"

info "Push built image to registry"
docker-push
is_success "Image was pushed successfuly"

info "Deploy appliaton to kubernetes"
# k8s-deploy-and-verify
minikube-deploy

is_success "Deployment completed successfuly"
