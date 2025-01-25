# Merge overlapping intervals

<style>
.md-logo img {
  content: url('/practice/practice-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/practice/practice-dark.png');
}
</style>

## Problem

Given a set of intervals, merge all overlapping intervals until all remaining intervals are strictly disjoint.

## Example

```
                        -----------
             ------
            ---
      -----
  ---
---------
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
```

Input: $(1, 5) (2, 3) (4, 6) (7, 8) (8, 10) (12, 15)$

Output: $(1, 6) (7, 10), (12, 15)$

## Hint

??? "Expand"

    Sorting first.

## Solution

??? "Expand"

    ```kotlin linenums="1"
    fun overlapIntervals(list: List<Pair<Int, Int>>) : List<Pair<Int, Int>> {
      val sorted = list.sortedBy { it.first }
      val stack = ArrayDeque<Pair<Int, Int>>()

      for (interval in sorted) {
        if (stack.isEmpty()) {
          stack.addLast(interval)
        } else if (stack.last().overlaps(interval)) {
          stack.addLast(stack.removeLast().merge(interval))
        } else {
          stack.addLast(interval)
        }
      }

      return stack
    }

    private fun Pair<Int, Int>.overlaps(other: Pair<Int, Int>): Boolean {
      return other.first in first..second || other.second in first..second
    }


    private fun Pair<Int, Int>.merge(other: Pair<Int, Int>): Pair<Int, Int> {
      return Pair(min(first, other.first), max(second, other.second))
    }
    ```
