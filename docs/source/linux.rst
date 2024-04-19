Linux
=====

Shell startup
--------------

**~/.profile** (executed if no ~/.bash_profile or no ~/.bash_login exists):
load **.bashrc** and add user's private bin to the PATH PATH="$HOME/bin:$PATH"  PATH="$HOME/.local/bin:$PATH"

File/folder permissions/owner
---------------------------------

Read, write and execute permissions in format **drwxrwxrwx N <user> <group>**

directory or file (d or -)
first rwx: owner permissions over file
second rwx: group permissions over file
third rwx: everyone permissions over files

To change permissions: **chmod** ABC file/-R folder # A = 4(r) + 2(w) + 1(x)
To change owner: **chown** [user]:[group] file/-R folder

.. code-block:: console

    $ chmod -R 755 /one/directory # -R recursively
    $ chown -R vmonge:vmonge /one/directory

Shortcuts
---------
- Maximize/unmaximize window: ALT + F10
- Move app between workspace: SUPER + SHIFT + PAGE UP/DOWN

- Unlock events: cat /var/log/auth.log | grep unlocked

PACKAGES
------------------------------

Install
~~~~~~~~~~~~~~~~~~~~~~~

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

Package versions
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

    $ apt install
    $ dpkg --list

System queue
-----------------

List mq queues:

.. code-block:: console

    $ ll /dev/mqueue/


Services
-----------------

Status of a service: **systemctl status service_name**
Enable a service: **systemctl enable service_name**
Disable a service, do not launch next reboot: **systemctl disable service_name** 
Start a service: **systemctl start service_name**
Stop a service: **systemctl stop service_name**
Logs from service: **journalctl -u service_name**
Follow logs from service: **journalctl -u service_name -f**
See running service: **systemctl --state=running**
See present service: **systemctl --type=service**
Binary of a service: **systemctl show --property=ExecStart service_name**

journalctl
-----------------

Retain only the past two days:

journalctl --vacuum-time=2d

Retain only the past 500 MB:

journalctl --vacuum-size=500M


Commands
------------------------------

**alias** list all the alias

**original aliased command**

You can bypass aliases by the following methods:

    the full pathname of the command: **/bin/ls**

    command substitution: **$(which ls)**

    the command builtin: **command ls**

    double quotation marks: **"ls"**

    single quotation marks: **'ls'**

    a backslash character: **\ls**

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
    -c, --count, print a count of matching lines for each input file
    -v, --invert-match, non-matching lines.

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


**find**

Execute a command by each match:

.. code-block:: console

    -exec [COMMAND] {} \;
    
    # print each match \n\n and cat
    $ find -iname project.ini -exec bash -c "echo -e \"\n\n{}\" && cat -n \"{}\"" \;



**jq**

Lightweight JSON processor

.. code-block:: console

    $ curl XXXXX | jq > /to/file.json
    
    $ formatted_json=$(echo "$json_content" | jq .)

**ls**

-v	by name, naturel order (1 < 2 < 11)
-S	by size, largest first
-X	by extension, alphabetically
-t	by last modification date (mtime), newer first

**echo**
 
-n "no trailing newline" 
-e "interpret \n as new line"



**zip, rar, tar**

You can store **symlinks** as symlinks (as opposed to a copy of the file/directory they point to) using the --symlinks or -y
parameters of the zip program. Assuming foo is a directory containing symlinks:

.. code-block:: console

    zip --symlinks -r foo.zip foo/
    # or
    zip -y -r foo.zip foo/

    # Rar equivalent:
    rar a -ol foo.rar foo/

    #tar stores them as is by default.
    tar czpvf foo.tgz foo/




