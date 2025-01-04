# Constants

<style>
.md-logo img {
  content: url('/go/logo-go.svg');
}
</style>

Expressions whose value is evaluation at compile time, not run time.

```golang
const (
  e = 2.71828182845904523536028747135266249775724709369995957496696763
  pi = 3.14159265358979323846264338327950288419716939937510582097494459
)
```

Results of rithmetic, logical and comparison operations applied on constants are constants themselves. Same for certain built-in functions, such as `len`, `cap`, `real`, `imag`, `complex` and `unsafe.Sizeof`.

Compiler can represent constants with uncommitted type with greater precision than basic types, and so the operations on these can yield more precise results.

### iota

is a _constant generator_ to create sequence of related values.

```golang
type Weekday int
type Month int

const (
	Sunday  Weekday = iota // 0
	Monday                 // 1
	Tuesday                // 2
)

const (
	JAN Month = iota       // 0 again
	FEB                    // 1
	MAR                    // 2
)
```
