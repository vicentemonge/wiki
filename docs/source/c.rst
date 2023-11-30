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


static
-------

From chatgpt:

 The function signature in C includes the function's name, return type, and parameter types. It's the declaration of the function that provides information about how the function should be called and what it returns. Here's a breakdown of the function signature:

c

return_type function_name(parameter_type1 parameter1, parameter_type2 parameter2, ...) {
    // Function body
}

    return_type: The data type of the value the function returns. If the function doesn't return anything, the return type is void.

    function_name: The name of the function, which is used to call the function.

    parameter_type1, parameter_type2, ...: The data types of the parameters that the function accepts. If the function doesn't take any parameters, you use void inside the parentheses.

Now, let's discuss the static keyword in the context of function declarations and definitions.
1. Static Functions:

If you use the static keyword in the function declaration or definition, it has different implications:

    Static Function Declaration: When you declare a function as static at the global level (outside any function), it limits the scope of the function to the translation unit (source file) where it is defined. The function is not visible to other translation units linked together to create the final executable.

    c

static int myStaticFunction(int x, int y);

Static Function Definition: When you define a function as static, it limits the visibility of the function to the translation unit where it is defined. It can't be referenced or called from other source files.

c

    static int myStaticFunction(int x, int y) {
        return x + y;
    }

2. Static Variables Inside Functions:

    Static Variables: When you declare a variable inside a function as static, it retains its value between function calls. The variable is initialized only once, and its value is preserved across multiple calls to the function.

    c

    int myFunction() {
        static int count = 0;
        count++;
        return count;
    }

These uses of the static keyword contribute to encapsulation, limiting the visibility of functions and variables to the file where they are defined. It helps prevent naming conflicts and allows you to control the scope of your code more effectively.
