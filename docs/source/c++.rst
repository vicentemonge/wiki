C++
=======================
- printf
- Condition variable
- LINKAGE
- RVALUE REFERENCES
- Catch SIGINT
- TO BE LEARNED


**TO BE LEARNED**
=====================
https://en.cppreference.com/w/cpp/thread/jthread
clog

**printf**
-------------------------

*std::cout*

*printf*

Un parámetro con problemas puede causar que los que vienen a continuación no se printen correctamente. En este caso al
pasarle un objeto en vez de su dirección para el primer %p hace que el 2o se printe como *(nil)*:

.. code-block:: C++

    printf("printo un texto '%s' un puntero '%p' y otro puntero '%p'\n", "pep", objeto1, &objeto2);



**Condition variable**
------------------------

.. code-block:: C++

    std::mutex m;
    std::condition_variable cv;

    std::unique_lock lk(m); // condition_variable only works with unique_lock
    cv.wait(lk, []{ return ready; }); 
    // Atomically calls lock.unlock() and blocks on *this.
    // When unblocked, calls lock.lock() (possibly blocking on the lock), then if predicate is true continue execution or blocks again.
    ...
    lk.unlock(); // unlock before notify to avoid waking up only to block again
    cv.notify_all();


**LINKAGE**
----------------

**ld: undefined reference to '' but symbols are defined**

This can happen by a incorrect link order: If libA depends on libB and libB depends on libC, the correct link order
would be -lA -lB -lC. If you initially link in a different order, the linker will report undefined reference errors.

**RPATH and RUNPATH**

**RVALUE REFERENCES**
-----------------------

Giving a rigorous definition is surprisingly difficult, but the explanation below is good enough for the purpose at hand:

An lvalue is an expression that refers to a memory location and allows us to take the address of that memory location via
the & operator. An rvalue is an expression that is not an lvalue.

.. code-block:: C++

    int a = 42;
    int b = 43;

    // a and b are both l-values:
    a = b; // ok
    b = a; // ok
    a = a * b; // ok

    // a * b is an rvalue:
    int c = a * b; // ok, rvalue on right hand side of assignment
    a * b = 42; // error, rvalue on left hand side of assignment

    // lvalues:
    //
    int i = 42;
    i = 43; // ok, i is an lvalue
    int* p = &i; // ok, i is an lvalue
    int& foo();
    foo() = 42; // ok, foo() is an lvalue
    int* p1 = &foo(); // ok, foo() is an lvalue

    // rvalues:
    //
    int foobar();
    int j = 0;
    j = foobar(); // ok, foobar() is an rvalue
    int* p2 = &foobar(); // error, cannot take the address of an rvalue
    j = 42; // ok, 42 is an rvalue

**Move Semantics**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Suppose X is a class that holds a pointer or handle to some resource, say, m_pResource. By a resource, I mean anything
that takes considerable effort to construct, clone, or destruct. A good example is std::vector, which holds a collection
of objects that live in an array of allocated memory. Then, logically, the copy assignment operator for X looks like this:

.. code-block:: C++

    X& X::operator=(X const & rhs)
    {
    // [...]
    // Make a clone of what rhs.m_pResource refers to.
    // Destruct the resource that m_pResource refers to. 
    // Attach the clone to m_pResource.
    // [...]
    }

Rather obviously, it would be ok, and much more efficient, to swap resource pointers (handles) between x and the temporary,
and then let the temporary's destructor destruct x's original resource. In other words, in the special case where the
right hand side of the assignment is an rvalue, we want the copy assignment operator to act like this:

.. code-block:: C++

    X& X::operator=(<mystery type> rhs)
    {
    // [...]
    // swap this->m_pResource and rhs.m_pResource
    // [...]  
    }

This is called move semantics (<mystery type> == X&&).

**Rvalue References**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 An rvalue reference is a type that behaves much like the ordinary reference X&, with several exceptions. The most
 important one is that when it comes to function overload resolution, lvalues prefer old-style lvalue references, whereas
 rvalues prefer the new rvalue references:

.. code-block:: C++

    void foo(X& x); // lvalue reference overload
    void foo(X&& x); // rvalue reference overload

    X x;
    X foobar();

    foo(x); // argument is lvalue: calls foo(X&)
    foo(foobar()); // argument is rvalue: calls foo(X&&)

**Rvalue references allow a function to branch at compile time (via overload resolution) on the condition "Am I being
called on an lvalue or an rvalue?"**

.. node::

    If you implement

    void foo(X&);

    but not

    void foo(X&&);

    then of course the behavior is unchanged: foo can be called on l-values, but not on r-values. If you implement

    void foo(X const &);

    but not

    void foo(X&&);

    then again, the behavior is unchanged: foo can be called on **l-values and r-values**, but it is not possible to make
    it distinguish between l-values and r-values. That is possible only by implementing

    void foo(X&&);

    as well. Finally, if you implement

    void foo(X&&);

    but neither one of

    void foo(X&);

    and

    void foo(X const &);

    then, according to the final version of C++11, foo can be called on r-values, but trying to call it on an l-value will
    trigger a compile error.

**Forcing Move Semantics**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**std::move** is a function that turns its argument into an rvalue without doing anything else:

.. code-block:: C++

    template<class T> 
    void swap(T& a, T& b) 
    { 
        T tmp(std::move(a)); // T tmp(a);
        a = std::move(b);    // a = b;
        b = std::move(tmp);  // b = tmp;
    } 

    X a, b;
    swap(a, b);

Note that for those types that do not implement move semantics (that is, do not overload their copy constructor and
assignment operator with an rvalue reference version), the new swap behaves just like the commented right one. 

Important benefits:
 - Many standard algorithms and operations will use move semantics and thus experience a potentially significant performance gain, like inplace sorting.
 - The STL often requires copyability of certain types but in some cases moveability is enough.

a = std::move(b);

If move semantics are implemented as a simple swap, then the effect of this  *a = std::move(b);* is that the objects held
by a and b are being exchanged between a and b. Nothing is being destructed yet. Therefore, as far as the implementer of
the copy assignment operator is concerned, it is not known when the object formerly held by a will be destructed. It can
be fine if the destruction does not have side effects but sometimes destructor do have such side effects (eg. lock release).
Therefore, any part of an object's destruction that has side effects should be performed explicitly in the rvalue reference
overload of the copy assignment operator:

.. code-block:: C++

    X& X::operator=(X&& rhs)
    {

    // Perform a cleanup that takes care of at least those parts of the
    // destructor that have side effects. Be sure to leave the object
    // in a destructible and assignable state.

    // Move semantics: exchange content between this and rhs
    
    return *this;
    }

**Catch SIGINT**
-------------------------

.. code-block:: C++

    #include <signal.h>

    static volatile int keepRunning = 1;

    void intHandler(int dummy) {
        keepRunning = 0;
    }

    // ...

    int main(void) {

    signal(SIGINT, intHandler);

    while (keepRunning) { 
        // ...


