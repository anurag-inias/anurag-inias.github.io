# Tour

<style>
.md-logo img {
  content: url('/go/logo.svg');
}
</style>

## Hello, World

```golang linenums="1" title="hello-world.go"
package main

import "fmt"

func main() {
  fmt.Println("Hello, World")
}
```

<div markdown class="grid">

```bash title="build and run"
$ go build hello-world.go
$ ./hello-world
```

```bash title="direct run"
$ go run hello-world.go
```

</div>

## Names

| Category  | Predeclared names                                                                                                                                                           |
| --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Constants | `true` `false` `iota` `nil`                                                                                                                                                 |
| Types     | `bool` `byte` `rune` `string` `error` `int` `int8` `int16` `int32` `int64` `uint` `uint8` `uint16` `uint32` `uint64` `uintptr` `float32` `float64` `complex64` `complex128` |
| Functions | `make` `len` `cap` `new` `append` `copy` `close` `delete` `complex` `real` `imag` `panic` `recover`                                                                         |

## Declarations

!!! quote ""

    A _declarations_ names a program entity and specifies some or all of its properties.

    There are 4 major kinds of declarations: `var`, `const`, `type` and `func`.

## Variables

$$
\text{ var } name \ type = expression
$$

either `type` or `= expression` part may be omitted, but not both. If `expression` is omitted, the initial value is _zero value_ of the given type:

| type                                                                           | _zero value_                          |
| ------------------------------------------------------------------------------ | ------------------------------------- |
| numbers                                                                        | `0`                                   |
| booleans                                                                       | `false`                               |
| strings                                                                        | `""`                                  |
| interface and reference types <br> e.g. slice, pointer, map, channel, function | `nil`                                 |
| aggregate type (array, struct)                                                 | zero values for all elements / fields |

```golang
var s string
fmt.Println(s)                  // ""

var i, j, k int                 // int, int, int
var a, b, c = true, 42, "hello" // multiple declarations
```

### Short variable declaration (SVD)

$$
name := expression
$$

Within a function only.

!!! warning "watch out"

    A short variable declaration does not necessarily _declare_ all the variables on lhs. If a variable is already declared, then short variable declaration will act like an assignment.

    At least one new variable must be declared in SVD.

    ```golang
    f, err := os.Open(file)
    // ...
    f, err := os.Create(file) // compile error
    ```

## Pointers

```golang
x := 1          //  int type
p := &x         // *int type

fmt.Println(*p) // 1
*p = 2
fmt.Println(*p) // 2
```

- Given a variable `x`, `&x` gives the _address of `x`_.
- Given a pointer `p`, `*p` yields the value of the pointed variable.
- Zero value of a pointer of any type is `nil`.
- Test `p != nil` is true if `p` points to a variable.
- Two pointers are equal iff they point to the same variable, or both are `nil`.

It is safe for a function to return address of a local variable. Local variable will remain in existence even after call returns.

```golang
var p = f()
func f() *int {
  v := 1
  return &v
}

fmt.Println(f() == f()) // false, each call of f returns a distinct value
```

## $new$ Function

The expression `new(T)`:

1. creates an _unnamed variable_ of type `T`,
2. initializes it to the zero value of `T`,
3. returns its address, which is of type `*T`.

```golang
p := new(int)   // type *int, points to unnamed int variable
fmt.Println(*p) // 0, zero value of int
```

Unlike other languages, `new` is not automatically indicative of a variable stored on heap.

Each call to `new` returns a distinct variable with unique address:

```
p := new(int)
q := new(int)
fmt.Println(p == q) // false
```

exception: variables of types with no information (`struct{}` or `[0]int`) may (depending on the implementation) have same address.

## Variables' lifetime

- package-level variables have lifetime that is the entire execution of the program.
- local variables' life begin when declaration is executed and end when variable is no longer reachable.
- A local variable may continue to exist even after the enclosing function has returned.

<div markdown class="grid">

```golang linenums="1"
var global *int

func f() {
  var x int
  x = 1
  global = &x
}
```

```golang linenums="1"
func f() {
  x := new(int)
  *x = 1
}
```

`x` must be heap-allocated because it's still reacheable from `global` after `f` returns. Thus `x` _escapes from `f`_.

`x` does not escape from `f` and is safe to be allocated on stack.

</div>

## Tuple assignment

All of rhs expressions are evaluated before any of the variables on are updated. Which allows this sick one line swap.

```golang
x, y = y, x
```
