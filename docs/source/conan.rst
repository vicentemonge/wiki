CONAN
=====

.. image:: ../images/conan_overview.png
  :width: 600
  :alt: Alt text que no se para que vale


- **conanfile.txt** with 2 sections corresponding on dependencies (*requires*) and build systems (*generators*)

.. code-block:: text
  :lineno-start: 1

   [requires]
   Poco/1.7.2@lasote/stable

   [generators]
   cmake

.. note::
  
  pkg/0.1@user/channel is called the recipe reference

- **Conan Center Index** [https://github.com/conan-io/conan-center-index] is the source index of recipes of the ConanCenter package repository for Conan.

.. image:: ../images/conan_center_index.png

- [conan **install**] To install dependencies (direct dependencies and transitive dependencies):
.. code-block:: console

  /connanfile/txt/path:$ mkdir build && cd build/ && conan install ..

And to generates **conanbuildinfo.cmake** with CONAN cmake variables that I can to use in my CMakeLists.txt:
.. code-block:: cmake
  
  ...
  include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  conan_basic_setup()
  ...
  target_link_libraries(project_name ${CONAN_LIBS})
  ...

- [conan **info**] To show the dependecies graph as text:
.. code-block:: console

  /connanfile/txt/path/build:$ conan info ..

.. note::
  
  ${HOME}/.conan* is our local cache folder

- [**build**] Now we can compile our code:
.. code-block:: console

   /connanfile/txt/path/build:$ cmake .. -G "Visual Studio 14 Win64"
   /connanfile/txt/path/build:$ cmake --build . --config Debug


- [conan **search**] To show local cache, all connan packages and their versions are available in my local system. To see info of a specific package can type:
.. code-block:: console

   $ conan search poco

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

