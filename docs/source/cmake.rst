CMAKE
=========================

Macros vs functions
-------------------------

(See CMakelist.txt in folder resources)

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
   ...

- **if**

.. code-block:: cmake

   if((condition) AND (condition OR (NOT condition)))
   elseif(<condition>)
   else()
   endif()

