# In-place merge two sorted arrays

## Description

Given two sorted arrays, possibly of different lengths, merge them in such a way that first array is filled with smallest number of the two arrays and second array is filled with the largest elements of the two array, and both are still sorted.

## Example

```
Input:
    first = intArrayOf(4, 9, 10)
    second = intArrayOf(1, 2, 3, 7, 8)

Output
    first = intArrayOf(1, 2, 3)
    second = intArrayOf(4, 7, 8, 9, 10)
```

## Placeholder

```kotlin
fun mergeSorted(first: IntArray, second: IntArray) {
  // Fill here
}


@Test
fun simple() {
  var first = intArrayOf(1, 4, 7, 8, 10)
  var second = intArrayOf(2, 3, 9)
  mergeSorted(first, second)
  assertThat(first).isEqualTo(intArrayOf(1, 2, 3, 4, 7))
  assertThat(second).isEqualTo(intArrayOf(8, 9, 10))


  first = intArrayOf(1, 8, 10)
  second = intArrayOf(2, 3, 4, 7, 9)
  mergeSorted(first, second)
  assertThat(first).isEqualTo(intArrayOf(1, 2, 3))
  assertThat(second).isEqualTo(intArrayOf(4, 7, 8, 9, 10))

  first = intArrayOf(4, 9, 10)
  second = intArrayOf(1, 2, 3, 7, 8)
  mergeSorted(first, second)
  assertThat(first).isEqualTo(intArrayOf(1, 2, 3))
  assertThat(second).isEqualTo(intArrayOf(4, 7, 8, 9, 10))
}
```

## Solution

??? "Expand"

    ```kotlin
    fun mergeSorted(first: IntArray, second: IntArray) {
      if (first.isEmpty() || second.isEmpty()) return // nothing to do if either array is empty
      if (first.last() < second.first()) return       // nothing to do if first < second

      var f = 0
      var s = 0
      while (f < first.size && s < second.size) {
        if (first[f] <= second[s]) {                  // first's element is smaller
          f++
          continue
        }

        // Swap if second's element is smaller.
        val t = first[f]
        first[f] = second[s]
        second[s] = t
        f++

        // After swap, the sorting of second array can break.
        // Insertion sort the second.
        var i = s
        while (i < second.size - 1 && second[i] > second[i + 1]) {
          second.swap(i, i + 1)
          i++
        }
      }
    }
    ```
