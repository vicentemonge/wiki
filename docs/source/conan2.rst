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

.. note::

  **VERSIONING IN RANGES** We can specified a version for packages, tools, etc. in ranges:

    XXX/[~1.2]    -> 1.2.X picking the last available
    XXX/[<1.2.12] -> 1.2.11 or lower
    XXX/[>1.2.12] -> 1.2.13 or greater

def **requirements** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add requirements to this package

def **build_requirements** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def **layout** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Declares the locations where we expect to find the source files and also those where we want to save the generated files
during the build process. Things like the folder for the generated binaries or all the files that the Conan generators
create in the generate() method.

Instead of using *--output-folder* argument to define where we wanted to create the files that Conan generates we can
use the more powerful **layout** method and we can add some logic or reuse a predefined layout like cmake_layout in the
example above.

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

**profile:build (pr:b)**: This is the profile that defines the platform where the binaries will be built.

**profile:host (pr:h)**: This is the profile that defines the platform where the built binaries will run. Raspberry Pi example:

.. code-block:: text
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

  Example:
.. code-block:: console

  $ conan install . --build=missing --options=zlib/1.2.13:shared=True --profile:host=profiles/raspberry
  $ source build/Release/generators/conanbuild.sh
  $ cmake -B build . -DCMAKE_TOOLCHAIN_FILE=Release/generators/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
  $ cmake --build build/
  $ file ./build/compressor
  /build/compressor: ELF 32-bit LSB pie executable, ARM, EABI5 version 1 (SYSV), dynamically linked,
  interpreter /lib/ld-linux-armhf.so.3, BuildID[sha1]=2d32469207447b8c941b0ce4a8c72cb531b44263,
  for GNU/Linux 3.2.0, not stripped

Revisions
~~~~~~~~~~~~~~~~~~~~~

  The recipe revision is the hash that can be seen together with the package name and version in the form
  pkgname/version#recipe_revision or pkgname/version@user/channel#recipe_revision.
  If we modify the recipe or the source code, Conan changes the revision of the package.

Lockfile
##################


  If we can lock a exact package version#revision we can generate a *conan.lock* file and then it is used by default
  *conan install . == conan install . --lockfile=conan.lock*:

.. code-block:: console

  $ conan lock create .

.. code-block:: json

  {
    "version": "0.5",
    "requires": [
        "zlib/1.2.11#4524fcdd41f33e8df88ece6e755a5dcc%1650538915.154"
    ],
    "build_requires": [],
    "python_requires": []
  }



Creating packages
----------------------


[conan **new**]
~~~~~~~~~~~~~~~~~~~

Creates template files to be filled later to create the package.

.. code-block:: console

    $ conan new <template> -d name=XXX -d version=XXX
    # for example
    $ conan new cmake_lib -d name=hello -d version=1.0

.. code-block:: python

  from conan import ConanFile
  from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout

  class helloRecipe(ConanFile):
    name = "hello"
    version = "1.0"

    # Optional metadata
    license = "<Put the package license here>"
    author = "<Put your name here> <And your email here>"
    url = "<Package recipe repository url here, for issues about the package>"
    description = "<Description of hello package here>"
    topics = ("<Put some tag here>", "<here>", "<and here>")

    # Binary configuration
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}

    # Sources are located in the same place as this recipe, copy them to the recipe
    # exports_sources = "CMakeLists.txt", "src/*", "include/*"
    # or obtain trough git url

    def source(self):
        git = Git(self)
        git.clone(url="https://github.com/conan-io/libhello.git", target=".") # "." use same folder instead subfolder
        # git.checkout("<tag> or <commit hash>")

    def config_options(self):
        if self.settings.os == "Windows":
            del self.options.fPIC

    def layout(self):
        cmake_layout(self)

    def generate(self):
        tc = CMakeToolchain(self)
        tc.generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        # Using bare commands instead a helper:
        # from local source folder files *.h to local package cache include folder
        # self.copy("*.h", dst="include", src="source  ")
        # self.copy("*.a", dst="lib", keep_path=False)
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        self.cpp_info.libs = ["hello"]
        # self.cpp_info.libdirs = ["lib"] # default value, directories to search the lib
        # self.cpp_info.includedirs = ["include"] # default value, directories to search the headers

**Class ConanFile attributes**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**name**: a string, with a minimum of 2 and a maximum of 100 lowercase characters that defines the package name. It should start with alphanumeric or underscore and can contain alphanumeric, underscore, +, ., - characters.
**version**: It is a string, and can take any value, matching the same constraints as the name attribute. In case the version follows semantic versioning in the form X.Y.Z-pre1+build2, that value might be used for requiring this package through version ranges instead of exact versions.
**exports_sources**: is set to define which sources are part of the Conan package.

**Class ConanFile methods**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def **source** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Execute whatever command to obtain the sources. 2 git examples above:

.. code-block:: python

  from conan.tools.files import get
  ...
  def source(self):
      get(self, "https://github.com/conan-io/libhello/archive/refs/heads/main.zip",
                strip_root=True)

  from conan.tools.scm import Git
  ...
  def source(self):
      git = Git(self)
      git.clone(url="https://github.com/conan-io/libhello.git", target=".")
      #git.checkout("<tag> or <commit hash>")

  from conan.tools.files import update_conandata
  ...
  def export(self):
      git = Git(self, self.recipe_folder)
      scm_url, scm_commit = git.get_url_and_commit()
      self.output.info(f"Obtained URL: {scm_url} and {scm_commit}")
      # we store the current url and commit in conandata.yml
      update_conandata(self, {"sources": {"commit": scm_commit, "url": scm_url}})

  def source(self):
      # we recover the saved url and commit from conandata.yml and use them to get sources
      git = Git(self)
      sources = self.conan_data["sources"]
      self.output.info(f"Cloning sources from: {sources}")
      git.clone(url=sources["url"], target=".")
      git.checkout(commit=sources["commit"])

.. note::

   The source method must have invariant results between repetitions. Using git perform a checkout to a commit or
   invariant tag is the recommended way. The third option store url and commit information on a **conanfile.yml** file
   inside the recipe when calling *conan create* and reads when sources need to be obtained (create, install, etc).

def **requirements** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add requirements to this package.

def **configure**(self) 
~~~~~~~~~~~~~~~~~~~~~~~~

Allows configuring settings and options while computing dependencies

def **config_options**(self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configure options while computing dependency graph.

def **generate**(self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This method prepares the build. In this case, CMakeToolchain generate() method will create a conan_toolchain.cmake file
that translates the Conan settings and options to CMake syntax.

def **build** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Responsable to invoque the build system and launch the tests.
We can use **self.run** for execute whatever command but Conan provide helper classes for most popular system as cmake,
msbuild, autotools, etc.

def **package** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Responsable to capture artifacts produced by the build system.

We use here **self.copy** to copy from local filesystem to Conan local cache.

def **package_info** (self)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Define variables available for the package consumers that store in a special dictionary **cpp_info** and that they must
be know to consume them.

A special kind of test: **test_package**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is a new kind of test that checks if the conan package and package_info method are completely correct and the package
directory has the necessary files in all the right folders and can be consumed correctly.
It doesn’t belong in the package. It only exists in the source repository, not in the package.

[conan **list**]
~~~~~~~~~~~~~~~~~~~

This command lists the recipes and binaries stored in the local cache. You can found if you are specific:

.. code-block:: console

  $ conan list <name>/<version>#<revision>:<package_id>
  $ conan list <name>#:* # for all

[conan **create**]
~~~~~~~~~~~~~~~~~~~

Creates the package on local cache (builds happen in local cache too). Accept same parameters as *conan install*:

.. code-block:: console

  $ conan create . -s build_type=Debug -o hello/1.0:shared=True



