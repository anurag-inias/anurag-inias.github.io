# Go one-pager

Source [The Go Programming Language, Alan A. A. Donovan · Brian W. Kernighan](https://www.gopl.io)

## Basic Data Types

### Integer types

Size (bits) | Signed | Unsigned
------------|--------|----------
8           | `int8` | `uint8`
16          | `int16`| `uint16`
32          | `int32`| `uint32`
64          | `int64`| `uint64`

- `int` and `uint` size depend on the platform, typically 32 or 64 bits. 
- `rune` indicates a Unicode code point and is internally `int32`.
- `byte` is `uint8`, and denotes raw data.
- Range of signed _n-bit_ number is from $-2^{n-1}$ to ${2^{n-1}-1}$, e.g. `int8` ranges from `-128` to `127`.
- Range of unsigned _n-bit_ number is from $0$ to $2^n$., e.g. `uint8` ranges from `0` to `255`.
- Find ranges with `math` package: e.g. `[math.MinInt8, math.MaxInt8]`.
- Operator `%` only works on integers and in Go remainder has same sign as the dividend, i.e. both `-5%3` and `-5%-3` are `2`. 
- Right shift `>>` fills the vacated bits with sign bit.

??? question "Why not use unsigned types everywhere?"
    Length of an array can only be $[0, +\inf)$, so why not denote it with `uint`? Because `i--` in loops would underflow `0` to `255`, resulting in neverending loops.

### Floating point types

- Use `float64` for most purposes, which provides ~15 decimal of precision. `float32` provides ~6 decimal places precision and accumulates error fast. THere is no unsigned variant.
    ```go
    var f float32 = 16777216 // 1 << 24
    fmt.Println(f == f+1) // "true"!
    ```
- `math.Nan()` returns a `float64`.
    ```go
    var z float64
    z, -z, 1/z, -1/z, z/z // 0, -0, +Inf, -Int, NaN 

    nan := math.NaN()
    nan == nan, nan != nan, nan > nan // false, true, false
    ```

- `complex64` and `complex128` are supported as primitive:
    ```go
    var z complex128 = complex(1, 2) // 1+2i made of float64 real and imaginary parts
    real(z), imag(z) // 1, 2
    ```
    only supports `==` and `!=` operators, but not `>` / `<`.

### String types

- Immutable sequence of bytes. `s[2] = 'L'` will return in compiler error.
- `len(string)` returns number of bytes and not rune (use `utf8.RuneCountInString`), same with `s[i]` which returns _i-th_ byte.
- `s[i:j]` half-open interval, from _i-th_ byte to, but not including the _j-th_ byte.
- `==` and `<` operators perform byte-by-byte comparison.   
- Use backticks for writing raw string literal ` `` `.

???+ "Detour into Unicode"
    - Back in the day, ASCII was all you needed. Used 7 bits to represent 128 characters (upper/lower case english, number and symbols). But wouldn't scale for rest of the world.
    - Unicode solves by using `int32` (i.e. `rune`) to hold all possible characters across all possible languages. This format is called UTF-32, and obviously, it's wastes too many bits for most people.
    - UTF-8 is variable length encoding:
      - Uses between 1 and 4 bytes. 1 byte for ASCII, and 2 / 3 bytes for the rest.
      - A high-order `0` indicates 7-bit ASCII to follows.
      - compact, compatible with ASCII, self-synchronizing.

    Example | Encoding
    --------|------------
    `0xxxxxxx` | runes `0−127` (ASCII)
    `110xxxxx 10xxxxxx` | `128−2047` (values <128 unused)
    `1110xxxx 10xxxxxx 10xxxxxx` | `2048−65535` (values <2048 unused)
    `11110xxx 10xxxxxx 10xxxxxx 10xxxxxx` | `65536−0x10ffff` (other values unused)

- UTF-8 is the preferred encoding in Go programs.
- Most string operations don't require decoding due to the nice properties of UTF-8. e.g. prefix, suffic, substring check.
- Go's `range` loop, when applied to strings, automatically decodes byte(s) to rune.

### Constants

Expressions whole value is evaluated at compile time. Must be boolean/string/number. Operations on constants (multiplication, comparison etc) are themselves constant. Constants are not committed to any type, and we may assume at least 256 bits of precision. This allows participation across multiple expression w/o requiring casting.

```go
const (
  e = 2.71828182845904523536028747135266249775724709369995957496696763
  pi = 3.1415
)

const IPv4Len = 4
var p [IPv4Len]byte // can appear in types

const (
  a = 1  // 1
  b      // 1 reused for b
  c = 2  // 2
  d      // 2 reused for d
)

type Weekday int
const (
  Sunday Weekday = iota // 0
  Monday                // 1
  Tuesday               // 2
  Wednesday             // 3
  Thursday              // 4
  Friday                // 5
  Saturday              // 6
)
```

----------------------

## Detour: Zero Values

Type   | Zero value     | Categories
-------|----------------|-------------
boolean| false          | Basic type
number | `0` or `0f`    | Basic type
string | `""`           | Basic type
array  | fields zeroed  | Aggregate type
struct | fields zeroed  | Aggregate type
slice  | `nil`          | Container/reference type
map    | `nil`          | Container type
pointer| `nil`          | Reference type
interface| `nil`        | ???
channel  | `nil`        | ???

----------------------

## Composite Types

_arrays, slices, maps,_ and _structs_.


### Array
Fixed length sequence of $0+$ elements of the same type. Size is part of the type, so `[3]int` is different from `[4] int`.

```go
q := [3]int{1, 2, 3}
r := [...]int{99: -1}   // 100 elements, all but the last one is zero.

a, b, c := [2]int{1, 2}, [...]int{1, 2}, [3]int{1, 2. 3}
a == b, a == c, b == c  // true, false, error 
```

### Slice

A window inside an array. Has three components:

1. pointer - first element of an array accessible from this slice. Not necessarily the first element of the array.
2. capacity - usually the number of elements between the **start of the slice** and the **end of the underlying array**.
3. length - number of slice elements, must be $\le$ than `capacity`.

As such, copying a slice creates an alias.

```go
arr := [3]int{1, 2, 3}  // underlying array
s := arr[:]             // slice spanning the whole array
cap(s), len(s)          // 3, 3

s = append(s, 4)        // [1 2 3 4]
cap(s), len(s)          // 6, 4 growth strategy may be more sophisticated

s[4:]                   // [] 
s[:6]                   // [1 2 3 4 0 0] safe to slice beyond len(s)
s[:7]                   // panic! slice beyond cap(s)!

s := make([]int, len)
s := make([]int, len, cap) // or make([]int, cap)[:length]
```

??? info "Slices cannot be compared with `==`"
    - Slices can contain themselves, and as such deep checks are required to safely compare them.
    - Slices are mutable, and would mess up `map`s from functioning correctly.

### Map

is a **reference** to a hash table. 

```go
m := make(map[int]bool)
m := map[int]bool{}         // alternative format

m := map[int]bool {         // literal format
  1: true
  2: false
}

delete(map, 1)              // {2: false}
&m[1]                       // error! map keys are not addressable (to account for rehashing)

for key, value := range m {
  m[key] += value           // order is random in each iteration
}

var m map[int]bool 
m[1] = false                // panic! cannot store to a nil map
delete(m, 0)                // delete is safe
m[0]                        // lookup is safe
len(m)                      // len is safe
for _, _ := range m {...    // range is safe

m[19]                       // will always yield a value, check second returned value "ok"
```