#!/bin/bash

var1="pep"

function local_life(){
    local var2="pap"
    
    if [[ $var1 == "pep" ]]; then
        echo "var1 = pep"
    else
        local var3="pip"
    fi
    if [[ $var2 == "pap" ]]; then
        echo "var2 = pap"
    fi
    if [[ $var3 == "pip" ]]; then
        echo "va3 = pip"
    fi
    
}

local_life