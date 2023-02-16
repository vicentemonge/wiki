BASH
====

- source vs execution:
    When a script is run using 'source' it runs within the existing shell, any variables created or modified by the script will remain available after the script completes.
    If a script is executed, then a separate subshell (with a separate set of variables) will be spawned to run the script. 

NOTE: source and '.' are sinonims for bash
    . filename [arguments] 
    source filename [arguments]

some commands
-------------

- Delete files except some:

.. code-block:: console

    $ shopt -s extglob # to activate extended file pattrens handling by bash
    $ rm !("filename1"|"filename2") # deletes all files on this folder but "filename1" and "filename2"
    $ rm !(*.ext) # deletes all files on this folder except those with .ext extension
    $ rm !(*.ext|*.ext2) # same with .ext2 too
    $ shopt -u extglob # deactivate extglob