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
  zlib/1.2.11

  # using build tools as conan packages
  [tool_requires]
  cmake/3.22.6
 
  [generators]
  CMakeDeps # enable find_package() use, https://docs.conan.io/2/reference/tools/cmake/cmakedeps.html#conan-tools-cmakedeps
  CMakeToolchain # generates -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake from current package configuration, settings, and options.

If we add the *tool_requires* it automatically invoking a **VirtualBuildEnv** generator and generates *${BUILD_FOLDER}/conanbuild.sh*
that sets some environment variables like a new PATH that we can use to inject to our environment the location of CMake v3.22.6.
To activate the virtual environment source the script:

.. code-block:: console

  /connanfile/txt/path:$ source ${BUILD_FOLDER}/conanbuild.sh

[conan **install**]
~~~~~~~~~~~~~~~~~~~

To install dependencies (direct dependencies and transitive dependencies), download binaries or the source code and build if no exist (or specified by us).
By default try with all the remotes configured, if we want to restrict to certain can add **-r <remote_name>** option (see :ref:`[conan **remote**]`). 

.. code-block:: console

  /connanfile/txt/path:$ conan install . --output-folder=${BUILD_FOLDER} --build=missing
  /connanfile/txt/path:$ cmake . -B ${BUILD_FOLDER} -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
  /connanfile/txt/path:$ cmake --build ${BUILD_FOLDER}


Conan generates helper build system files containing variables to consume later in the build folder (+V+ IMPROVE)