# Find the duplicate element in a limited range array

## Description

Given an array of size $n$, containing elements in $[1, n)$ with one element repeating, find the repeating one.

## Placeholder

```kotlin linenums="1"
fun findDuplicateIn1ToNminusOne(nums: IntArray): Int {
  // Fill here
}

@Test
fun simple() {
  assertThat(
    findDuplicateIn1ToNminusOne(intArrayOf(1, 2, 2))
  ).isEqualTo(2)

  assertThat(
    findDuplicateIn1ToNminusOne(intArrayOf(3, 1, 3, 2))
  ).isEqualTo(3)
}
```

## Hint

??? "Expand"

    XOR

## Solution

=== "Approach 1"

    ??? "Expand"

        Hash

=== "Approach 2"

    ??? "Expand"

        XOR the whole array $xor = 1 \oplus 2 \oplus \dots n-1$. Then XOR $[1, n)$. The non-duplicate elements will cancel each other out and we will be left with duplicate element.

        ```kotlin linenums="1"
        fun findDuplicateIn1ToNminusOne(nums: IntArray): Int {
          var x = 0

          for (n in nums) {
            x = x xor n
          }

          for (i in 1 until nums.size) {
            x = x xor i
          }

          return x
        }
        ```

=== "Approach 3"

    ??? "Expand"

        Use array indices.

        Array is of size $n$ and conveniently the values are all ranged $[1, n)$. That means $1$ can be placed at index $1$, $2$ can be placed at index $2$, ..., $n-1$ can be placed at index $n-1$. Instead of using an auxilliary array, we can flip the signs of elements (since all elements are positive) to convey elements that are already processed.

        ```kotlin linenums="1"
        fun findDuplicateIn1ToNminusOne(nums: IntArray): Int {
          for (v in nums) {
            val v = abs(v)

            if (nums[v] >= 0) {
              nums[v] = -nums[v] // Use negative sign to convey elements already seen.
            } else {
              return v
            }
          }

          return -1
        }

        private fun IntArray.swap(i: Int, j: Int) {
          val t = this[i]
          this[i] = this[j]
          this[j] = t
        }
        ```
