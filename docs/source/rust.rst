RUST
==============

.. code-block:: rust
    // types
    "XXXXX"     str
    'X'         char
    true/false  bool

    // let variable inmutable[: tipo] = initialization
    let x: i32 = 0;

    // mut makes variable variable
    let mut y: i32 = 0;
    y = 22

    //
    let mut i = 43;
    i = 42.0; // ERROR -> different type

    // let let you reuse a name (shadowing)
    let number = "T-H-R-E-E";
    let number = 3;

    // const needs type
    const NUMBER: i8 = 3;

    // function ([parameters]) [-> return type] {}
    fn call_me(param1:i8) -> i32 {2}
    // return value
    2
    return 2
    return 2;

    let cat = ("Furry McFurson", 3.5);
    let (name, age) /* your pattern here */ = cat;
    println!("{} is {} years old.", name, age); // println! prints a line


.. code-block:: rust

    let x: (i32, f64, u8) = (500, 6.4, 1);

    assert_eq!(6.4, x.1,
        "This is not the 2nd number in the tuple!")

.. code-block:: rust

    fn array_and_vec() -> ([i32; 4], Vec<i32>) {
        let a = [10, 20, 30, 40]; // a plain array
        let v = vec![10, 20, 30, 40]; // TODO: declare your vector here with the macro for vectors

        (a, v)
    }

tuple
----

.. code-block:: rust

    let cat = ("Furry McFurson", 3.5);
    let (name, age) = cat;
    let name2 = cat.0
    let age2 = cat.1

for
----

.. code-block:: rust

    // for
    for i in 0..num {
        println!("Ring! Call number {}", i + 1);
    }


if
----

.. code-block:: rust

    // if [()]{}[else{}]
    if a >= b {a} else [if] {b}

array
-----------------

.. code-block:: rust

    // array [:[type; size]] = [value; elements]
    let a: [i32; 100] = [0; 100];


vectors
-----------------

.. code-block:: rust

    let v: Vec<i32> = Vec::new(); // empty
    let v = vec![1, 2, 3]; // from values

.. code-block:: rust

    let third: &i32 = &v[2];
    println!("The third element is {third}");

    let third: Option<&i32> = v.get(2);
    match third {
        Some(third) => println!("The third element is {third}"),
        None => println!("There is no third element."),
    }

modificar un vector usando un iterador mutable:

.. code-block:: rust

    fn vec_loop(mut v: Vec<i32>) -> Vec<i32> {
        for element in v.iter_mut() {
            // each element in the Vec `v` is multiplied by 2.
            *element = *element * 2;
            *element*=2;
        }
    }

crear vector modificando otro:

.. code-block:: rust

    fn vec_map(v: &Vec<i32>) -> Vec<i32> {
        v.iter().map(|element| {
            // each element in the Vec `v` is multiplied by 2, just return the new number!
            element*2
        }).collect()
    }


Please note that in Rust, you can either have many immutable references, or one mutable reference. For more details you may want to read the 
References & Borrowing section of the Book
