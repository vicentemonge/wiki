CONAN2
======

**Install**
----------------------

https://docs.conan.io/2/installation.html

**conanfile.txt**
-----------------

Tell Conan our dependencies and our build system.
For that it has 2 sections corresponding on dependencies (*requires*) and build systems (*generators*).
We can add a *tool_requires* section to specify build tools as Conan packages instead using the installed one.

.. code-block:: text
  :lineno-start: 1

  [requires]
  zlib/1.2.13

  # using build tools as conan packages
  [tool_requires]
  cmake/3.22.6
 
  [generators]
  # enable cmake find_package() use, https://docs.conan.io/2/reference/tools/cmake/cmakedeps.html#conan-tools-cmakedeps
  CMakeDeps
  # generates conan_toolchain.cmake (-DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake) from current package configuration, settings, and options.
  CMakeToolchain


[conan **install**]
~~~~~~~~~~~~~~~~~~~

To install dependencies (direct dependencies and transitive dependencies), download binaries or the source code and build
if no exist (or specified by us).

.. code-block:: console

  /connanfile/txt/path:$ conan install . --output-folder=${BUILD_FOLDER} --build=missing
  /connanfile/txt/path:$ cmake . -B ${BUILD_FOLDER} -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
  /connanfile/txt/path:$ cmake --build ${BUILD_FOLDER}


Conan generates helper build system files containing variables to consume later in the build folder (+V+ IMPROVE)

BUILD CONFIGURATION MECHANISM
---------------------------------


**Settings** (project-wide configuration: build_type, compiler, architecture, etc) and **Options** (package-specific
configuration: shared, static, etc).

.. code-block:: console
  
  $ conan install . --output-folder=${BUILD_FOLDER} --build=missing --settings=build_type=Debug
  $ conan install . --output-folder=${BUILD_FOLDER} --build=missing --options=zlib/1.2.13:shared=True
  # zlib/1.2.13 package specify internally False value

  # this --options is equivalent than placed inside [options] section and overrides the value in the profile if exist:
  # [options]
  # zlib/1.2.13:shared=True


**Custom settings**: XXX
**Custom options**: XXX

PROFILES
---------------------------------

Help files to group options, settings and environment variables in a file to achieve control, repeatability and comfort.
When you build or install a package you can specify a profile with the option *--profile*.
If no profile is specified apply the **default** profile that need to be created the first time.
Conan have a default place for the profiles *${HOME}/.conan2/profiles* (you can check with *conan config home* command).

.. code-block:: console

  $ conan config home
  Current Conan home: ${HOME}/.conan2
  $ conan profile detect --force # creates default profile looking at current environment and tools installed.
  $ cat ${HOME}/.conan2/profiles/default
  [settings]
  arch=x86_64
  build_type=Release
  compiler=gcc
  compiler.cppstd=gnu14
  compiler.libcxx=libstdc++11
  compiler.version=10
  os=Linux
  [options]
  [tool_requires]
  [env]
  [buildenv]
  # This section is used to set the environment variables that are needed to build the binaries.

  More settings examples:
  build_type=Debug


SETTING VIRTUAL ENVIRONMENT
---------------------------------

Before build:

If we add the *tool_requires* it automatically invoking a **VirtualBuildEnv** generator which generates
*${BUILD_FOLDER}/conanbuild.sh* that sets some environment variables that affects building like a new PATH that we can
use to inject to our environment the location of CMake v3.22.6.
To activate the virtual environment source the script:

.. code-block:: console

  /connanfile/txt/path:$ source ${BUILD_FOLDER}/conanbuild.sh
  # to deactivate
  /connanfile/txt/path:$ source ${BUILD_FOLDER}/deactivate_conanbuild.sh

Before run:

Adding *shared=True* option make Conan invokes **VirtualRunEnv** generator which generates
*${BUILD_FOLDER}/conanrun.sh* that sets some environment variables that affects at running time like LD_LIBRARY_PATH.

.. code-block:: console

  (conan install . --output-folder=build --build=missing --options=zlib/1.2.13:shared=True)
  /connanfile/txt/path:$ source ${BUILD_FOLDER}/conanrun.sh
  # to deactivate
  /connanfile/txt/path:$ source ${BUILD_FOLDER}/deactivate_conanrun.sh

Recipe **conanfile.py**
~~~~~~~~~~~~~~~~~~~~~~~~~

It can be used for consuming packages, like in this case, and also to create packages.
For consuming packages is a powerful version of conanfile.txt where we put some logic using Python

**conanfile.txt**

.. code-block::

  [requires]
  zlib/1.2.13

  [tool_requires]
  cmake/3.22.6

  [generators]
  CMakeDeps
  CMakeToolchain

**conanfile.py**

.. code-block:: python

  from conan import ConanFile

  class CompressorRecipe(ConanFile):
      settings = "os", "compiler", "build_type", "arch"
      generators = "CMakeToolchain", "CMakeDeps"

      def requirements(self):
          self.requires("zlib/1.2.11")

      def build_requirements(self):
          self.tool_requires("cmake/3.22.6")

**extended conanfile.py**

.. code-block:: python

  import os

  from conan import ConanFile
  from conan.tools.cmake import cmake_layout
  from conan.errors import ConanInvalidConfiguration

  # Class name is free
  class CompressorRecipe(ConanFile):
      # This class attribute is related to how Conan manages binary compatibility
      # as these values will affect the value of the package ID for Conan packages.
      settings = "os", "compiler", "build_type", "arch"

      # This class attribute specifies which Conan generators will be run when we call the "conan install".
      generators = "CMakeToolchain", "CMakeDeps"

      # Depencies
      def requirements(self):
          self.requires("zlib/1.2.13")

      # Depencies
      def build_requirements(self):
          self.tool_requires("cmake/3.22.6")

      def layout(self):
        # We make the assumption that if the compiler is msvc the
        # CMake generator is multi-config
        multi = True if self.settings.get_safe("compiler") == "msvc" else False
        if multi:
            self.folders.generators = os.path.join("build", "generators")
        else:
            self.folders.generators = os.path.join("build", str(self.settings.build_type), "generators")

        # or predefined layout
        cmake_layout(self)

      def validate(self):
          if self.settings.os == "Macos" and self.settings.arch == "armv8":
              raise ConanInvalidConfiguration("ARM v8 not supported in Macos")



def **requirements** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def **build_requirements** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def **layout** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Instead of using *--output-folder* argument to define where we wanted to create the files that Conan generates we can
use the more powerful **layout** method and we can add some logic or reuse a predefined layout like the example above

def **validates** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This method is evaluated when Conan loads the conanfile.py and you can use it to perform checks of the input settings.

CROSS-COMPILING
---------------------------------

Conan really uses 2 profiles to build binaries:

.. code-block:: console

  $ conan install . --build=missing --profile=someprofile
  # is the same as
  $ conan install . --build=missing --profile:host=someprofile --profile:build=default

**profile:host**: This is the profile that defines the platform where the built binaries will run.

**profile:build**: This is the profile that defines the platform where the binaries will be built.

.. code-block:: console
  :emphasize-lines: 2,9,10,11,12

  [settings]
  arch=armv7hf
  build_type=Release
  compiler=gcc
  compiler.cppstd=gnu14
  compiler.libcxx=libstdc++11
  compiler.version=10
  os=Linux
  [buildenv]
  CC=arm-linux-gnueabihf-gcc-9
  CXX=arm-linux-gnueabihf-g++-9
  LD=arm-linux-gnueabihf-ld