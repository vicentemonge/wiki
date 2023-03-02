git
===

bisect
------

Helps you to find a malicious commit knowing a good older one and a newer bad by dichotomic search and checkout to the
last good (https://git-scm.com/docs/git-bisect)

Example from here https://www.metaltoad.com/blog/beginners-guide-git-bisect-process-elimination

.. code-block:: console

    $ git bisect start BAD_SHA GOOD_SHA
    $ # or
    $ git bisect start
    $ git bisect bad BAD_SHA
    $ git bisect good GOOD_SHA
    $ # then git checkout to a commit in the middle and you need to evaluate it a tell to git is a bad or good one
    $ git bisect [bad,good]
    $ # continue the process until find the last good...
    $ # to end the process use reset
    $ git bisect reset 
    $ git bisect reset SHA # to specify a commit

You can give the evaluation command or script to make git self-sufficient to find the commit by itself. The
script/command should exit with code **0 if the current source code is good/old**, and exit with a code **between 1 and
127 (inclusive), except 125**, if the current source code is **bad/new**.
The special exit code **125** should be used when the current source code cannot be tested (git bisect skip).

.. code-block:: console

    $ git bisect start BAD_SHA GOOD_SHA
    $ git bisect run MY_SCRIPT ARGUMENTS
    $ # or
    $ git bisect run make test # "make test" builds and tests
    $ # or
    $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh" # if do not compiles can't be tested and skip it

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

tag
---

 - list tags

.. code-block:: console

    $ git tag
    $ git tag -l <pattern>


