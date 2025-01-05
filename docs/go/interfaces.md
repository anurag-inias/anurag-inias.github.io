# Interfaces

<style>
.md-logo img {
  content: url('/go/logo-go.svg');
}
</style>

An interface type specifies a set of methods that a concrete type must posses to be consider an instance of said interface.

```golang
type Write interface {
  Write(p []byte) (n int, err error)
}

type error interface {
  Error() string
}
```

- For each concrete type `T`, some of its methods have receiver of type `T` itself and some may require `*T` receiver.
- While it is legal to call a `*T` method with receiver `T` so long it's a variable (so compiler can implicitly peform `&` operation), it's still a sysntatic sugar.
- All this to say, a value of type `T` does not possess all the methods that `*T` does. So `T` may statisfy an interface, while `*T` may not, or vice-versa.

```golang
type IntSet struct { /* ... */ }
func (*IntSet) String() string

var a fmt.Stringer = &s // OK
var b fmt.Stringer = s // compile error: IntSet lacks String method
```

- `interface{}` can act as `Any` of Go since it places no requirements on the concrete types.

```golang
var any interface{}

any = true // valid
any = "Ho" // valid
any = 3.21 // valid again
```

## Type Checks

`x.(T)` where `x` is an expression of an interface type and `T` is the _asserted_ type.

```golang
var w io.Writer = os.Stdout
if f, ok := w.(*os.File); ok {
  // do something
}
```
