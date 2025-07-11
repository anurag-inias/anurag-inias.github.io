# Split list into k-partitions of equal sum

## Description

Given an array $A$ split it into $k$ sets such that elements of each group have the same sum.

## Example

$A = 7, 3, 5, 12, 2, 1, 5, 3, 8, 4, 6, 4$

=== "$k = 1$"

    only one group that has the sum $60$

    - $7, 3, 5, 12, 2, 1, 5, 3, 8, 4, 6, 4$

=== "$k = 2$"

    each group has the sum $30$

    - $5, 3, 8, 4, 6, 4$
    - $7, 3, 5, 12, 2, 1$

=== "$k = 3$"

    each group has the sum $20$

    - $2, 1, 3, 4, 6, 4$
    - $7, 5, 8$
    - $3, 5, 12$

=== "$k = 4$"

    each group has the sum $15$

    - $1, 4, 6, 4$
    - $2, 5, 8$
    - $12, 3$
    - $7, 3, 5$

=== "$k = 5$"

    each group has the sum $12$

    - $2, 6, 4$
    - $8, 4$
    - $3, 1, 5, 3$
    - $12$
    - $7, 5$

## Stub

```kotlin linenums="1" hl_lines="12"
fun main() {
  val array = intArrayOf(7, 3, 5, 12, 2, 1, 5, 3, 8, 4, 6, 4)
  for (size in 1..5) {
    val desiredSum = array.sum() / size
    println("Partition size: $size, Partition sum: $desiredSum")
    partitionSplit(array, size)
    println()
  }
}

fun partitionSplit(array: IntArray, partitionCount: Int) {
  /* Fill here */
}
```

## Solution

??? "Expand"

    This is a bit more involved that the examples we have tried so far. This time, we maintain a `currentSet` as a candidate group. We add elements to it and see if the `currentSet` sums up to the `desiredSum`.

    If it does, add `currentSet` to output and reset `currentSet` back to empty and start processing the remaining elements again.

    If it does not, then we pop the element from `currentSet`, i.e. **backtrack**.


    ```kotlin linenums="1"
    fun partitionSplit(array: IntArray, partitionCount: Int) {
      val desiredSum = array.sum() / partitionCount
      val sets = mutableListOf<List<Int>>()
      helper(array, desiredSum, mutableListOf(), mutableSetOf(), sets)
      println(sets)
    }

    fun helper(
      array: IntArray,
      desiredSum: Int,
      currentSet: MutableList<Int>,
      usedElements: MutableSet<Int>,
      sets: MutableList<List<Int>>,
    ) {
      val sum = currentSet.sum()
      // One of the set is done with the desired sum, add it to our output.
      // And start creating the next group.
      if (sum == desiredSum) {
        sets.add(currentSet.toList())
        currentSet.clear()
        return
      }
      if (sum > desiredSum) return

      for ((i, v) in array.withIndex()) {
        if (i in usedElements) continue
        currentSet.add(v)
        usedElements.add(i)
        helper(array, desiredSum, currentSet, usedElements, sets)

        if (currentSet.isEmpty()) continue
        currentSet.removeLast()
        usedElements.remove(i)
      }
    }
    ```
