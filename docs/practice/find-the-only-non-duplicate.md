# Find the only non-duplicate number in an array

<style>
.md-logo img {
  content: url('/practice/practice-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/practice/practice-dark.png');
}
</style>

## Problem

Given an array where all but one element appear twice, find the single element.

## Example

- $nums = 2, 1, 2$
- $ans = 1$

## Solution

??? "Approach"

    XOR all elements.

??? "Expand"

    ```kotlin linenums="1"
    fun singleNumber(nums: IntArray): Int {
      var xor = 0
      for (n in nums) {
        xor = xor xor n
      }
      return xor
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun example_1() {
  assertThat(singleNumber(intArrayOf(2, 2, 1))).isEqualTo(1)
}

@Test
fun example_2() {
  assertThat(singleNumber(intArrayOf(4, 1, 2, 1, 2))).isEqualTo(4)
}

@Test
fun example_3() {
  assertThat(singleNumber(intArrayOf(1))).isEqualTo(1)
}
```

## Extras

??? "Things to watch out"

    Using `reduce` from streaming APIs is significantly slower. `24ms` compared to `1ms` previously.

    ```kotlin
    nums.reduce { acc, i -> acc.xor(i)  }
    ```

    Even `xor` extension is slower than the actual `xor` operation. It's `2ms` compared to `1ms` lead.

    ```kotlin linenums="1"
    fun singleNumber(nums: IntArray): Int {
      var xor = 0
      for (n in nums) {
        xor = xor.xor(n)
      }
      return xor
    }
    ```
