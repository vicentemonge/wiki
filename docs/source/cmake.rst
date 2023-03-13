CMAKE
=========================

Macros vs functions
-------------------------

(See CMakelist.txt in folder resources)


- Check variables: The first one refers to the variable and the other to its content.

.. code-block:: cmake

   if(NOT DEFINED VAR_NAME) and if(NOT DEFINED ${VAR_NAME})

