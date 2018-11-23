#!/usr/bin/env  bash

ROOT_DIR=`pwd`

. $ROOT_DIR/bin/utils.sh

IMAGE_TAG=`git rev-parse --short HEAD`
VARIABLES=(
    'NAMESPACE' 'IMAGE_TAG' 'PORT' 'PROJECT_NAME'
    'POSTGRES_PASSWORD' 'CONTAINER_REGISTRY'
)

# Image tag and namespace should be diffrent based on branches
if [ "$CIRCLE_BRANCH" == 'master' ]; then
    NAMESPACE=production
else
    NAMESPACE=staging
fi

# Default variable values
PORT=${PORT:=8000}
PROJECT_NAME=${PROJECT_NAME:=fluffy}
# Ensure that all the required variables have been set
require VARIABLES $VARIABLES
require NAMESPACE $NAMESPACE
require IMAGE_TAG $IMAGE_TAG
require PORT $PORT
require PROJECT_NAME $PROJECT_NAME
require POSTGRES_PASSWORD $POSTGRES_PASSWORD
require CONTAINER_REGISTRY $CONTAINER_REGISTRY
# Build template files for deployment.
# find_tempate_files "TEMPLATES"
# find_and_replace_variables
