# Sorting a linked list

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

## Problem

Rearrange a linked list in increasing order, i.e. sort it in-place.

## Hints

??? "First Hint"

    Use insertion sort

??? "Second Hint"

    When processing a node to be inserted into sorted linked list, make sure to detach it from original linked list. For singly-linked list, this means setting `next = null`. Otherwise, you'll get stuck in infinite loop when inserting the node in next iteration.

    In case of circular linked list, make sure that the original linked list remains unbroken after detaching a node.

## Solution

??? "Sorting a singly linked list"

    ```kotlin linenums="1"
    fun sort() {
      // head of the sorted linked list. Start with an empty one.
      var nHead: Node? = null

      var candidate = _head       // Candidate to be inserted into sorted linked list.
      while (candidate != null) {
        val next = candidate.next // Backup the next node.
        candidate.next = null     // Detach insertion candidate from old linked list.

        // Find the right place to insert candidate
        var p: Node? = null       // predecessor of c.
        var c = nHead             // cursor in sorted linked.
        while (c != null && c.value <= candidate.value) {
          p = c
          c = c.next
        }
        if (p == null) {          // candidate should be the new head of the sorted list.
          candidate.next = nHead
          nHead = candidate
        } else {
          candidate.next = c      // candidate should be inserted somewhere in middle of the sorted list.
          p.next = candidate
        }

        if (next == null) {       // we've exhausted the original list. time to assign new head and new tail.
          _head = nHead
          _tail = candidate
        }
        candidate = next
      }
    }
    ```

??? "Sorting a circular doubly-linked list"

    ```kotlin linenums="1"
    fun sort() {
      val newSentinel = Node(0)                 // sentinel cannot be reused
      newSentinel.next = newSentinel

      var candidate = sentinel.next
      while (candidate != sentinel) {
        // Detach candidate from original linked list
        val prev = candidate.prev
        val next = candidate.next
        prev.next = next                       // make sure original list remains unbroken
        candidate.next = candidate

        var p = newSentinel
        var c = newSentinel.next
        while (c != newSentinel && c.value <= candidate.value) {
          p = c
          c = c.next
        }
        if (p == newSentinel) {                // new list is empty
          candidate.next = newSentinel.next
          newSentinel.next = candidate
        } else {
          candidate.next = c
          p.next = candidate
        }

        candidate = next
      }

      sentinel = newSentinel                  // switch to new sentinel
    }
    ```

### Unit tests

```kotlin linenums="1"
@Test
fun sort() {
  list.addLast(7, 1, 9, 17, 5, 81, 21, 0, 0, 0, 7, 19, 56)
  list.sort()

  assertThat(list.toString()).isEqualTo("[0, 0, 0, 1, 5, 7, 7, 9, 17, 19, 21, 56, 81]")
}

@Test
fun sortFuzzy() {
  val rand = ThreadLocalRandom.current()
  val ctrl = mutableListOf<Int>()

  for (i in 0..100) {
    val n = rand.nextInt(1000)
    list.sortedInsert(n)
    ctrl.add(n)
  }
  ctrl.sort()
  list.sort()

  assertThat(list.toString()).isEqualTo(ctrl.toString())
}
```
