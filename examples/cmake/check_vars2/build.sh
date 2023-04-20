#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_NAME="$( basename "${BASH_SOURCE[0]}" )"
EXECUTION_DIR="$( pwd )"

cd $SCRIPT_DIR

build_folder=build

cd $SCRIPT_DIR

cmake . -B $build_folder -DVAR1=false -DVAR2=0 -DVAR3=off -DVAR4=no -DVAR5= 