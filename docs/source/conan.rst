CONAN
=====

.. image:: ../images/conan_overview.png
  :width: 600
  :alt: Alt text que no se para que vale


- **conanfile.txt** with 2 sections corresponding on dependencies (*requires*) and build systems (*generators*)

.. code-block:: text
  :lineno-start: 1

   [requires]
   Poco/1.7.2@lasote/stable

   [generators]
   cmake

- To install dependencies (direct dependencies and transitive dependencies):

.. code-block:: console
  (connanfile/txt/path) $ mkdir build && cd build/ && conan install ..

.. code-block:: console

   (.venv) $ pip install lumache


Title
=====

Section
-------

Subsection
~~~~~~~~~~

