# Sort binary array

## Description

Given an array of $0$s and $1$s, sort it in linear time.

## Example

```
Input:  { 1, 0, 1, 0, 1, 0, 0, 1 }
Output: { 0, 0, 0, 0, 1, 1, 1, 1 }
```

## Placeholder

```kotlin
fun sort(array: IntArray) {
  // Fill here
}

@Test
fun simple() {
  var array = intArrayOf(1, 0)
  sort(array)
  assertThat(array).isEqualTo(intArrayOf(0, 1))

  array = intArrayOf(1, 0)
  sort(array)
  assertThat(array).isEqualTo(intArrayOf(0, 1))

  array = intArrayOf(1, 0, 1)
  sort(array)
  assertThat(array).isEqualTo(intArrayOf(0, 1, 1))

  array = intArrayOf(1, 0, 0)
  sort(array)
  assertThat(array).isEqualTo(intArrayOf(0, 0, 1))

  array = intArrayOf(1, 0, 1, 0, 1, 0, 0, 1)
  sort(array)
  assertThat(array).isEqualTo(intArrayOf(0, 0, 0, 0, 1, 1, 1, 1))
}
```

## Solution

=== "Approach 1"

    ??? "Expand"

        Counting sort.

=== "Approach 2"

    ??? "Expand"

        Partitioning.

        ```kotlin linenums="1"
        fun sort(array: IntArray) {
          var cursor = 0
          for ((i, v) in array.withIndex()) {
            if (v == 0) {
              array.swap(cursor++, i)
            }
          }
        }

        private fun IntArray.swap(i: Int, j: Int) {
          val t = this[i]
          this[i] = this[j]
          this[j] = t
        }
        ```
