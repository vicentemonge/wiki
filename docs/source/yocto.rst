YOCTO
=====

Installing
----------

.. code-block:: console    
    
    $ git clone -b kirkstone git://git.yoctoproject.org/poky.git

Preparing workspace
-------------------

.. code-block:: console
    
    $ source poky/oe-init-build-env build-myproject

This stablish all environment variables to start to work in the myproject project and creating if no exists a working
directory for you named **build-myproject/** and makes it the current directory. All of the configuration, as well as
any intermediate and target image files, will be put in this directory. You must source this script each time you want
to work on this project.

build-myproject/conf/
~~~~~~~~~~~~~~~~~~~~~

Contains the following configuration files for this project:

- **local.conf**: This contains a specification of the device you are going to build and the build environment. We select a machine:

.. code-block:: text

    MACHINE ?= "qemuarm"

- **bblayers.conf**: This contains the paths of the meta layers you are going to use.

Building
--------

Run BitBake, telling it **which root filesystem** image you want to create. It will work backward and build all the dependencies first, beginning with the toolchain.

.. code-block:: console
    
    $ bitbake core-image-minimal

.. note::
    
    **core-image-minimal**: This is a small console-based system that is useful for tests and as the basis for custom images.
    **core-image-minimal-initramfs**: This is similar to core-image-minimal but built as a ramdisk.
    **core-image-x11**: This is a basic image with support for graphics through an X11 server and the xterminal Terminal app.
    **core-image-full-cmdline**: This console-based system offers a standard CLI experience and full support for the target hardware.