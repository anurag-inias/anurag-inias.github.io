# Quicksort

## tl;dr

We start with the partitioning as [discussed previously](/partition/partition) and repeatedly partition the input in smaller and smaller chunks, implicitly sort them.

=== "pseudocode"

    ```ruby linenums="1"
    quicksort(array):
      if (array.length < 2) return

      pivotIndex = partition(array)
      quicksort(array[0, pivotIndex))
      quicksort(array[pivotIndex, array.length))
    ```

=== "kotlin"

    ```kotlin linenums="1"
    fun <T: Comparable<T>> MutableList<T>.quickSort(start: Int = 0, end: Int = size) {
      if (end - start + 1 < 2) return

      val (ps, pe) = partition(start, end)
      quickSort(start, ps)
      quickSort(pe, end)
    }

    private fun <T: Comparable<T>> MutableList<T>.partition(start: Int, end: Int): Pair<Int, Int> {
      var l = start; var c = start; var r = end - 1; val pivot = this[start]

      while (c <= r) {
        when(this[c].compareTo(pivot)) {
          -1 -> swap(l++, c++)
           0 -> c++
           1 -> swap(c, r--)
        }
      }

      return Pair(l, c)
    }

    private fun <T> MutableList<T>.swap(i: Int, j: Int) {
      val t = this[i]
      this[i] = this[j]
      this[j] = t
    }

    ```

=== "tests"

    ```kotlin linenums="1"
    import org.junit.jupiter.api.Assertions.*
    import org.junit.jupiter.api.Test
    import java.util.concurrent.ThreadLocalRandom
    import kotlin.streams.toList

    class QuickSortTest {

      @Test
      fun empty() {
        val list = mutableListOf<Int>()
        list.quickSort()
        assertEquals(listOf<Int>(), list)
      }

      @Test
      fun single() {
        val list = mutableListOf(6)
        list.quickSort()
        assertEquals(listOf(6), list)
      }

      @Test
      fun double() {
        var list = mutableListOf(2, 6)
        list.quickSort()
        assertEquals(listOf(2, 6), list)

        list = mutableListOf(6, 2)
        list.quickSort()
        assertEquals(listOf(2, 6), list)
      }

      @Test
      fun triple() {
        var list = mutableListOf(2, 6, 10)
        list.quickSort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(2, 10, 6)
        list.quickSort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(6, 2, 10)
        list.quickSort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(6, 10, 2)
        list.quickSort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(10, 2, 6)
        list.quickSort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(10, 6, 2)
        list.quickSort()
        assertEquals(listOf(2, 6, 10), list)
      }

      @Test
      fun fuzzy() {
        val list = ThreadLocalRandom.current().ints(100, 0, 80).toList().toMutableList()
        val copy = list.toMutableList()
        assertEquals(list, copy)
        copy.sort()
        assertNotEquals(list, copy)

        list.quickSort()

        assertEquals(list, copy)
      }

    }
    ```