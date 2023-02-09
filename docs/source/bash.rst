BASH
====

- source vs execution:
    When a script is run using 'source' it runs within the existing shell, any variables created or modified by the script will remain available after the script completes.
    If a script is executed, then a separate subshell (with a separate set of variables) will be spawned to run the script. 

NOTE: source and '.' are sinonims for bash
    . filename [arguments] 
    source filename [arguments]