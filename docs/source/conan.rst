CONAN
=====

.. image:: ../images/conan_overview.png
  :width: 600
  :alt: Alt text que no se para que vale

- Dependencies are placed typically on code, on build system files and now on Conan recipes to resolve them.

- **conanfile.txt** with 2 sections corresponding on dependencies (*requires*) and build systems (*generators*)

.. code-block:: text
  :lineno-start: 1

   [requires]
   Poco/1.7.2@lasote/stable

   [generators]
   cmake

.. note::
  
  pkg/0.1@user/channel is called the **recipe reference**

- **Conan Center Index** [https://github.com/conan-io/conan-center-index] is the source index of recipes of the ConanCenter package repository for Conan.

.. image:: ../images/conan_center_index.png

- [conan **install**] To install dependencies (direct dependencies and transitive dependencies):
.. code-block:: console

  /connanfile/txt/path:$ mkdir build && cd build/ && conan install ..
  # downloads the binary packages (Release by default) if exists or the source code eoc
  # to specify build version:
  # conan install .. -s build_type=Debug

And to generates **conanbuildinfo.cmake** with CONAN cmake variables that I can to use in my CMakeLists.txt:
.. code-block:: cmake
  
  ...
  include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  conan_basic_setup()
  ...
  target_link_libraries(project_name ${CONAN_LIBS})
  #some times needed:
  #target_link_libraries(project_name CONAN_PKG::poco)
  ...

- [conan **info**] To show the dependecies graph as text:
.. code-block:: console

  /connanfile/txt/path/build:$ conan info ..

.. note::
  
  ${HOME}/.conan* is our local cache folder

- [**build**] Now we can compile our code:
.. code-block:: console

   /connanfile/txt/path/build:$ cmake .. -DCMAKE_BUILD_TYPE=Debug
   /connanfile/txt/path/build:$ cmake --build .

- [conan **search**] To show local cache, all connan packages and their versions are available in my local system. To see info of a specific package can type:
.. code-block:: console

   $ conan search # to get all packages by its recipe reference pkg/0.1@user/channel
   $ conan search pkg # filter by filter short name
   $ conan seach pkg@ # to show details TODO: undertand how its works, pkg@ or pkg/0.1@user/channel@ ...

.. code-block:: console

conan@48674d6a3546:~/training/consumer/build$ conan search zlib/1.2.13@
Existing packages for recipe zlib/1.2.13:

    Package_ID: 19729b9559f3ae196cad45cb2b97468ccb75dcd1
        [options]
            fPIC: True
            shared: False
        [settings]
            arch: x86_64
            build_type: Release
            compiler: gcc
            compiler.version: 10
            os: Linux
        Outdated from recipe: False

    Package_ID: 75e99b627c196b65c439728670655ec3c366b334
        [options]
            fPIC: True
            shared: False
        [settings]
            arch: x86_64
            build_type: Debug
            compiler: gcc
            compiler.version: 10
            os: Linux
        Outdated from recipe: False


Building your own packages
------------------------

- Create recipe file **conanfile.py**:
.. code-block:: python

  from conans import ConanFile, AutoToolsBuildEnvironment
  from conans import tools

  class HelloConan(ConanFile):
    name = "hello"
    version = "0.1"
    settings = "os", "compiler", "build_type", "arch"
    
    def build(self):
        self.run("git clone https//github/memshared/hello.git")

    def build(self):
        cmake = CMake(self.settings)
        self.run('cmake hello %s' % (cmake.command_line))
        self.run("cmake --build . %s" % cmake.build_config)

    def package(self):
        self.copy("*.h", dst="include", src="hello  ")
        self.copy("*.lib", dst="lib", keep_path=False)
        self.copy("*.a", dst="lib", keep_path=False)

    def package_info(self):
        self.cpp_info.libs = ["hello"]

- [conan **export**]: Export the recipe to local cache

.. code-block:: console

   $ conan export .





TRAINING
========

https://docs.docker.com/engine/install/debian/


.. code-block:: console

   (.venv) $ pip install lumache

