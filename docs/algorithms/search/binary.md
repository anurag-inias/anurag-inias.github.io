# Binary Search

<style>
.md-logo img {
  content: url('/search/binary-search-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/search/binary-search-dark.svg');
}
</style>

## tl;dr

Finds an element in a sorted list. If not found, returns the place to insert said element.

=== "pseudocode"

    ```ruby linenums="1"
    search(array, needle):
      l = 0, r = array.length - 1
      while l <= r:
        m = (l + r) / 2
      
        switch(needle):
          < array[m] => r = m - 1
          = array[m] => return (m, found)
          > array[m] => l = m + 1
      
      return (l, not found)
    ```

=== "kotlin"

	```kotlin linenums="1"
	fun <T: Comparable<T>> List<T>.binarySearch(needle: T): Pair<Int, Boolean> {
	  var l = 0; var r = size - 1;
	  while (l <= r) {
	    val m = l + (r - l) / 2 // avoids overflow of (l+r)/2
	    when(needle.compareTo(this[m])) {
	      -1 -> r = m - 1
	       0 -> return Pair(m, true)
	       1 -> l = m + 1
	    }
	  }
	  return Pair(l, false) // l and r have swapped boundary
	}
	```

=== "tests"

	```kotlin linenums="1"
	package search

	import org.junit.jupiter.api.Assertions.*
	import org.junit.jupiter.api.Test
	import java.util.concurrent.ThreadLocalRandom
	import java.util.stream.IntStream
	import kotlin.streams.toList

	class BinarySearchTest {

	  @Test
	  fun searchEmpty() {
	    assertEquals(Pair(0, false), listOf<Int>().binarySearch(10))
	  }

	  @Test
	  fun searchOne() {
	    assertEquals(Pair(0, false), listOf(10).binarySearch(9))
	    assertEquals(Pair(0, true), listOf(10).binarySearch(10))
	    assertEquals(Pair(1, false), listOf(10).binarySearch(11))
	  }

	  @Test
	  fun searchTwo() {
	    assertEquals(Pair(0, false), listOf(8, 10).binarySearch(7))
	    assertEquals(Pair(0, true), listOf(8, 10).binarySearch(8))
	    assertEquals(Pair(1, false), listOf(8, 10).binarySearch(9))
	    assertEquals(Pair(1, true), listOf(8, 10).binarySearch(10))
	    assertEquals(Pair(2, false), listOf(8, 10).binarySearch(11))
	  }

	  @Test
	  fun fuzzySearchExistingKey() {
	    val list = ThreadLocalRandom.current().ints(100, 0, 80).sorted().toList().toMutableList()

	    val existingNeedle = list[ThreadLocalRandom.current().nextInt(100)]
	    val got = list.binarySearch(existingNeedle)

	    assertTrue(got.second)
	    assertEquals(existingNeedle, list[got.first])
	  }

	  @Test
	  fun fuzzySearchBeyondStart() {
	    val list = ThreadLocalRandom.current().ints(100, 0, 80).sorted().toList().toMutableList()

	    val nonExistentNeedle = list[0] - 1
	    val got = list.binarySearch(nonExistentNeedle)

	    assertFalse(got.second)
	    assertEquals(0, got.first)
	  }

	  @Test
	  fun fuzzySearchBeyondEnd() {
	    val list = ThreadLocalRandom.current().ints(100, 0, 80).sorted().toList().toMutableList()

	    val nonExistentNeedle = list[list.size - 1] + 1
	    val got = list.binarySearch(nonExistentNeedle)

	    assertFalse(got.second)
	    assertEquals(list.size, got.first)
	  }

	  @Test
	  fun fuzzySearchMissingInRange() {
	    val list = ThreadLocalRandom.current().ints(100, 0, 80).sorted().toList().toMutableList()

	    val nonExistentNeedles = IntStream.range(0, 80).filter{ list.indexOf(it) < 0 }.filter{ it > list.first() && it < list.last() }.toList()
	    for (n in nonExistentNeedles) {
	      val got = list.binarySearch(n)

	      assertFalse(got.second)
	      assertTrue(list[got.first - 1] < n)
	      assertTrue(n < list[got.first])
	    }
	  }
	}
	```


## Examples

```
 0  1  2  3  4  : Index
[0, 2, 4, 6, 8] : Elements

insert -1 at 0
found   0 at 0
insert  1 at 1
found   2 at 1
insert  3 at 2
found   4 at 2
insert  5 at 3
found   6 at 3
insert  7 at 4
found   8 at 4
insert  9 at 5
insert 10 at 5
```