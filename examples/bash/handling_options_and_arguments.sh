#!/bin/bash

# Initialize variables
option=""
list=()

# Loop through command-line arguments
# NOTE: for loop do not accept internal 'shift' to cut the list
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            echo -e "\n+ option: '$1'"

            # Display help message
            echo "Usage: myscript.sh [-h|--help] [-v|--verbose] [-o|--option value] [-l|--list val1 val2 ...]]"
            exit 0
            ;;
        -v|--verbose)
            echo -e "\n+ option: '$1'"
            option="$1"
            shift # remove -v/--verbose from param list

            # Enable verbose mode
            verbose=true
            ;;
        -f|--field) # --field value
            echo -e "\n+ option: '$1'"
            option="$1"
            shift # remove -f/--field from param list

            field="$1"
            echo "  arg: '$1'"
            shift
            ;;
        -l |--list)
            echo -e "\n+ option: '$1'"
            option="$1"
            shift  # remove -l/--list from param list

            for arg in "$@" ; do
                if [[ "$1" == -* ]]; then break; fi # if new option break loop

                echo "  arg: '$1'"
                list+=("$1")
                shift # remove list argument of -l/--list option from param list
            done
            ;;
        *)
            # Handle other arguments
            echo "Invalid argument: $arg" >&2
            exit 1
            ;;
    esac
done

echo ""
echo "last_option: $option"
echo "field: $field"
echo "list: ${list[*]}"

# Rest of your script here
