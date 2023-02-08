git
===

diff
----
.. code-block:: console
    $ git diff --name-only # list file names changed
    file1
    file2
    file3
    $ git diff --name-status # list file names preceded by A (added), D (deleted), M (modified) 
    A file1
    D file2
    M file3
    $ git diff --name-status --diff-filter=d # add a filter to hide deleted files, all options are --diff-filter=ACMRTUXBD
    A file1
    M file3