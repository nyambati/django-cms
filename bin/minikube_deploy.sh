#!/usr/bin/env  bash
set -eo pipefail

ROOT_DIR=`pwd`


# These variables are always set by default in the CI (circleci)
# since we are running this on local minikube we will need to set default values for them
set_ci_env_variables() {
    export CI_SHA1=$(git rev-parse --short HEAD)
    export CI_BUILD_NUM=$CI_SHA1
    export CI_TAG=$CI_SHA1
}

load_dependencies() {
    FILE_PATH=$ROOT_DIR/.env
    local _env_path=$1

    [ "$_env_path" ] && FILE_PATH=$_env_path

    [ ! -f $FILE_PATH ] && cp $ROOT_DIR/.env.sample $FILE_PATH

    . $FILE_PATH
    . $ROOT_DIR/bin/utils.sh
    . $ROOT_DIR/bin/template.sh
}

base_64_encode_variables() {
    POSTGRES_PASSWORD=$(base_64_encode $POSTGRES_PASSWORD $BASE_64_ARGS)
}

lint_and_build_config_templates() {
    info "Linting configuration files"
    find_tempate_files "TEMPLATES"
    base_64_encode_variables
    find_and_replace_variables
    k8s-lint
    is_success "Linting completed successfuly"
}

build_and_push_docker_image() {
    info "Building docker image"
    docker-build
    is_success "Image was built successfuly"

    info "Push built image to registry"
    docker-push
    is_success "Image was pushed successfuly"
}

deploy_to_minikube_cluster() {
    info "Deploy appliaton to kubernetes"
    # k8s-deploy-and-verify
    minikube-deploy

    is_success "Deployment completed successfuly"
}


main() {
    load_dependencies
    set_ci_env_variables
    lint_and_build_config_templates
    build_and_push_docker_image
    deploy_to_minikube_cluster
}

$@
