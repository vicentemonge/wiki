RST SYNTAX
==========

FIRST LEVEL
===============

**SECOND_LEVEL.txt**
----------------------------------

[THIRD **LEVEL**]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- FOURTH LEVEL
*****************************************

#

.. note::

    ESTO ES UNA NOTA

#

.. code-block:: cmake, cpp, python, cmake, console
  :caption: Example CMakeLists.txt
  :linenos:
  :lineno-start: 1
  :emphasize-lines: 6,7,9,10,13
  :name: <reference-label>

#

.. collapse:: Text always displayed

  .. code-block:: console

#

*italic* or _italic_
**bold** or __bold__

***asdf***
_**asdf**_
__*asdf*__
*__asdf__*
**_asdf_**

#

.. literalinclude:: api_response.json
   :language: json

#

Reference to places in the same document:

1.- creates a label and referenced  it

.. _my-section-label:

:ref:`Section Title <my-section-label>`

2.- auto references adding "autosectionlabel_prefix_document = True" in conf.py configuration file and section titles as
labels

My Section ->  Sphinx will generate a label named my-section
----------

:ref:`My Section` 

# urls

`link text <http://example.com>`_

#






























.. _installation:

Installation
------------

`Wiki de pe_linux <https://bobafett.pelectronics.local/vmonge/pe_linux_nayax/-/wikis/HOME>`_




To use Lumache, first install it using pip:

.. code-block:: console

   (.venv) $ pip install lumache

Creating recipes
----------------

To retrieve a list of random ingredients,
you can use the ``lumache.get_random_ingredients()`` function:

.. autofunction:: lumache.get_random_ingredients

The ``kind`` parameter should be either ``"meat"``, ``"fish"``,
or ``"veggies"``. Otherwise, :py:func:`lumache.get_random_ingredients`
will raise an exception.

.. autoexception:: lumache.InvalidKindError

For example:

>>> import lumache
>>> lumache.get_random_ingredients()
['shells', 'gorgonzola', 'parsley']

CODIGO FUENTE EJECUTABLE

.. raw:: html

   <script>window.onload = coliru.addRunButtons</script>
    <pre>
        <code data-lang="c++">
            int main()
            {
                return 0;
            }
        </code>
    </pre>

.. raw:: html

    <div class="t-example" style="height: auto;">
    <div class="t-example-live-link">
        <div class="coliru-btn coliru-btn-run-init">Run this code</div>
    </div>
    <div dir="ltr" class="mw-geshi t-example-code" style="text-align: left;">
        <div class="cpp source-cpp">
            <pre class="de1"><span class="co2">#include &lt;tuple&gt;</span>
    <span class="co2">#include &lt;iostream&gt;</span>
    <span class="co2">#include &lt;string&gt;</span>
    <span class="co2">#include &lt;stdexcept&gt;</span>
    &nbsp;
    std<span class="sy4">::</span><span class="me2">tuple</span><span class="sy1">&lt;</span><span class="kw4">double</span>, <span class="kw4">char</span>, <a href="http://en.cppreference.com/w/cpp/string/basic_string"><span class="kw1232">std::<span class="me2">string</span></span></a><span class="sy1">&gt;</span> get_student<span class="br0">(</span><span class="kw4">int</span> id<span class="br0">)</span>
    <span class="br0">{</span>
        <span class="kw1">switch</span> <span class="br0">(</span>id<span class="br0">)</span>
        <span class="br0">{</span>
            <span class="kw1">case</span> <span class="nu0">0</span><span class="sy4">:</span> <span class="kw1">return</span> <span class="br0">{</span><span class="nu16">3.8</span>, <span class="st0">'A'</span>, <span class="st0">"Lisa Simpson"</span><span class="br0">}</span><span class="sy4">;</span>
            <span class="kw1">case</span> <span class="nu0">1</span><span class="sy4">:</span> <span class="kw1">return</span> <span class="br0">{</span><span class="nu16">2.9</span>, <span class="st0">'C'</span>, <span class="st0">"Milhouse Van Houten"</span><span class="br0">}</span><span class="sy4">;</span>
            <span class="kw1">case</span> <span class="nu0">2</span><span class="sy4">:</span> <span class="kw1">return</span> <span class="br0">{</span><span class="nu16">1.7</span>, <span class="st0">'D'</span>, <span class="st0">"Ralph Wiggum"</span><span class="br0">}</span><span class="sy4">;</span>
            <span class="kw1">case</span> <span class="nu0">3</span><span class="sy4">:</span> <span class="kw1">return</span> <span class="br0">{</span><span class="nu16">0.6</span>, <span class="st0">'F'</span>, <span class="st0">"Bart Simpson"</span><span class="br0">}</span><span class="sy4">;</span>
        <span class="br0">}</span>
    &nbsp;
        <span class="kw1">throw</span> <a href="http://en.cppreference.com/w/cpp/error/invalid_argument"><span class="kw770">std::<span class="me2">invalid_argument</span></span></a><span class="br0">(</span><span class="st0">"id"</span><span class="br0">)</span><span class="sy4">;</span>
    <span class="br0">}</span>
    &nbsp;
    <span class="kw4">int</span> main<span class="br0">(</span><span class="br0">)</span>
    <span class="br0">{</span>
        <span class="kw4">const</span> <span class="kw4">auto</span> student0 <span class="sy1">=</span> get_student<span class="br0">(</span><span class="nu0">0</span><span class="br0">)</span><span class="sy4">;</span>
        <a href="http://en.cppreference.com/w/cpp/io/cout"><span class="kw1761">std::<span class="me2">cout</span></span></a> <span class="sy1">&lt;&lt;</span> <span class="st0">"ID: 0, "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"GPA: "</span> <span class="sy1">&lt;&lt;</span> <a href="http://en.cppreference.com/w/cpp/utility/variant/get"><span class="kw3219">std::<span class="me2">get</span></span></a><span class="sy1">&lt;</span><span class="nu0">0</span><span class="sy1">&gt;</span><span class="br0">(</span>student0<span class="br0">)</span> <span class="sy1">&lt;&lt;</span> <span class="st0">", "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"grade: "</span> <span class="sy1">&lt;&lt;</span> <a href="http://en.cppreference.com/w/cpp/utility/variant/get"><span class="kw3219">std::<span class="me2">get</span></span></a><span class="sy1">&lt;</span><span class="nu0">1</span><span class="sy1">&gt;</span><span class="br0">(</span>student0<span class="br0">)</span> <span class="sy1">&lt;&lt;</span> <span class="st0">", "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"name: "</span> <span class="sy1">&lt;&lt;</span> <a href="http://en.cppreference.com/w/cpp/utility/variant/get"><span class="kw3219">std::<span class="me2">get</span></span></a><span class="sy1">&lt;</span><span class="nu0">2</span><span class="sy1">&gt;</span><span class="br0">(</span>student0<span class="br0">)</span> <span class="sy1">&lt;&lt;</span> <span class="st0">'<span class="es1">\n</span>'</span><span class="sy4">;</span>
    &nbsp;
        <span class="kw4">const</span> <span class="kw4">auto</span> student1 <span class="sy1">=</span> get_student<span class="br0">(</span><span class="nu0">1</span><span class="br0">)</span><span class="sy4">;</span>
        <a href="http://en.cppreference.com/w/cpp/io/cout"><span class="kw1761">std::<span class="me2">cout</span></span></a> <span class="sy1">&lt;&lt;</span> <span class="st0">"ID: 1, "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"GPA: "</span> <span class="sy1">&lt;&lt;</span> <a href="http://en.cppreference.com/w/cpp/utility/variant/get"><span class="kw3219">std::<span class="me2">get</span></span></a><span class="sy1">&lt;</span><span class="kw4">double</span><span class="sy1">&gt;</span><span class="br0">(</span>student1<span class="br0">)</span> <span class="sy1">&lt;&lt;</span> <span class="st0">", "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"grade: "</span> <span class="sy1">&lt;&lt;</span> <a href="http://en.cppreference.com/w/cpp/utility/variant/get"><span class="kw3219">std::<span class="me2">get</span></span></a><span class="sy1">&lt;</span><span class="kw4">char</span><span class="sy1">&gt;</span><span class="br0">(</span>student1<span class="br0">)</span> <span class="sy1">&lt;&lt;</span> <span class="st0">", "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"name: "</span> <span class="sy1">&lt;&lt;</span> <a href="http://en.cppreference.com/w/cpp/utility/variant/get"><span class="kw3219">std::<span class="me2">get</span></span></a><span class="sy1">&lt;</span><a href="http://en.cppreference.com/w/cpp/string/basic_string"><span class="kw1232">std::<span class="me2">string</span></span></a><span class="sy1">&gt;</span><span class="br0">(</span>student1<span class="br0">)</span> <span class="sy1">&lt;&lt;</span> <span class="st0">'<span class="es1">\n</span>'</span><span class="sy4">;</span>
    &nbsp;
        <span class="kw4">double</span> gpa2<span class="sy4">;</span>
        <span class="kw4">char</span> grade2<span class="sy4">;</span>
        <a href="http://en.cppreference.com/w/cpp/string/basic_string"><span class="kw1232">std::<span class="me2">string</span></span></a> name2<span class="sy4">;</span>
        <a href="http://en.cppreference.com/w/cpp/utility/tuple/tie"><span class="kw1115">std::<span class="me2">tie</span></span></a><span class="br0">(</span>gpa2, grade2, name2<span class="br0">)</span> <span class="sy1">=</span> get_student<span class="br0">(</span><span class="nu0">2</span><span class="br0">)</span><span class="sy4">;</span>
        <a href="http://en.cppreference.com/w/cpp/io/cout"><span class="kw1761">std::<span class="me2">cout</span></span></a> <span class="sy1">&lt;&lt;</span> <span class="st0">"ID: 2, "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"GPA: "</span> <span class="sy1">&lt;&lt;</span> gpa2 <span class="sy1">&lt;&lt;</span> <span class="st0">", "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"grade: "</span> <span class="sy1">&lt;&lt;</span> grade2 <span class="sy1">&lt;&lt;</span> <span class="st0">", "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"name: "</span> <span class="sy1">&lt;&lt;</span> name2 <span class="sy1">&lt;&lt;</span> <span class="st0">'<span class="es1">\n</span>'</span><span class="sy4">;</span>
    &nbsp;
        <span class="co1">// C++17 structured binding:</span>
        <span class="kw4">const</span> <span class="kw4">auto</span> <span class="br0">[</span> gpa3, grade3, name3 <span class="br0">]</span> <span class="sy1">=</span> get_student<span class="br0">(</span><span class="nu0">3</span><span class="br0">)</span><span class="sy4">;</span>
        <a href="http://en.cppreference.com/w/cpp/io/cout"><span class="kw1761">std::<span class="me2">cout</span></span></a> <span class="sy1">&lt;&lt;</span> <span class="st0">"ID: 3, "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"GPA: "</span> <span class="sy1">&lt;&lt;</span> gpa3 <span class="sy1">&lt;&lt;</span> <span class="st0">", "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"grade: "</span> <span class="sy1">&lt;&lt;</span> grade3 <span class="sy1">&lt;&lt;</span> <span class="st0">", "</span>
                <span class="sy1">&lt;&lt;</span> <span class="st0">"name: "</span> <span class="sy1">&lt;&lt;</span> name3 <span class="sy1">&lt;&lt;</span> <span class="st0">'<span class="es1">\n</span>'</span><span class="sy4">;</span>
    <span class="br0">}</span></pre>
        </div>
    </div>
    <p>Output:
    </p>
    <div dir="ltr" class="mw-geshi" style="text-align: left;">
        <div class="text source-text">
            <pre class="de1">ID: 0, GPA: 3.8, grade: A, name: Lisa Simpson
    ID: 1, GPA: 2.9, grade: C, name: Milhouse Van Houten
    ID: 2, GPA: 1.7, grade: D, name: Ralph Wiggum
    ID: 3, GPA: 0.6, grade: F, name: Bart Simpson</pre>
        </div>
    </div>
    </div>

TITULO1
=======

=======
TITULO1
=======


TITULO2
~~~~~~~

~~~~~~~
TITULO2
~~~~~~~

TITULO3
-------

-------
TITULO3
-------

TITULO4
*******

*******
TITULO4
*******

TITULO5
@@@@@@@

@@@@@@@
TITULO5
@@@@@@@

TITULO6
"""""""

"""""""
TITULO6
"""""""

TITULO7
^^^^^^^

^^^^^^^
TITULO7
^^^^^^^

