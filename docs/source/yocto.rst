YOCTO
=====

Installing
----------

.. code-block:: console    
    
    $ git clone -b kirkstone git://git.yoctoproject.org/poky.git

This creates a **working directory** for you named **build-myproject/** and makes it the current directory. All of the configuration, as well as any intermediate and target image files, will be put in this directory. You must source this script each time you want to work on this project.
    .. code-block:: console
    
    $ source poky/oe-init-build-env build-myproject

**build-myproject/conf/**, which contains the following configuration files for this project:
- **local.conf**: This contains a specification of the device you are going to build and the build environment. We select a machine:
.. code-block:: text

    MACHINE ?= "qemuarm"

- **bblayers.conf**: This contains the paths of the meta layers you are going to use.

Building
--------