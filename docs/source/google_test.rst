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

- **EXPECT_STREQ(str1,str2)**
- **ASSERT_STREQ(str1,str2)**
- **EXPECT_STRNE(str1,str2)**
- **ASSERT_STRNE(str1,str2)**
- **EXPECT_STRCASEEQ(str1,str2)**
- **ASSERT_STRCASEEQ(str1,str2)**
- **EXPECT_STRCASENE(str1,str2)**
- **ASSERT_STRCASENE(str1,str2)**

- **FLOATING POINT COMPARISON** 
EXPECT_FLOAT_EQ(val1,val2)
ASSERT_FLOAT_EQ(val1,val2)
EXPECT_DOUBLE_EQ(val1,val2)
ASSERT_DOUBLE_EQ(val1,val2)
EXPECT_NEAR(val1,val2,abs_error)
ASSERT_NEAR(val1,val2,abs_error)