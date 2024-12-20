BASH
====

- source vs execution:
    When a script is run using 'source' it runs within the existing shell, any variables created or modified by the script will remain available after the script completes.
    If a script is executed, then a separate subshell (with a separate set of variables) will be spawned to run the script. 

NOTE: source and '.' are sinonims for bash
    . filename [arguments] 
    source filename [arguments]

some commands (more commands on linux section)
-------------------------------------------------------------------

- Delete files except some:

.. code-block:: console

    $ shopt -s extglob # to activate extended file pattrens handling by bash
    $ rm !("filename1"|"filename2") # deletes all files on this folder but "filename1" and "filename2"
    $ rm !(*.ext) # deletes all files on this folder except those with .ext extension
    $ rm !(*.ext|*.ext2) # same with .ext2 too
    $ shopt -u extglob # deactivate extglob

- My template header:

.. code-block:: console

    # current path for commands in scripts is the EXECUTION_DIR
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    SCRIPT_NAME="$( basename "${BASH_SOURCE[0]}" )"
    EXECUTION_DIR="$( pwd )"

(See template file *templates/bash.sh*)

- Numeric comparison:

    -eq: equal to
    -ne: not equal to
    -lt: less than
    -le: less than or equal to
    -gt: greater than
    -ge: greater than or equal to

- Check variables:

    -n: not empty
    -z: empty

- Check last command ok:

.. code-block:: console

    some-command
    if [ $? -eq 0 ]; then
    echo "The command was successful"
    else
    echo "The command failed"
    fi

- Check params number:

.. code-block:: console

    if [ -z $4 ]; then # check we have 4 parameters at least
        echo $USAGE
        exit 1
    fi

    if [ "$#" -ne 4 ]; then # check we have 4 parameters exactly
        echo $USAGE
    fi

    # Check if at least one argument is passed
    if [ "$#" -ge 1 ]; then
        echo "Well done!"
    else
        echo $USAGE
    fi


- Check file exist:

    -e: true if the path exist (file or folder)
    -f: true if the path is a regular file
    -d: true if the path is a directory
    -s: true if the file exists and has a size greater than zero

- Check absolute path:

.. code-block:: console

    if [[ "$path" = /* ]]; then
    echo "ABSOLUTE"
    else
    echo "RELATIVE"
    fi

.. code-block:: console

    if [ ! -d /path/to/directory ]; then
        mkdir /path/to/directory
    fi

- Exit against whatever error:

.. code-block:: console

    #!/bin/bash -e

    # or
    set -e # enable the -e option, and more visible

    # do some commands that may fail
    command1
    command2
    command3

    # if we get here, all commands succeeded
    echo "All commands succeeded"

    # too is possible to set in this way
    set -e # enable the -e option
    set +e # disable the -e option

- Debug mode, print each command before execute:

.. code-block:: console

    #!/bin/bash

    set -x # enable the -x option
    set +x # disable the -x option

- **AWK**
.. code-block:: console

    # basic syntax
    $ awk -F 'separator' '/pattern/ { action }' input-file
    # print lines start by start word and the second column separated by ' ' and '.'
    $ awk -F '[ |.]'/^start/' { print $2 }'

- **Parameter handling**

(See the example *examples/bash/handling_options_and_arguments.sh*)

- Lists

.. code-block:: console
    
    $ list_size = ${#list[@]}

PATH STACK
------------------------------

- Easy to go and return from directories: // +V+ improve

.. code-block:: console

    $ pushd
    $ popd


**Grouping commands**
-----------------------

**;**

If you want to **run multiple commands consecutively**, i.e., run the next command after the previous one finishes, use the semicolon (;).

**()**

    ( list )

    Placing a list of commands between parentheses **forces the shell to create a subshell** (see Command Execution Environment), and each of the commands in list is executed in that subshell environment. Since the list is executed in a subshell, variable assignments do not remain in effect after the subshell completes.

**{}**

    { list; }

    Placing a list of commands between curly braces causes the list to be **executed in the current shell context**. No subshell is created. The semicolon (or newline) following list is required. 


**LOOPS**
-----------------------

- **Iterate over a list**

.. code-block:: console

    # by elements

    for line in "${lines[@]}"; do
        echo "|$line|"
    done

    # by index

    for index in "${!lines[@]}"; do
        # Access the element at the current index
        line="${lines[$index]}"
        
        # Print the index and the corresponding line
        echo "Index: $index, Line: |$line|"
    done

    # c like for

    start=5
    max=10
    for ((i = start; i <= max; i++)); do
        echo "Current value: $i"
    done

    #by range

    # Nested loop
    for i in {1..3}; do
        echo "Outer loop iteration: $i"
        for j in {1..3}; do
            echo "Inner loop iteration: $j"
            if [ $i -eq 2 ] && [ $j -eq 2 ]; then
                break 2  # Break out of both outer and inner loops
            fi
        done
    done