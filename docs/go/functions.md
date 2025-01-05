# Functions

<style>
.md-logo img {
  content: url('/go/logo-go.svg');
}
</style>

```golang
func name(parameter-list) (result-list) {
  body
}
```

Like parameters, results can also be named.

```golang
func findLinksLog(url string) ([]string, error)     // multiple returned values
func Size(rect image.Rectangle) (width, height int) // multiple returned values with names
```

## Function values

Function values also have types and can be passed. Zero value of function is `nil` since it's a reference type. They cannot be compared.

```golang
func square(n int) int {
  return n * n
}

function product(a, b int) int {
  return a * b
}

f := square
fmt.Println(f(3)) // 9

f = product       // compile error: can't assign f(int, int) int to f(int) int
```

A function's _signature_ is its type.

```golang
func square(n int) int {
	return n * n
}

type Square func(int) int

var f Square = square
```

## Anonymous functions

A function literal can be written within any expression, but not at the package level.

```golang
func squares() func() int {
  var x int
  return func() int {
    x++
    return x * x
  }
}

f := squares()
fmt.Println(f()) // 1
fmt.Println(f()) // 4
fmt.Println(f()) // 9
```

As we can see, Go lets you capture _reference_ to the variable in enclosing scope, which is why functions are considered _reference_ type.

!!! warning "Capturing iteration variables"

    Watch out for this issue prior to Go 1.22. See [go.dev/blog/loopvar-preview](https://go.dev/blog/loopvar-preview).

    ```
    type Square func()

    var squares []func()

    for _, i := range []string{"1", "2", "3"} {
      squares = append(squares, func() {
        fmt.Println(i, &i)
      })
    }

    for _, f := range squares {
      f() // 3 3 3
    }
    ```

    Go used the same address for the iteration variable, so `i` here keeps getting overwritten. The Go closure captures the `&i` and when eventually executed, report back only the last value.

## Variadic functions

```golang
func sum(vals ...int) int {
  total := 0
  for _, v := range vals {
    total += v
  }
  return total
}

fmt.Println(sum())     // 0
fmt.Println(sum(1))    // 1
fmt.Println(sum(1, 2)) // 3
```

Note that `...int` is not a slice, just mimicing one.

## Defer

- A `defer` statement is an ordinary function or method call prefixed by `defer` keyword.
- The function and its argument expression (if any) are evaluated when the statement is executed, as normal.
- However, the actual call is _deferred_ until the containing function has finished, be it normally or by panicking.

```golang
func ReadFile(filename string) ([]byte, error) {
  f, err := os.Open(filename)
  if err != nil {
    return nil, err
  }
  defer f.Close()
  return ReadAll(f)
}
```

A defer statement to release a resource should be placed right after it's acquired.

### Example

<div markdown class="grid">

```golang linenums="1"
func main() {
	defer fmt.Println("Exit")
	fmt.Println("Enter")
	fmt.Println("During")
}
```

```bash linenums="1"
Enter
During
Exit
```

</div>

<div markdown class="grid">

<div markdown>

```golang linenums="1"
var i = 1

func inc() int {
	i += 1
	return i
}

func ping(label string, i int) {
	fmt.Printf("%s %d\n", label, i)
}

func main() {
	defer ping("Exit", inc())
	ping("Enter", i)
	ping("During", i)
}
```

</div>

<div markdown>

```bash linenums="1"
Enter 2
During 2
Exit 2
```

As we said, arguments of a deferred function call are themselves not deferred. They are evaluated right away when the `defer` statement is reached.

</div>

</div>
