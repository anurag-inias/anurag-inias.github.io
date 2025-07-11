# Find ways to calculate a target from elements of the specified array

## Description

Given an integer array, return the ways to calculate the specified target from the array element using only addition and subtraction operator.

## Example

Let $A = 5, 3, -6, 2$ and $\text{target} = 6$ as:

- $- (-6) = 6$
- $5 + 3 - 2 = 6$
- $5 - 3 - (-6) - 2 = 6$
- $-5 + 3 - (-6) + 2 = 6$

## Stub

```kotlin linenums="1"
fun main() {
  val array = intArrayOf(5, 3, -6, 2)
  countWays(array, 6)
}

fun countWays(array: IntArray, target: Int) {
  /* Fill here */
}
```

## Solution

??? "Expand"

    ```kotlin linenums="1"
    fun countWays(array: IntArray, target: Int) {
      for (i in array.indices) {
        helper(array, target, mutableListOf(), i)
      }
    }

    fun helper(array: IntArray, target: Int, set: MutableList<Int>, cursorIndex: Int) {
      set.add(array[cursorIndex])
      if (set.sum() == target) {
        println(set)
        println()
        set.removeLast()
        return
      }
      for (i in (cursorIndex + 1)..<array.size) {
        helper(array, target, set, i)
      }
      set.removeLast()

      // Same as above, just the sign flipped.
      set.add(-array[cursorIndex])
      if (set.sum() == target) {
        println(set)
        println()
        set.removeLast()
        return
      }
      for (i in (cursorIndex + 1)..<array.size) {
        helper(array, target, set, i)
      }
      set.removeLast()
    }
    ```
