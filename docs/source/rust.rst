RUST
==============

.. code-block:: rust

    let cat = ("Furry McFurson", 3.5);
    let (name, age) /* your pattern here */ = cat;
    println!("{} is {} years old.", name, age);


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


vectors
-----------------

empty:

let v: Vec<i32> = Vec::new();

from values:

let v = vec![1, 2, 3];

let v = vec![1, 2, 3, 4, 5];

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
            // TODO: Fill this up so that each element in the Vec `v` is
            // multiplied by 2.
            *element = *element * 2;
        }
        v
    }

crear vector modificando otro:

.. code-block:: rust

    fn vec_map(v: &Vec<i32>) -> Vec<i32> {
        v.iter().map(|element| {
            // TODO: Do the same thing as above - but instead of mutating the
            // Vec, you can just return the new number!
            2*element
        }).collect()
    }


Please note that in Rust, you can either have many immutable references, or one mutable reference. For more details you may want to read the 
References & Borrowing section of the Book
