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

Run BitBake, telling it **which root filesystem** image you want to create. It will work backward and build all the
dependencies first, beginning with the toolchain.

.. code-block:: console
    
    $ bitbake core-image-minimal

.. note::

    **core-image-minimal**: This is a small console-based system that is useful for tests and as the basis for custom images.
    **core-image-minimal-initramfs**: This is similar to core-image-minimal but built as a ramdisk.
    **core-image-x11**: This is a basic image with support for graphics through an X11 server and the xterminal Terminal app.
    **core-image-full-cmdline**: This console-based system offers a standard CLI experience and full support for the target hardware.

This genererates several folders inside build-myproject:

- downloads/: all the source.
- tmp/work/: staging area for the root filesystem
- deploy/images/[machine name]/: Contains the bootloader, the kernel and the root filesystem images ready to be run on the target.
- deploy/rpm/: This contains the RPM packages that make up the images.

Layers
------

.. code-block:: console
    
    $ bitbake-layers show-layers

The metadata for the Yocto Project is structured into layers. By convention, each layer has a name beginning with meta.
The core layers of the Yocto Project are as follows:

- meta: This is the OpenEmbedded core and contains some changes for Poky.
- meta-poky: This is the metadata specific to the Poky distribution.
- meta-yocto-bsp: This contains the board support packages for the machines that the Yocto Project supports.

Each meta layer need to has a **conf/layer.conf** config file

build-myproject/conf/bblayers.conf
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Stores the list of layers in which BitBake searches for recipes and, by default, includes all three layers mentioned in
the preceding list. Useful list of  layers: http://layers.openembedded.org/layerindex/

Adding a layers is add a location to that file.

README, need to be read for dependencies, version, etc.

Create
~~~~~~

.. code-block:: console
    
    $ source poky/oe-init-build-env build-nova
    $ bitbake-layers create-layer nova
    $ mv nova ../meta-nova

Add itself to BBPATH, BBFILES, BBFILE_COLLECTIONS variables.

Adding
~~~~~~

.. code-block:: console

    $ bitbake-layers add-layer ../meta-nova

Bitbake and recipes
-------------------

- Recipes: **.bb** files info about get the source code, dependencies, build and install.
- Append: **.bbappend** override or extend .bb file.
- Include: **.inc** recipes common info that can be added by **require**(fails if no exist) or **include**(not fail).
- Classes: **.bbclass** common build info that can be inherited by **inherit** word. The classes/base.bbclass class is
implicitly inherited in every recipe.
- Configuration: **.conf** define variables to govern build process.

    
