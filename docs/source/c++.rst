C++
=======================



*std::cout*

*printf*

Un parámetro con problemas puede causar que los que vienen a continuación no se printen correctamente. En este caso al
pasarle un objeto en vez de su dirección para el primer %p hace que el 2o se printe como *(nil)*:

.. code-block:: C++

    printf("printo un texto '%s' un puntero '%p' y otro puntero '%p'\n", "pep", objeto1, &objeto2);