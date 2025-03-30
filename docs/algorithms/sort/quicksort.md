# Quicksort

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style>
.md-logo img {
  content: url('/algorithms/sort/sort-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/sort/sort-dark.svg');
}
</style>

## tl;dr

We start with the partitioning as [discussed previously](../partition/partition.md) and repeatedly partition the input in smaller and smaller chunks, implicitly sorting them.

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
      // end is excluded, that's why length is not end - start + 1
      if (end - start < 2) return

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

=== "golang"

    ```golang linenums="1" title="quicksort.go"
    package libs

    type intSlice []int

    func (slice intSlice) Partition(pivot, start, end int) (int, int) {
      l, c, r := start, start, end-1
      for c <= r {
        switch {
        case slice[c] < pivot:
          {
            slice[l], slice[c] = slice[c], slice[l]
            l++
            c++
          }
        case slice[c] == pivot:
          {
            c++
          }
        default: // slice[c] > pivot
          {
            slice[c], slice[r] = slice[r], slice[c]
            r--
          }
        }
      }
      return l, c
    }

    func (slice intSlice) quickSort(start, end int) {
      if start >= end-1 {
        return
      }

      pivot := slice[start]
      l, c := slice.Partition(pivot, start, end)
      slice.quickSort(start, l)
      slice.quickSort(c, end)
    }

    func QuickSort(a []int) {
      if len(a) == 0 {
        return
      }
      intSlice(a).quickSort(0, len(a))
    }
    ```

=== "tests"

    ```golang linenums="1" title="sort_test.go"
    package libs

    import (
      "fmt"
      rand2 "math/rand"
      "slices"
      "testing"
    )

    type Suite struct {
      input, expected []int
    }

    func TestEmpty(t *testing.T) {
      var a []int
      QuickSort(a)
      if fmt.Sprintf("%v", a) != "[]" {
        t.Fatalf("Expected an empty slice")
      }
    }

    func TestSimple(t *testing.T) {
      suite := []Suite{
        {input: []int{}, expected: []int{}},
        {input: []int{1}, expected: []int{1}},
        {input: []int{1, 2}, expected: []int{1, 2}},
        {input: []int{2, 1}, expected: []int{1, 2}},
        {input: []int{1, 2, 3}, expected: []int{1, 2, 3}},
        {input: []int{1, 3, 2}, expected: []int{1, 2, 3}},
        {input: []int{2, 1, 3}, expected: []int{1, 2, 3}},
        {input: []int{2, 3, 1}, expected: []int{1, 2, 3}},
        {input: []int{3, 1, 2}, expected: []int{1, 2, 3}},
        {input: []int{3, 2, 1}, expected: []int{1, 2, 3}},
        {input: []int{1, 2, 3, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 2, 4, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 3, 2, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 3, 4, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 4, 2, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 4, 3, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 1, 3, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 1, 4, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 3, 1, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 3, 4, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 4, 1, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 4, 3, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 1, 2, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 1, 4, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 2, 1, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 2, 4, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 4, 1, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 4, 2, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 1, 2, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 1, 3, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 2, 1, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 2, 3, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 3, 1, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 3, 2, 1}, expected: []int{1, 2, 3, 4}},
      }

      for _, entry := range suite {
        before := fmt.Sprintf("%v", entry.input)
        QuickSort(entry.input)
        result := fmt.Sprintf("%v", entry.input)
        expected := fmt.Sprintf("%v", entry.expected)

        if result != expected {
          t.Fatalf("With %v expected %s, but got %s", before, expected, result)
        }
      }
    }

    func TestFuzzy(t *testing.T) {
      var treat, ctrl []int
      rand := rand2.New(rand2.NewSource(100))

      for i := 0; i < 100; i++ {
        value := rand.Intn(50)
        treat = append(treat, value)
        ctrl = append(ctrl, value)
      }

      slices.Sort(ctrl)
      QuickSort(treat)

      result := fmt.Sprintf("%v", treat)
      expected := fmt.Sprintf("%v", ctrl)

      if result != expected {
        t.Fatalf("expected %s, but got %s", expected, result)
      }
    }
    ```

## Complexity

| Scenario | Comparisons  |
| -------- | ------------ |
| Worst    | $O(n^2)$     |
| Average  | $O(n\log n)$ |
| Best     | $O(n\log n)$ |

Space complexity of $O(n)$ in naive implementation and $O(\log n)$ in Hoare's implementation.

## Properties

Quick sort implementation in real-world tend to use a number of heuristics to avoid worst case scenario, and at times use insertion sort for smaller / partially sorted arrays.

It also has better _locality of reference_ and tend to out perform _Heap sort_ by $2-3x$ times. In places where a malicious input is a risk (e.g. Linux kernel), heap sort is preferred.

## Benchmark

<div id="chart_short_range"></div>

<div id="chart_long_range"></div>

<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawShortChart);
google.charts.setOnLoadCallback(drawLongChart);

function drawShortChart() {
  var data = google.visualization.arrayToDataTable([
    ['input size','20n log(n)','library sort','homemade sort'],
    [10000,2657542.5,8579700,12978100],
    [20000,5715085.0,8618400,6745000],
    [30000,8923605.0,13639600,9352600],
    [40000,1.223017E7,20403400,8927800],
    [50000,1.560964E7,23154400,14208500],
    [60000,1.904721E7,15855400,26193700],
    [70000,2.2533096E7,18425100,22903700],
    [80000,2.606034E7,21377800,24990900],
    [90000,2.9623748E7,26580900,25130800],
    [100000,3.321928E7,27565800,29970400],
  ]);

  var options = {
    title: 'Zoomed-in',
    curveType: 'function',
    legend: { position: 'bottom' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('chart_short_range'));

  chart.draw(data, options);
}

function drawLongChart() {
  var data = google.visualization.arrayToDataTable([
    ['input size','20n log(n)','library sort','homemade sort'],
    [100000,3.321928E7,61765300,80557900],
    [200000,7.043856E7,70507500,69049200],
    [300000,1.0916762E8,102400600,142423500],
    [400000,1.4887712E8,130109200,201497000],
    [500000,1.8931568E8,173156200,239819300],
    [600000,2.3033523E8,213642700,299351300],
    [700000,2.7183795E8,256884200,394437700],
    [800000,3.1375424E8,355155300,461105000],
    [900000,3.560322E8,390279600,609517700],
    [1000000,3.9863136E8,460704300,716952500],
  ]);

  var options = {
    title: 'Zoomed-out',
    curveType: 'function',
    legend: { position: 'bottom' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('chart_long_range'));

  chart.draw(data, options);
}
</script>

```kotlin title="benchmark code" linenums="1"
@Test
fun benchmark() {
  println("['input size','20n log(n)','library sort','homemade sort'],")
  for (n in listOf(100_000, 200_000, 300_000, 400_000, 500_000, 600_000, 700_000, 800_000, 900_000, 1_000_000)) {
    val list = ThreadLocalRandom.current().ints(n.toLong(), 0, n / 2).toList().toMutableList()
    val copy = list.toList().toMutableList()

    var start = System.nanoTime()
    list.quickSort()
    val durationHomemade = System.nanoTime() - start

    start = System.nanoTime()
    copy.sort()
    val durationLib = System.nanoTime() - start

    val expected = 20 * n * log2(n.toFloat())

    println("[$n,$expected,$durationLib,$durationHomemade],")
  }
}
```
