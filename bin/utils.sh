#!/usr/bin/env  bash

ROOT_DIR=`pwd`

BOLD='\e[1m'
BLUE='\e[34m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[92m'
NC='\e[0m'

info() {
    printf "\n${BOLD}${BLUE}====> $(echo $@ ) ${NC}\n"
}

warning () {
    printf "\n${BOLD}${YELLOW}====> $(echo $@ )  ${NC}\n"
}

error() {
    printf "\n${BOLD}${RED}====> $(echo $@ )  ${NC}\n"
    exit 1
}

success() {
    printf "\n${BOLD}${GREEN}====> $(echo $@ ) ${NC}\n"
}

is_success() {
    if [ $? -eq 0 ]; then success $@; else exit 1; fi
}

# require "variable name" "value"
require () {
    if [ -z ${2+x} ]; then error "Required variable ${1} has not been set"; fi
}

base_64_encode () {
    if [ -z ${1+x} ]; then error "The value supplied is empty"; fi
    echo $1 | base64 $2 $3
}

find_tempate_files() {
    local _yamlFilesVariable=$1
    local _templates=$(find $ROOT_DIR/deploy -name "*.tpl" -type f)
    if [ "$_yamlFilesVariable" ]; then
        eval $_yamlFilesVariable="'$_templates'"
    else
        echo $_templates;
    fi
}

find_and_replace_variables() {
    for file in ${TEMPLATES[@]}; do
        local output=${file%.tpl}
        cp $file $output
        info "Building $(basename $file) template"
        for variable in ${VARIABLES[@]}; do
            local value=${!variable}
            sed -i -e "s/{{ $variable }}/$value/g" $output;
            sed -i -e "s/{{$variable}}/$value/g" $output;
        done

        if [[ $? == 0 ]]; then
            success "Template file $(basename $file) has been built successfuly"
        else
            error "Failed to build template $(basename $file)"
        fi
    done
    info "Cleaning backup files after substitution"
    rm -rf deploy/*-e
    rm -rf deploy/*.yml-*
}

if [ `uname` == 'Linux' ]; then
    export BASE_64_ARGS='-w 0'
fi
