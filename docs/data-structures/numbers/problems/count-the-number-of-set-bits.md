# Count the number of set bits

## Problem

Writing a program to count the number of bits that are set to 1 in an integer.

## Example

```
    0 has  0 bits
 1011 has  3 bits
11111 has  5 bits
10100 has  2 bits
    1 has  1 bits
    0 has  0 bits
   -1 has 64 bits
```

## Hint

??? "Expand"

    `x & (x-1)` will unset the rightmost bit.

    ```
            x = aaaa 1000
          x-1 = aaaa 0111
    x & (x-1) = aaaa 0000
    ```

## Solution

??? "Expand"

    ```golang linenums="1"
    func countBits(x int) int {
      count := 0
      for x != 0 { // x > 0 would be a wrong check.
        count++
        x = x & (x - 1)
      }
      return count
    }
    ```
