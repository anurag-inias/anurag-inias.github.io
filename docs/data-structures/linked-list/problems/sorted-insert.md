# Sorted Insert

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

## Problem

Insert a node to its correct position in a sorted linked list.

## Hint

??? "Expand"

    Basically insertion sort.

## Solution

??? "Singly linked list"

    ```kotlin
    fun sortedInsert(value: Int) {
      var cursor = _head
      var pred: Node? = null
      while (cursor != null && cursor.value <= value) {
        pred = cursor
        cursor = cursor.next
      }

      when(pred) {
        null -> addFirst(value)
        _tail -> addLast(value)
        else -> {
          pred.next = Node(value, pred.next)
          _size++
        }
      }
    }
    ```

??? "Circular doubly-linked list"

    ```kotlin
    fun sortedInsert(value: Int) {
      var cursor = sentinel.next
      while (cursor != sentinel && cursor.value <= value) {
        cursor = cursor.next
      }
      cursor = cursor.prev
      cursor.next = Node(value, cursor, cursor.next)
      _size++
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun sortedInsert() {
  val rand = ThreadLocalRandom.current()
  val ctrl = mutableListOf<Int>()

  for (i in 0..100) {
    val n = rand.nextInt(1000)
    list.sortedInsert(n)
    ctrl.add(n)
  }
  ctrl.sort()

  assertThat(list.toString()).isEqualTo(ctrl.toString())
}
```
