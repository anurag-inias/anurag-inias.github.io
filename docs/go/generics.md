# Generics

Supported since Go 1.18, see [go.dev/blog/intro-generics](https://go.dev/blog/intro-generics).

- Type parameters for functions and types.
- Defining interface types as sets of types.
- Type inference.

## Type parameters

<div markdown class="grid">

```golang linenums="1" title="before"
func min(x, y int) int {
	if x < y {
		return x
	} else {
		return y
	}
}

fmt.Println(min(2, 1))   // 1
fmt.Println(min(2.0, 1)) // compile error
```

```golang linenums="1" title="after"
import "golang.org/x/exp/constraints"

func min[T constraints.Ordered](x, y int) int {
	if x < y {
		return x
	} else {
		return y
	}
}

fmt.Println(min[int](2, 1))       // 1
fmt.Println(min[float32](2.0, 1)) // 1.0
```

</div>

`min[int]` is called _instantiation_. After instantiation we have a non-generic function which can be called just like any other function.

```golang
imin := min[int]
fmin := min[float32]

imin(2, 1)
fmin(2.0, 1.0)
```

## Type inference

```
var a, b float64
min(a, b) // implicit type instantiation
```

Only works for argument types, and not results.

## Type sets

<div markdown class="grid">

<div markdown>
Prior to Go 1.18, the Go spec viewed an interface as a set of methods. Any type that implements those methods, implements that interface.

![](https://go.dev/blog/intro-generics/method-sets.png)

</div>

<div markdown>
But we can also view interface as a set of types.

![](https://go.dev/blog/intro-generics/type-sets.png)

</div>

</div>

The second view is what's happening with generics. See the definition of `Ordered` interface:

```golang
type Ordered interface {
	Integer | Float | ~string
}
```

this says that `Ordered` interface is set of all integers, floating-point, and string types. `~string` means we want both `string` and types with `string` as underlying type (i.e. `type MyString string`).

In Go 1.18, an interface may contain methods and embedded interfaces just as before, but it may also include non-interface types, unions, and set of underlying types.

Constraints can be interfaces, or can be inlined:

```golang
[S interface{ ~[]E }, E interface{}]
[S ~[]E, E interface{}] // same, enclosing interface{} may be omitted
```

here `S` must be a `slice` type whose element can be anything.
