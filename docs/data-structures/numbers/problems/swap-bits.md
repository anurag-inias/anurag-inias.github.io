# Swap bits

## Problem

Given an interger $n$, swap its $i^{th}$ and $j^{th}$ bits.

## Example

```
n (11) = 1 0 1 1
 index = 3 2 1 0

swap(n, 1, 2)

n (13) = 1 1 0 1
 index = 3 2 1 0
```

## Hint

??? "Part 1"

    When do we need to swap two bits?

??? "Part 2"

    How do we flip a bit?

## Solution

??? "Explanation"

    First, understand that we only swap two bits if they aren't equal. That is, if `n = xxxxaxxxbxxx`, then `a != b`.

    Now if the two target bits aren't the same, swapping them is same as flipping them in-place. How do we do that? Consider this:

    | $a$ | $a \oplus \ 0$ | $a \oplus 1$ |
    | --- | -------------- | ------------ |
    | $0$ | $0$            | $1$          |
    | $1$ | $1$            | $0$          |

    which tells us:

    - $x \oplus 0 = x$, and
    - $x \oplus 1 = \overline x$

    That is, given `n = xxxxaxxxbxxx`, we can swap the bits by $\oplus$ operation with the mask `000010001000`.

??? "Implementation"

    ```kotlin linenums="1"
    fun swap(num: Int, i: Int, j: Int): Int {
      val a = (num shr i) and 1 // ith bit
      val b = (num shr j) and 1 // jth bit
      if (a != b) {
        return num xor (
            (1 shl i) or (1 shl j)
        )
      }
      return num
    }
    ```

## Unit test

```kotlin linenums="1"
@Test
fun simple() {
  assertThat(swap(0b00, 0, 1)).isEqualTo(0b00)
  assertThat(swap(0b11, 0, 1)).isEqualTo(0b11)
  assertThat(swap(0b01, 0, 1)).isEqualTo(0b10)
  assertThat(swap(0b10, 0, 1)).isEqualTo(0b01)

  assertThat(swap(0b1000100011, 1, 5)).isEqualTo(0b1000100011)
  assertThat(swap(0b1000100011, 1, 4)).isEqualTo(0b1000110001)
}
```
