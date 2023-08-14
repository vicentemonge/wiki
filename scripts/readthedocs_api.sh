#!/bin/bash

# current path for commands in scripts is the EXECUTION_DIR
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_NAME="$( basename "${BASH_SOURCE[0]}" )"
EXECUTION_DIR="$( pwd )"

source ${SCRIPT_DIR}/config.sh

CURL_HEADER="Authorization: Token ${API_TOKEN}"
# curl -X GET -H == curl -H
CURL_GET="curl -s -H '${CURL_HEADER}'"
CURL_POST="curl -s -X POST -H '${CURL_HEADER}'"

PROJECT_URL=https://readthedocs.org/api/v3/projects/${PROJECT_SLUG}
VERSION_URL=${PROJECT_URL}/versions/${VERSION_SLUG}
BUILDS_URL=${VERSION_URL}/builds


function check_command () {
    # Command to check for availability
    command_to_check=$1
    # Check if the command is available
    if ! command -v "$command_to_check" &> /dev/null; then
        echo "$command_to_check is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y "$command_to_check"
    else
        echo "$command_to_check is already installed."
    fi
}

function curl_get() {
    eval "${CURL_GET}" $@
}

function curl_post() {
    eval "${CURL_POST}" $@
}

function project_info() {
    curl_get ${PROJECT_URL}/ | jq
}

function versions() {
    curl_get ${PROJECT_URL}/versions/ | jq
}

function version_info() {
    curl_get ${PROJECT_URL}/versions/latest/ | jq
}

function builds() {
    # by default retrieve the last 10 results, for more ?limits=1000 o whatever
    # next page ${BUILDS_URL}/?limit=10&offset=10
    curl_get ${BUILDS_URL}/ | jq
}

function wait_build() {
    before_build_timestamp=$1
    while (true); do
        res=$(curl_get ${BUILDS_URL}/)
        build_date_string=$(echo "$res" | jq -r '.results[0].created')
        # Convert date string to Unix timestamp
        build_timestamp=$(date -d "$build_date_string" +"%s")
        if [ "$build_timestamp" -ge "$before_build_timestamp" ]; then
            state=$(echo "$res" | jq -r '.results[0].state.code')
            if [ "$state" == "finished" ]; then
                echo "build finished !!"
                break
            else
                printf "."
            fi
        else
            echo "Building older than triggered..."
        fi
        sleep 1 
    done
}

function trigger_build() {
    triggered=$(curl_post ${BUILDS_URL}/ | jq -r '.triggered')
    if [ "$triggered" == "true" ]; then
        echo "OK, build triggered"
    else
        echo "### FAIL TO TRIGER A BUILD !! ###"
        return 1
    fi
}

function push_and_build() {
    current_timestamp=$(date +"%s")
    git ci -am "up" && git push && \
    trigger_build && \
    wait_build "$current_timestamp"
}

check_command jq