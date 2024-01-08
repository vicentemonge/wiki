GOOGLE TEST
============================


`official doc <https://google.github.io/googletest/primer.html>`_

- **assertions**: which are statements that check whether a condition is true. An assertion’s result can be **success**, **nonfatal failure** , or **fatal failure**. If a **fatal failure** occurs, it aborts the current function; otherwise the program continues normally.

- ASSERT_* versions generate fatal failures when they fail, and abort the current function.
  
- EXPECT_* versions generate nonfatal failures, which don’t abort the current function. Usually EXPECT_* are preferred, as they allow more than one failure to be reported in a test.

- If a **test crashes** or has a failed assertion, then it fails; otherwise it succeeds.

- You should group your tests into test suites that reflect the structure of the tested code. When multiple tests in a test suite need to share common objects and subroutines, you can put them into a **test fixture** class.

- A **test program** can contain multiple test suites.

- **Custom messages**: ASSERT_*/EXPECT_*() << "Anything that can be streamed to an ostream()";

**ASSERTIONS**
------------------

`assertions <https://google.github.io/googletest/advanced.html#assertion-placement>`_

You can use assertions in any C++ function, but assertion that generates a **fatal failure (FAIL* and ASSERT_*) can only
be used in void-returning functions (constructor and destructor aren't void-returning functions)**. By placing it in a
non-void function you’ll get a confusing compile error like "error: void value not ignored as it ought to be" or "cannot
initialize return object of type 'bool' with an rvalue of type 'void'" or "error: no viable conversion from 'void' to
'string'". To use a fatal failure in a non-void-returning function may rewrite and pass return as parameter.

- **SUCCEED()**: is purely documentary and currently doesn’t generate any user-visible output.
- **FAIL()**: fatal failure, only on void-returning functions
- **ADD_FAILURE()**: nonfatal failure.
- **ADD_FAILURE_AT(file_path, line_number)**: nonfatal failure at that line on that file.
- **EXPECT_THAT(value, matcher)**:
- **ASSERT_THAT(value, matcher)**:

.. code-block:: cpp

    #include <gmock/gmock.h>

    using ::testing::AllOf;
    using ::testing::Gt;
    using ::testing::Lt;
    using ::testing::MatchesRegex;
    using ::testing::StartsWith;
    ...
    EXPECT_THAT(value1, StartsWith("Hello"));
    EXPECT_THAT(value2, MatchesRegex("Line \\d+"));
    ASSERT_THAT(value3, AllOf(Gt(5), Lt(10)));


`builtin matchers <https://google.github.io/googletest/reference/matchers.html>`_
`code custom matchers <https://google.github.io/googletest/gmock_cook_book.html#NewMatchers>`_

- **EXPECT_TRUE(condition)**
- **ASSERT_TRUE(condition)**
- **EXPECT_FALSE(condition)**
- **ASSERT_FALSE(condition)**

- **EXPECT_EQ(val1,val2)**
- **ASSERT_EQ(val1,val2)**
- **EXPECT_NE(val1,val2)**
- **ASSERT_NE(val1,val2)**
- **EXPECT_LT(val1,val2)**
- **ASSERT_LT(val1,val2)**
- **EXPECT_LE(val1,val2)**
- **ASSERT_LE(val1,val2)**
- **EXPECT_GT(val1,val2)**
- **ASSERT_GT(val1,val2)**
- **EXPECT_GE(val1,val2)**
- **ASSERT_GE(val1,val2)**

.. note:: 
    
    If an argument supports the << operator, it will be called to print the argument when the assertion fails
    `teaching-googletest-how-to-print-your-values <https://google.github.io/googletest/advanced.html#teaching-googletest-how-to-print-your-values>`_

- **STRING COMPARISON**  **EXPECT_STREQ(str1,str2)** **ASSERT_STREQ(str1,str2)** **EXPECT_STRNE(str1,str2)** **ASSERT_STRNE(str1,str2)** **EXPECT_STRCASEEQ(str1,str2)** **ASSERT_STRCASEEQ(str1,str2)** **EXPECT_STRCASENE(str1,str2)** **ASSERT_STRCASENE(str1,str2)**
  
- **FLOATING POINT COMPARISON**

EXPECT_FLOAT_EQ(val1,val2)
ASSERT_FLOAT_EQ(val1,val2)
EXPECT_DOUBLE_EQ(val1,val2)
ASSERT_DOUBLE_EQ(val1,val2)
EXPECT_NEAR(val1,val2,abs_error)
ASSERT_NEAR(val1,val2,abs_error)

- **EXCEPTION ASSERTIONS** The following assertions verify that a piece of code throws, or does not throw, an exception.

EXPECT_THROW(statement,exception_type)
ASSERT_THROW(statement,exception_type)
EXPECT_ANY_THROW(statement)
ASSERT_ANY_THROW(statement)
EXPECT_NO_THROW(statement)
ASSERT_NO_THROW(statement)

.. code-block:: cpp
  :caption: Note that the piece of code under test can be a compound statement, for example:

    EXPECT_NO_THROW({
      int n = 5;
      DoSomething(&n);
    });

- **PREDICATE ASSERTIONS**

EXPECT_PREDN(pred,val1, val2, ..., valn)
ASSERT_PREDN(pred,val1, val2, ..., valn)

.. code-block:: cpp
  :caption: the parameter pred is a function or functor that accepts as many arguments as the corresponding macro accepts values:

    // Returns true if m and n have no common divisors except 1.
    bool MutuallyPrime(int m, int n) { ... }
    ...
    const int a = 3;
    const int b = 4;
    const int c = 10;
    ...
    EXPECT_PRED2(MutuallyPrime, a, b);  // Succeeds
    EXPECT_PRED2(MutuallyPrime, b, c);  // Fails

.. note::
    
    When the assertion fails, it prints the value of each argument. Arguments are always evaluated exactly once:

    MutuallyPrime(b, c) is false, where
    b is 4
    c is 10


EXPECT_PRED_FORMATN(pred_formatter,val1, val2, ..., valn)
ASSERT_PRED_FORMATN(pred_formatter,val1, val2, ..., valn)


.. code-block:: cpp
  :caption: the parameter pred_formatter is a predicate-formatter, which is a function or functor with the signature:

    testing::AssertionResult PredicateFormatter(const char* expr1,
                                                const char* expr2,
                                                ...
                                                const char* exprn,
                                                T1 val1,
                                                T2 val2,
                                                ...
                                                Tn valn);

where val1, val2, …, valn are the values of the predicate arguments, and expr1, expr2, …, exprn are the corresponding expressions as they appear in the source code. 

.. code-block:: cpp

    testing::AssertionResult IsEven(int n) {
    if ((n % 2) == 0)
        return testing::AssertionSuccess() << n << " is even";
    else
        return testing::AssertionFailure() << n << " is odd";
    }

.. note::

    EXPECT_TRUE(IsEven(Fib(4)))

    Value of: IsEven(Fib(4))
      Actual: false (3 is odd)
    Expected: true

    EXPECT_FALSE(IsEven(Fib(6)))

    Value of: IsEven(Fib(6))
      Actual: true (8 is even)
    Expected: false

`using-a-function-that-returns-an-assertionresult <https://google.github.io/googletest/advanced.html#using-a-function-that-returns-an-assertionresult>`_

- **DEATH ASSERTIONS**

`death assertions <https://google.github.io/googletest/reference/assertions.html#death>`_


