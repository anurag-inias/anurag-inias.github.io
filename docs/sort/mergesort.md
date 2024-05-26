# Mergesort

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

## tl;dr

Keep spliting the input in half and sort the halves recursively.

=== "pseudocode"

    ```ruby linenums="1"
    mergesort(array):
      if array.length ≤ 2:
        sort it normally
        return

      left  = array[0, length / 2)
      right = array[length / 2, array.length)
      mergesort(left)
      mergesort(right)
      
      array = merge(left, right) 
    ```

=== "kotlin"

    ```kotlin linenums="1"
    fun <T: Comparable<T>> MutableList<T>.mergesort(start: Int = 0, end: Int = size) {
      val length = end - start
      if (length < 2) return
      if (length == 2) {
        if (this[start] > this[start + 1]) swap(start, start+1)
        return
      }

      val left = slice(0, length / 2)
      val right = slice(length / 2, length)
      left.mergesort()
      right.mergesort()

      var l = 0; var r = 0; var c = 0
      while (l < left.size && r < right.size) {
        if (left[l] < right[r]) this[c++] = left[l++]
        else this[c++] = right[r++]
      }
      while (l < left.size) this[c++] = left[l++]
      while (r < right.size) this[c++] = right[r++]
    }

    private fun <T> List<T>.slice(start: Int, end: Int): MutableList<T> {
      val copy = mutableListOf<T>()
      for (i in start..<end)
        copy.add(this[i])
      return copy
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
    import kotlin.math.log2
    import kotlin.streams.toList

    class MergeSortTest {

      @Test
      fun empty() {
        val list = mutableListOf<Int>()
        list.mergesort()
        assertEquals(listOf<Int>(), list)
      }

      @Test
      fun single() {
        val list = mutableListOf(6)
        list.mergesort()
        assertEquals(listOf(6), list)
      }

      @Test
      fun double() {
        var list = mutableListOf(2, 6)
        list.mergesort()
        assertEquals(listOf(2, 6), list)

        list = mutableListOf(6, 2)
        list.mergesort()
        assertEquals(listOf(2, 6), list)
      }

      @Test
      fun triple() {
        var list = mutableListOf(2, 6, 10)
        list.mergesort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(2, 10, 6)
        list.mergesort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(6, 2, 10)
        list.mergesort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(6, 10, 2)
        list.mergesort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(10, 2, 6)
        list.mergesort()
        assertEquals(listOf(2, 6, 10), list)

        list = mutableListOf(10, 6, 2)
        list.mergesort()
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


## Benchmark

<div id="chart_short_range"></div>

<div id="chart_long_range"></div>

<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawShortChart);
google.charts.setOnLoadCallback(drawLongChart);

function drawShortChart() {
  var data = google.visualization.arrayToDataTable([
    ['input size','n x log(n)','library sort','homemade sort'],
    [10000,2657542.5,11131500,27714100],
    [20000,5715085.0,11947800,30343000],
    [30000,8923605.0,14955200,23614900],
    [40000,1.223017E7,23077500,51246600],
    [50000,1.560964E7,15698700,39039200],
    [60000,1.904721E7,15410800,19416200],
    [70000,2.2533096E7,20270700,24591200],
    [80000,2.606034E7,19344400,37700600],
    [90000,2.9623748E7,22704500,42686400],
    [100000,3.321928E7,26611300,47857700],
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
    ['input size','n x log(n)','library sort','homemade sort'],
    [100000,3.321928E7,64299500,181845800],
    [200000,7.043856E7,79718700,155627900],
    [300000,1.0916762E8,106637400,260077400],
    [400000,1.4887712E8,148642000,251110900],
    [500000,1.8931568E8,202888700,326922500],
    [600000,2.3033523E8,236157100,587542600],
    [700000,2.7183795E8,255913600,469180800],
    [800000,3.1375424E8,281194500,486480900],
    [900000,3.560322E8,335677600,619150500],
    [1000000,3.9863136E8,385796600,649925200],
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
    list.mergesort()
    val durationHomemade = System.nanoTime() - start

    start = System.nanoTime()
    copy.sort()
    val durationLib = System.nanoTime() - start

    val expected = 20 * n * log2(n.toFloat())

    println("[$n,$expected,$durationLib,$durationHomemade],")
  }
}
```