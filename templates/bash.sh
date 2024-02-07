#!/bin/bash

# current path for commands in scripts is the EXECUTION_DIR
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# same but seeking symlinks
SCRIPT_DIR="$( cd "$( dirname $(realpath "${BASH_SOURCE[0]}" ))" && pwd )"

SCRIPT_NAME="$( basename "${BASH_SOURCE[0]}" )"
EXECUTION_DIR="$( pwd )"

#source "${SCRIPT_DIR}/common.sh"