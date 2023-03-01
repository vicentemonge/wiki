C
=================================

- **auto**, diferent meaning than C++.

    - auto is used to define local variables (also by default)
    - auto is used for forward declaration of nested functions:

.. code-block:: c++

    #include <stdio.h>
    int function();

    int function()
    {
        auto int opengenus_function(); // correct
        auto int a = 1;
        printf("%d\n", a);
        
        int opengenus_function()
        {
            int b = 2;
            printf("%d", b);
        }
        
        opengenus_function();
    }

    int main() 
    {
        function();
        return 0;
    }

    - auto can result in non-contiguous memory allocation
