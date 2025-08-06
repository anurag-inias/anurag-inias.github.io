# Find the largest subarray having an equal number of 0’s and 1’s

## Description

Given an array of $0$s and $1$s, find the longest subarray with equal number of $0$s and $1$s.

## Placeholder

```kotlin
fun findLargestSubarray(nums: IntArray): IntArray {
  // Fill here
}

@Test
fun simple() {
  assertThat(
    findLargestSubarray(intArrayOf(0, 0, 1, 0, 1, 0, 0))
  ).isEqualTo(intArrayOf(0, 1, 0, 1)) // or 1, 0, 1, 0

  assertThat(
    findLargestSubarray(intArrayOf(1, 0, 1, 1, 1, 0, 0))
  ).isEqualTo(intArrayOf(0, 1, 1, 1, 0, 0))

  assertThat(
    findLargestSubarray(intArrayOf(0, 0, 1, 1, 0))
  ).isEqualTo(intArrayOf(0, 0, 1, 1)) // or 0, 1, 1, 0

  assertThat(
    findLargestSubarray(intArrayOf(0))
  ).isEmpty()
}
```

## Hint

??? "Expand"

    Mostly same as [001-check-subarray-with-0-sum-exists-not](001-check-subarray-with-0-sum-exists-not.md)

## Solution

??? "Expand"

    Instead of checking for already seen `sum`s, check for already seen `diff`. Here diff is |number of 0 - number of 1|.

    ```kotlin
    fun findLargestSubarray(nums: IntArray): IntArray {
      if (nums.isEmpty()) return intArrayOf()

      var solution: IntRange = IntRange.EMPTY
      var diff = 0
      var seen = mutableMapOf(0 to mutableListOf(-1))

      for ((i, v) in nums.withIndex()) {
        diff += if (v == 0) 1 else -1

        if (diff in seen) {
          for (start in seen[diff]!!) {
            val range = (start + 1)..i
            if (range.count() > solution.count()) {
              solution = range
            }
          }
        }

        seen.putIfAbsent(diff, mutableListOf())
        seen[diff]?.add(i)
      }

      return nums.sliceArray(solution)
    }
    ```
