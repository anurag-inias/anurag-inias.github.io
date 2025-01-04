# Basic Types

<style>
.md-logo img {
  content: url('/go/logo-go.svg');
}
</style>

There are 4 base categories of data types in Go:

1. _basic types_: integers, strings, booleans.
2. _aggregate types_: arrays and structs.
3. _reference types_: pointers, slices, maps, functions, and channels.
4. _interface types_

## Integers

`int` and `uint`, can be either 32 or 64 bits depending on hardware and compiler.

`rune` is synonym for `int32` and indicates a Unicode code point.

`byte` is same as `uint8`.

`uintptr` has sufficient, but unspecified width to hold values of a pointer.

## Strings

Immutable sequence of bytes.

```golang
s := "hello, world"
fmt.Println(len(s)) // 12
fmt.Println(s[0]) // 104 'h'
```

### Unicode

- ASCII used 7-bits to represent 128 characters.
- Unicode was introduced to expand support for more languages, but would need 32-bits (UTF-32) with a uniform code point size.

### UTF-8

used a variable-length encoding and is now Unicode standard.

It uses 1 to 4 bytes to represent each code point (rune). ASCII characters take 1 byte, with the 8th bit used to represent how many butes follow.

| code point                            | int32 value    | notes                                                                 |
| ------------------------------------- | -------------- | --------------------------------------------------------------------- |
| `0xxxxxxx`                            | runes 0-127    | Same as ASCII                                                         |
| `110xxxxx 10xxxxxx`                   | 128-2047       | values $<128$ unused <br> msb `110` means rune will take 2 bytes      |
| `1110xxxx 10xxxxxx 10xxxxxx`          | 2048−65535     | values $<2048$ unused <br> msb `1110` indicate rune will take 3 bytes |
| `11110xxx 10xxxxxx 10xxxxxx 10xxxxxx` | 65536−0x10ffff | other values unused <br> msb `11110` indicate rune will take 4 bytes  |

### Operations

Due to UTF-8 properties, many string operations don't requiring worrying about the code points nitty-gritty details.

=== "Prefix check"

    ```golang
    func HasPrefix(s, prefix string) bool {
      return len(s) >= len(prefix) && s[:len(prefix)] == prefix
    }
    ```

=== "Suffix check"

    ```golang
    func HasSuffix(s, suffix string) bool {
      return len(s) >= len(suffix) && s[len(s)-len(suffix):] == suffix
    }
    ```

=== "Substring check"

    ```golang
    func Contains(s, substr string) bool {
      for i := 0; i < len(s); i++ {
        if HasPrefix(s[i:], substr) {
          return true
        }
      }
      return false
    }
    ```

To process individual Unicode characters, we need to use `unicode/utf8` package utilities.

=== "Accessing individual runes"

    ```golang
    s := "❋⁂"
    for i := 0; i < len(s); {
      r, size := utf8.DecodeRuneInString(s[i:])
      fmt.Printf("%d %c", i, r)
      fmt.Println()
      i += size
    }
    ```

    ```
    0 ❋
    3 ⁂
    ```

    Go's `range` automatically performs UTF-8 decoding:

    ```golang
    s := "❋⁂"
    for i, r := range s {
      fmt.Printf("%d %c\n", i, r)
    }
    ```

=== "Counting runes"

    ```golang
    import "unicode/utf8"

    s := "❋"
    fmt.Println(len(s))                    // 3
    fmt.Println(utf8.RuneCountInString(s)) // 1
    ```

### Common packages

- Use `strings` package for utils like `Contains`, `HasPrefix`, `Index` etc.
- Use `strconv` package to convert to and from numeric values.
- Use `fmt.Sprintf` for converting integers to string.
