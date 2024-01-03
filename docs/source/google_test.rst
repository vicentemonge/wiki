GOOGLE TEST
============================


`official doc <https://google.github.io/googletest/primer.html>`_

- **assertions**: which are statements that check whether a condition is true. An assertion’s result can be **success**,
**nonfatal failure** , or **fatal failure**. If a **fatal failure** occurs, it aborts the current function; otherwise
the program continues normally.

- ASSERT_* versions generate fatal failures when they fail, and abort the current function.
  
- EXPECT_* versions generate nonfatal failures, which don’t abort the current function. Usually EXPECT_* are preferred,
as they allow more than one failure to be reported in a test.

- If a **test crashes** or has a failed assertion, then it fails; otherwise it succeeds.

- You should group your tests into test suites that reflect the structure of the tested code. When multiple tests in a
test suite need to share common objects and subroutines, you can put them into a **test fixture** class.

- A **test program** can contain multiple test suites.

- **Custom messages**: ASSERT_*/EXPECT_*() << "Anything that can be streamed to an ostream()";

**ASSERTIONS**
------------------

`official doc <https://google.github.io/googletest/advanced.html#assertion-placement>`_

You can use assertions in any C++ function, but assertion that generates a **fatal failure (FAIL* and ASSERT_*) can only
be used in void-returning functions (constructor and destructor aren't void-returning functions)**. By placing it in a
non-void function you’ll get a confusing compile error like "error: void value not ignored as it ought to be" or "cannot
initialize return object of type 'bool' with an rvalue of type 'void'" or "error: no viable conversion from 'void' to
'string'". To use a fatal failure in a non-void-returning function may rewrite and pass return as parameter.

SUCCEED()
~~~~~~~~~~~