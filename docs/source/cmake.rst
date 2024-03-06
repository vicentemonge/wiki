CMAKE
=========================

Macros vs functions
-------------------------

(See CMakelist.txt in folder resources)

- CMakeLists.txt path:

.. code-block:: cmake

   CMAKE_CURRENT_SOURCE_DIR # is the top CMakeLists.txt path if a caller exists
   CMAKE_CURRENT_LIST_DIR  # is the current file path

- Pass list to a macro:

.. code-block:: cmake

    set(MYLIST pep pop)
    mymacro("${MYLIST}") # pass whole list
    mymacro(${MYLIST}) # only first element of the list
    mymacro(MYLIST) # pass MYLIST test


- Check variables: The first one refers to the variable and the other to its content.

.. code-block:: cmake

   if(NOT DEFINED VAR_NAME) and if(NOT DEFINED ${VAR_NAME})

- Check variables 2 [examples]: Check a variable is true or false. False only in this cases (case insensitive):

.. code-block:: cmake
   :linenos:
   :lineno-start: 1

   cmake -DVAR_NAME= .
   cmake -DVAR_NAME=OFF .
   cmake -DVAR_NAME=0 .
   cmake -DVAR_NAME=NO .
   cmake -DVAR_NAME=FALSE .
   cmake . # -DVAR_NAME

   ...
   if (NOT VAR_NAME)
      # pass here
   endif()
   if (DEFINED VAR_NAME)
      # pass here except last case
   endif()
   if (VAR_NAME)
      # for other -DVAR_NAME=XXXXX
   endif()
   ...

- Check variables 3: Check variable emptiness



- Check file exist: for files and directories. The file(EXISTS ...) evaluates to TRUE if exists, and FALSE otherwise.

.. code-block:: cmake

   set(FILE_PATH "/path/to/file.txt")

   if (EXISTS ${FILE_PATH})
      message("File exists: ${FILE_PATH}")
   else()
      message("File does not exist: ${FILE_PATH}")
   endif()


- **if**

.. code-block:: cmake

   if((condition) AND (condition OR (NOT condition)))
   elseif(<condition>)
   else()
   endif()

set
-------

Set **Normal Variable**: *set(<variable> <value>... [PARENT_SCOPE])*

- if no value unset the variable
- PARENT_SCOPE: the variable will be set in the scope above the current scope (Each new directory or function() command
creates a new scope, and the command block() too)

Set **Cache Variable**: *set(<variable> <value>... CACHE <type> <docstring> [FORCE])*

- CMake stores a separate set of "cache" variables, or "cache entries", whose values persist across multiple runs within
a project build tree. 
- [FORCE]: does not overwrite existing cache entries by default. FORCE option overwrite existing entries.
- <type>: BOOL (ON/OFF), FILEPATH (file path), PATH (folder path), STRING (text), INTERNAL (text, persistent and implies FORCE)
- <docstring>: quick summary
- 
Set **Environment Variable**: *set(ENV{<variable>} [<value>])*

- Set an environment variable in the current CMake process, not the process from which CMake was called, nor the system
environment at large, nor the environment of subsequent build or test processes.
- *cmake -E env [<options>] [--] <command> [<arg>...]* Run command in a modified environment.
  https://cmake.org/cmake/help/latest/manual/cmake.1.html#cmdoption-cmake-E-arg-env


install
-----------

**CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT**: TRUE when CMAKE_INSTALL_PREFIX init to the default CMake value, typically on
the first run of CMake within a new build tree.

**CMAKE_INSTALL_PREFIX**: this directory is prepended onto all install directories, if relative first converted to absolute.
**DESTDIR**: environment variable used for make inner command to prepend to output directory
**--prefix**: CMAKE_INSTALL_PREFIX for command line and overwrites the value (*cmake --install --prefix xxxxx*)
