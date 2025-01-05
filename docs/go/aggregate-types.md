# Aggregate Types

<style>
.md-logo img {
  content: url('/go/logo-go.svg');
}
</style>

Recall that arrays and structs are the aggregate types in Go.

## Arrays

Fixed length sequence of zero or more elements of a particular type.

```golang
a := [3]int{1, 2, 3}   // type = [3]int
a = [4]{1, 2, 3, 4}    // compile error, type mismatch

b := [...]int{1, 2, 3} // another valid literal form
fmt.Println(a == b)    // true
```

Size of an array is part of its type, so `[3]int` and `[4]int` are two different types. Size of an array must be a constant expression, i.e. known at compile time.

While other languages implictly pass arrays as reference, Go continues to pass them as value, which can be an expensive operation.

## Structs

```golang
type Point struct {
  a, b int
}

a := Point{1, 2}
b := &Point{1, 2} // Possible to obtain address right away
```

- Field order is significant to type identity.
- Field name is exported if it begins with a capital letter; Go's access control mechanism.
- Struct `T` cannot have a field of type `T` as well, but can have one of type `*T`.
- Zero value of a struct is composed of zero values of each constituent fields.
- Empty struct `struct{}` has zero size and carries no information.
- Struct too are passed as values by Go.

### Embedding anonymous fields

Go lets us declare a field with a type but no name, such fields are called _anonymous fields_.

<div markdown class="grid">

```golang linenums="1" title="before"
type Point struct {
  X, Y int
}

type Circle struct {
  Center Point
  Radius int
}

type Wheel struct {
  Circle Circle
  Spokes int
}

var w Wheel
w.Circle.Radis = 5
w.Circle.Center.X = 6 // cumbersome
```

```golang linenums="1" title="after"
type Circle struct {
  Point
  Radius int
}
type Wheel struct {
  Circle
  Spokes int
}

var w Wheel
w.Radius = 5
w.X = 6 // Skipped over
```

</div>

We say `Point` is _embedded_ within `Circle`.

!!! warning "Composition over inheritance"

    Embedding is composition with some syntactic sugar. It's not inheritance, which is not supported by Go.

## Objects

$$
type + method
$$

The type here can be anything, be it a basic type (boolean, int), an aggregate type (struct, array), or even a reference type (pointer, func, slice).

```golang
type Point struct {
	X, Y float64
}

func (p Point) Distance(q Point) float64 {
	return math.Sqrt(math.Pow(p.X-q.X, 2) + math.Pow(p.Y-q.Y, 2))
}

p := Point{1, 2}
q := Point{4, 6}
fmt.Println(p.Distance(q)) // 5

f := p.Distance            // method value
fmt.Println(f(q))          // 5
```

- Go doesn't use special names like `this` or `self` for the receiver.

### Pointer as receiver

Since Go passes arguments _by value_, if we need to update the receiver, we need to make the receiver a pointer.

```golang
func (p *Point) Distance(q Point) float64 {
	return math.Sqrt(math.Pow(p.X-q.X, 2) + math.Pow(p.Y-q.Y, 2))
}

p := Point{1, 2}
q := Point{4, 6}
fmt.Println(p.Distance(q))           // 5
fmt.Println(Point{1, 2}.Distance(q)) // compile error. Not addressable
```

compiler performs an implicit `&p`.
