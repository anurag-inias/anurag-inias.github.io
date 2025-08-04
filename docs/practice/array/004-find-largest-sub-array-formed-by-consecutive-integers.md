# Find the largest subarray formed by consecutive integers

## Description

Given an integer array, find the longest subarray formed by distinct consecutive integers. For example $2, 1, 0, 3$.

## Placeholder

```kotlin
fun findMaxSubarray(nums: IntArray): IntArray {
  // Fill here
}

@Test
fun simple() {
  assertThat(
    findMaxSubarray(intArrayOf(2, 0, 2, 1, 4, 3, 1, 0))
  ).isEqualTo(intArrayOf(0, 2, 1, 4, 3))

  assertThat(
    findMaxSubarray(intArrayOf(8, 2, 5, 1, 0, 3, 4, 9))
  ).isEqualTo(intArrayOf(2, 5, 1, 0, 3, 4))
}
```

## Hint

??? "Expand"

    Sliding window, but with some wasteful work.

## Solution

=== "Explanation"

    ??? "Expand"

        Keep an outermost loop for the start of the candidate subarray `start`. Inside it, run another loop for the end of the subarray. That's what you'll also use in a brute force solution.

        However, in a brute force solution you'll evaluate over and over the range $[start, end]$ to see if it has distinct elements and if they make an array of consecutive elements.

        Instead use a set for tracking seen elements. And use `min` and `max` to see if elements are consecutive. That is, if elements are from range `start..end`, spread in range `min..max` and there are no duplicates, then the subarray is consecutive if `end - start + 1 = length = max - min + 1`.

        So we find a solution in $O(n^2)$ instead of $O(n^3)$.

=== "Implementation"

    ??? "Expand"

        ```kotlin
        fun findMaxSubarray(nums: IntArray): IntArray {
          if (nums.isEmpty()) return intArrayOf()

          var solution = intArrayOf(nums[0]) // there is always a solution possible with just one element.

          for (start in 0..<nums.size - 1) { // subarray [start, ..., end]
            var min = nums[start]
            var max = nums[start]
            val seen = mutableSetOf(nums[start])

            for (end in (start + 1) until nums.size) {
              if (nums[end] in seen) {       // Found [A, x, x, x, A]. So slide the window to the right.
                break
              }
              seen += nums[end]
              min = min(min, nums[end])
              max = max(max, nums[end])

              val len = end - start + 1
              val isConsecutive = max - min + 1 == len
              if (isConsecutive && len > solution.size) {
                solution = nums.sliceArray(start..end)
              }
            }
          }

          return solution
        }
        ```
