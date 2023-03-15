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

- **if**

.. code-block:: cmake

   if((condition) AND (condition OR (NOT condition)))
   elseif(<condition>)
   else()
   endif()

