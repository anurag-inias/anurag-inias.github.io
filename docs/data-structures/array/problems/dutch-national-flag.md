# The Dutch National Flag Problem

## Problem

Given an array of numbers $a$ and a number $p$, rearrange the element such that all elements $<p$ appear first, followed by all numbers equal to $p$, ending with elements $>p$.

## Solution

??? "Approach"

    See [Partition](../../../algorithms/partition/partition.md) docs.

??? "Implementation"

    ```kotlin linenums="1"
    fun partition(inp: IntArray, pivot: Int): Pair<Int, Int> {
      var l = 0
      var c = 0
      var r = inp.size - 1

      while (c <= r) {
        when {
          inp[c] < pivot -> inp.swap(l++, c++)
          inp[c] == pivot -> c++
          else -> inp.swap(c, r--)
        }
      }

      return Pair(l, c)
    }

    private fun IntArray.swap(i: Int, j: Int) {
      val t = this[i]
      this[i] = this[j]
      this[j] = t
    }
    ```

## Unit tests

```kotlin linenums="1"
  @Test
fun simple() {
  var inp = intArrayOf(3, 2, 1)
  assertThat(partition(inp, 2)).isEqualTo(1 to 2)
  assertThat(inp).isEqualTo(intArrayOf(1, 2, 3))

  inp = intArrayOf(1, 2, 3, 3, 2, 1)
  assertThat(partition(inp, 2)).isEqualTo(2 to 4)
  assertThat(inp).isEqualTo(intArrayOf(1, 1, 2, 2, 3, 3))

  inp = intArrayOf(9, 8, 7, 6, 5, 4, 3, 2, 1)
  assertThat(partition(inp, 4)).isEqualTo(3 to 4)
  assertThat(inp).isEqualTo(intArrayOf(1, 2, 3, 4, 5, 6, 7, 8, 9))
}

@Test
fun random() {
  val original = ThreadLocalRandom.current().ints(1000, 0, 100).toArray()

  for (pivot in original) {
    val copy = original.copyOf()
    val partition = partition(copy, pivot)

    for (i in 0..<partition.first) assertThat(copy[i]).isLessThan(pivot)
    for (i in partition.first..<partition.second) assertThat(copy[i]).isEqualTo(pivot)
    for (i in partition.second..<original.size) assertThat(copy[i]).isGreaterThan(pivot)
  }
}
```
