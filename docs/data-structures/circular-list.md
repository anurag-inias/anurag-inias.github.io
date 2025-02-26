# Circular list

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
</script>

## Overview

- Built on top of a regular array.
- Items can be added at both ends.
- Internal representation is hidden from clients. i.e. `0` is always the first element, `1` is always the second element, and so on.
- Dynamically resize to acommaccommodate new elements.

## Building blocks

### Pointers

We maintain two pointers, `head` which points to the first element of the list and `tail` which points to the index where next element is to be added (i.e. exclusive).

### Appending

To add an element to the end of the list, we place it at `tail`. We then increment `tail` to `(tail + 1) % capacity`.

### Prepending

Current front of the element is at index `head`, so a new element must be added at `head-1`. In modular arithmetic, that means `(head - 1 + capacity) % capacity`.

### Indexing or `[]`

When a client queries for index `i` through `.get(i)` or `[i]`, client shouldn't have to worry about what's going on internally. `i` has to translate to the actual index somehow.

That's rather straighforward with `(i + head) % capacity`.

```kotlin linenums="1"
operator fun get(index: Int): Int = items[(index + head) % items.size]
```

### Resizing

Before appending and prepending, we need to make sure if there's enough space in the list. {== Be careful here! You can't as-is copy content of underlying array to new space. ==}

The underlying array has to be iterated on via abstracted indices (i.e. 0, 1, 2, 3) and not the real indices (i.e. 2, 3, 0, 1).

```kotlin linenums="1"
for i in 0..<size
  new[i] = old[i]   // wrong. DON'T DO THIS
  new[i] = this[i]  // right. "this" uses the "get" operator mentioned previously.
```

## Implementation

=== "Kotlin"

    ```kotlin linenums="1"
    class CircularArray(capacity: Int = 4) {
      private var items: IntArray = IntArray(capacity)
      private var head = 0
      private var tail = 0
      private var size = 0

      fun append(item: Int) {
        maybeResize()
        items[tail] = item

        tail = tail.plusOne()
        size++
      }

      fun last(): Int? {
        if (size == 0) return null
        return items[tail.minusOne()]
      }

      fun removeTail(): Int? {
        if (size == 0) return null

        tail = tail.minusOne()
        size--
        return items[tail]
      }

      fun prepend(item: Int) {
        maybeResize()

        head = head.minusOne()
        items[head] = item
        size++
      }

      fun first(): Int? {
        if (size == 0) return null
        return items[head]
      }

      fun removeHead(): Int? {
        if (size == 0) return null

        val o = items[head]
        head = head.inc()
        size--
        return o
      }

      private fun maybeResize() {
        if (size == items.size) {
          val newItems = IntArray(size * 2)
          for (i in 0..<size)
            newItems[i] = this[i] // fake indices

          items = newItems
          head = 0
          tail = size
        }
      }

      operator fun get(index: Int): Int = items[(index + head) % items.size]

      operator fun set(index: Int, value: Int) {
        items[(index + head) % items.size] = value
      }

      private fun Int.plusOne(): Int = (this + 1) % items.size

      private fun Int.minusOne(): Int = (this - 1 + items.size) % items.size

      override fun toString(): String {
        val sb = StringBuilder()
        for (i in 0..<size) {
          sb.append(this[i])
          if (i < size - 1)
            sb.append(", ")
        }
        return sb.toString()
      }

      fun toDebugString(): String {
        val sb = StringBuilder()
        for (i in items.indices) {
          sb.append(items[i])
          if (i < items.size - 1)
            sb.append(", ")
        }
        return sb.toString()
      }
    }
    ```

=== "Test"

    ```kotlin linenums="1"
    import org.junit.jupiter.api.Assertions.assertEquals
    import org.junit.jupiter.api.Test

    class CircularArrayTest {

      private lateinit var array: CircularArray

      @org.junit.jupiter.api.BeforeEach
      fun setUp() {
        array = CircularArray(3)
      }

      @Test
      fun prependOnly() {
        assertEquals("", array.toString())

        array.prepend(1)
        assertEquals("1", array.toString())
        assertEquals("0, 0, 1", array.toDebugString())

        array.prepend(2)
        assertEquals("2, 1", array.toString())
        assertEquals("0, 2, 1", array.toDebugString())

        array.prepend(3)
        assertEquals("3, 2, 1", array.toString())
        assertEquals("3, 2, 1", array.toDebugString())

        array.prepend(4)
        assertEquals("4, 3, 2, 1", array.toString())
        assertEquals("3, 2, 1, 0, 0, 4", array.toDebugString())

        array.prepend(5)
        assertEquals("5, 4, 3, 2, 1", array.toString())
        assertEquals("3, 2, 1, 0, 5, 4", array.toDebugString())

        array.prepend(6)
        assertEquals("6, 5, 4, 3, 2, 1", array.toString())
        assertEquals("3, 2, 1, 6, 5, 4", array.toDebugString())

        array.prepend(7)
        assertEquals("7, 6, 5, 4, 3, 2, 1", array.toString())
        assertEquals("6, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 7", array.toDebugString())

        array.prepend(8)
        assertEquals("8, 7, 6, 5, 4, 3, 2, 1", array.toString())
        assertEquals("6, 5, 4, 3, 2, 1, 0, 0, 0, 0, 8, 7", array.toDebugString())

        array.prepend(9)
        assertEquals("9, 8, 7, 6, 5, 4, 3, 2, 1", array.toString())
        assertEquals("6, 5, 4, 3, 2, 1, 0, 0, 0, 9, 8, 7", array.toDebugString())

        for (i in 1..9)
          assertEquals(10-i, array[i-1])
      }

      @Test
      fun removeFirst() {
        for (i in 1..9)
          array.append(i)

        for (i in 1..9)
          assertEquals(i, array.removeHead())
      }

      @Test
      fun appendOnly() {
        assertEquals("", array.toString())
        assertEquals("0, 0, 0", array.toDebugString())


        array.append(1)
        assertEquals("1", array.toString())
        assertEquals("1, 0, 0", array.toDebugString())

        array.append(2)
        assertEquals("1, 2", array.toString())
        assertEquals("1, 2, 0", array.toDebugString())

        array.append(3)
        assertEquals("1, 2, 3", array.toString())
        assertEquals("1, 2, 3", array.toDebugString())

        array.append(4)
        assertEquals("1, 2, 3, 4", array.toString())
        assertEquals("1, 2, 3, 4, 0, 0", array.toDebugString())

        array.append(5)
        assertEquals("1, 2, 3, 4, 5", array.toString())
        assertEquals("1, 2, 3, 4, 5, 0", array.toDebugString())

        array.append(6)
        assertEquals("1, 2, 3, 4, 5, 6", array.toString())
        assertEquals("1, 2, 3, 4, 5, 6", array.toDebugString())

        array.append(7)
        assertEquals("1, 2, 3, 4, 5, 6, 7", array.toString())
        assertEquals("1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0", array.toDebugString())

        array.append(8)
        assertEquals("1, 2, 3, 4, 5, 6, 7, 8", array.toString())
        assertEquals("1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0", array.toDebugString())

        array.append(9)
        assertEquals("1, 2, 3, 4, 5, 6, 7, 8, 9", array.toString())
        assertEquals("1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0", array.toDebugString())

        for (i in 1..9)
          assertEquals(i, array[i-1])
      }

      @Test
      fun removeLast() {
        for (i in 1..9)
          array.append(i)

        for (i in 1..9)
          assertEquals(10-i, array.removeTail())
      }

      @Test
      fun mix() {
        assertEquals("", array.toString())

        array.append(5)
        assertEquals("5", array.toString())
        assertEquals("5, 0, 0", array.toDebugString())

        array.prepend(4)
        assertEquals("4, 5", array.toString())
        assertEquals("5, 0, 4", array.toDebugString())

        array.append(6)
        assertEquals("4, 5, 6", array.toString())
        assertEquals("5, 6, 4", array.toDebugString())

        array.prepend(3)
        assertEquals("3, 4, 5, 6", array.toString())
        assertEquals("4, 5, 6, 0, 0, 3", array.toDebugString())

        array.append(7)
        assertEquals("3, 4, 5, 6, 7", array.toString())
        assertEquals("4, 5, 6, 7, 0, 3", array.toDebugString())

        array.prepend(2)
        assertEquals("2, 3, 4, 5, 6, 7", array.toString())
        assertEquals("4, 5, 6, 7, 2, 3", array.toDebugString())

        array.append(8)
        assertEquals("2, 3, 4, 5, 6, 7, 8", array.toString())
        assertEquals("2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 0", array.toDebugString())

        array.prepend(1)
        assertEquals("1, 2, 3, 4, 5, 6, 7, 8", array.toString())
        assertEquals("2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 1", array.toDebugString())

        array.append(9)
        assertEquals("1, 2, 3, 4, 5, 6, 7, 8, 9", array.toString())
        assertEquals("2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0, 1", array.toDebugString())

        for (i in 1..9)
          assertEquals(i, array[i-1])
      }
    }
    ```

## Benchmark

`CircularArray` outperforms everything when it comes to `prepend` operations while giving comparable performance for `append`.

<div id="append"></div>

<div id="prepend"></div>

<script type="text/javascript">
  function appendChart() {
    var data = google.visualization.arrayToDataTable(
      [
        ['Size', 'ArrayList', 'LinkedList', 'ArrayDeque', 'CircularArray'],
        [100, 34416, 40292, 11166, 15208],
        [1000, 50209, 121792, 61541, 109542],
        [10000, 473458, 409292, 474375, 301167],
        [50000, 866125, 848875, 810833, 460792],
        [100000, 1457667, 1377666, 1568000, 617416],
        [200000, 587750, 1208791, 1106375, 1278375],
        [500000, 2533917, 1435709, 1695500, 2893083],
      ]
    );

    var options = {
      title: 'Append time',
      curveType: 'function',
    };

    const chart = new google.visualization.LineChart(document.getElementById('append'));
    chart.draw(data, options);
  };
  google.charts.setOnLoadCallback(appendChart);

  function prependChart() {
    var data = google.visualization.arrayToDataTable(
      [
        ['Size', 'ArrayList', 'LinkedList', 'ArrayDeque', 'CircularArray'],
        [100, 57875, 39208, 23083, 15542],
        [1000, 91709, 95625, 59666, 87208],
        [10000, 4212708, 368958, 495542, 308375],
        [50000, 97548167, 862542, 871000, 378791],
        [100000, 394018334, 1315250, 1470709, 469917],
        [200000, 1602793083, 1012500, 1071917, 857042],
      ]
    );

    var options = {
      title: 'Prepend time',
      curveType: 'function',
    };

    const chart = new google.visualization.LineChart(document.getElementById('prepend'));
    chart.draw(data, options);
  };
  google.charts.setOnLoadCallback(prependChart);
</script>
