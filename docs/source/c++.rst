C++
=======================



*std::cout*

*printf*

Un parámetro con problemas puede causar que los que vienen a continuación no se printen correctamente. En este caso al
pasarle un objeto en vez de su dirección para el primer %p hace que el 2o se printe como *(nil)*:

.. code-block:: C++

    printf("printo un texto '%s' un puntero '%p' y otro puntero '%p'\n", "pep", objeto1, &objeto2);


*ld: undefined reference to '' but symbols are defined*

This can happen by a incorrect link order: If libA depends on libB and libB depends on libC, the correct link order
would be -lA -lB -lC. If you initially link in a different order, the linker will report undefined reference errors.