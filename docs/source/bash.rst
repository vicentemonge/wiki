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

- Numeric comparison:

    -eq: equal to
    -ne: not equal to
    -lt: less than
    -le: less than or equal to
    -gt: greater than
    -ge: greater than or equal to

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


- Check file exist:

    -e: true if the path exist (file or folder)
    -f: true if the path is a regular file
    -d: true if the path is a directory
    -s: true if the file exists and has a size greater than zero

- Check abolute path:

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

    # do some commands that may fail
    command1
    command2
    command3

    # if we get here, all commands succeeded
    echo "All commands succeeded"

    # too is possible to set in this way
    set -e # enable the -e option
    set +e # disable the -e option


PATHS
------------------------------