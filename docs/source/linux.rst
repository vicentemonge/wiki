Linux
=====

Shortcuts
---------
- Maximize/unmaximize window: ALT + F10
- Move app between workspace: SUPER + SHIFT + PAGE UP/DOWN

- Unlock events: cat /var/log/auth.log | grep unlocked

Install
------------------------------

.. code-block:: console

    $ sudo dpkg -i package_with_unsatisfied_dependencies.deb
    dpkg: dependency problems prevent ... 
    [additional messages]

    $ sudo apt-get -f install
    [apt messages]
    Setting up [dependency]...
    Setting up package_with_unsatisfied_dependencies...

    $ # OR

    $ sudo apt install package_with_unsatisfied_dependencies.deb


Commands
------------------------------

**alias** list all the alias

**GREP** https://man7.org/linux/man-pages/man1/grep.1.html

    --exclude-dir=, to skip folders if -r option
    --include=, wildcarded pattern to match files
    --exclude=, wildcarded pattern to match files
    -l, print the name of each file with matches
    -I, skip binaries
    -r, recursive
    -R, recursive follow simbolic links
    -n, print line number
    -H, print file name
    -w, exact match

**ssh-copy-id** install a ssh key to remote host to be authenticated without password

.. code-block:: console

    ssh-copy-id -i /home/<local-user>/.ssh/id_rsa.pub <remote-user>@IP

**tree** paint the file tree, brief:
    -a, hide files
    -h, size in human readable
    -D, date timer
    -L level, deep level
    -P pattern, display only match pattern
    -I pattern, skip match pattern
    [<directory list>], list of directories





