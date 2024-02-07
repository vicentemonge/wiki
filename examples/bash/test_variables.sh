#!/bin/bash

EMPTY_VARIABLE=""

if [ -z EMPTY_VARIABLE ]; then
    echo "empty by name"
fi
if [ -z $EMPTY_VARIABLE ]; then
    echo "empty by content"
fi
if [ -z "${EMPTY_VARIABLE}" ]; then
    echo "empty by content2"
fi

EMPTY_VARIABLE2=

if [ -z EMPTY_VARIABLE2 ]; then
    echo "empty2 by name"
fi
if [ -z $EMPTY_VARIABLE2 ]; then
    echo "empty2 by content"
fi
if [ -z "${EMPTY_VARIABLE2}" ]; then
    echo "empty2 by content2"
fi