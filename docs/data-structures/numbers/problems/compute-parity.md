# Computing the parity of a word

## Problem

Parity of a word is 1 if number of 1s in the word is odd; otherwise it is 0.

## Example

| word     | parity |
| -------- | ------ |
| 1011     | 1      |
| 10001000 | 0      |

## First approach

??? "Hint"

    `x & (x-1)` will unset the rightmost set bit.

??? "Solution"

    ```golang
    func parity(x int) int {
      p := 0
      for x != 0 {
        p = 1 - p // flip a bit back-and-forth between 0 and 1
        x = x & (x - 1)
      }
      return p
    }
    ```

## Second approach

??? "Hint"

    Lookup table

??? "Solution"

    Instead of checking individual bit by bit, check parity of N bits at a time.

    ```golang linenums="1"
    func parity2(x int) int {
      pmap := map[int]int{
        0b0000: 0,
        0b0001: 1,
        0b0010: 1,
        0b0011: 0,
        0b0100: 1,
        0b0101: 0,
        0b0110: 0,
        0b0111: 1,
        0b1000: 1,
        0b1001: 0,
        0b1010: 0,
        0b1011: 1,
        0b1100: 0,
        0b1101: 1,
        0b1110: 1,
        0b1111: 0,
      }
      mask := 0b1111

      p := 0
      for i := 0; i < 8; i++ {
        if v, ok := pmap[(x & mask)]; ok && v != 0 {
          p = 1 - p
        }
        x = x >> 4
      }

      return p
    }
    ```
