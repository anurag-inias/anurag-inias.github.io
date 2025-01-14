# Split linked list in halves

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

## Problem

Given a linked list, split it in the middle.

## Hint

??? "Expand"

    Tortoise and hare

??? "Example 4 nodes"

    ```
    1   2   3   4   φ
    s,f
    ```

    ```
    1   2   3   4   φ
        s   f
    ```

    ```
    1   2   3   4   φ
            s       f
    ```

??? "Example 5 nodes"

    ```
    1   2   3   4   5   φ
    s,f
    ```

    ```
    1   2   3   4   5   φ
        s   f
    ```

    ```
    1   2   3   4   5   φ
            s       f
    ```

    ```
    1   2   3   4   5   φ
                s       f
    ```

## Solution

??? "Expand"

    We could've used a `slow` pointer and a `pred` pointer which is always a step behind `slow`. Instead we are using a deque to mimic `slow` with a `-1` offset.

    See more details [in here](/data-structures/linked-list/problems/#__tabbed_1_2).

    ```kotlin
    fun split(): Node? {
      if (next == null) return null

      val q = ArrayDeque<Node?>()
      q.add(null)
      q.add(this)
      var fast: Node? = this

      while (fast != null) {
        q.removeFirst()?.next?.let { q.add(it) }
        fast = fast.next?.next
      }

      val tail = q.removeFirst()
      val secondHalf = tail?.next
      tail?.next = null
      return secondHalf
    }
    ```

## Unit tests

For the sake of simplicity, we are operating directly on the `Node` class and not the wrapping `LinkedList`.

```kotlin
class Node(var value: Int, var next: Node? = null) {
  override fun toString(): String {
    if (next == null) return "$value"

    val values = mutableListOf<Int>()
    var cursor: Node? = this
    while (cursor != null) {
      values.add(cursor.value)
      cursor = cursor.next
    }
    return values.toString()
  }
}
```

```kotlin
@Test
fun splitEvenSize() {
  val head = Node(1, Node(2, Node(3, Node(4))))
  assertThat(head.toString()).isEqualTo("[1, 2, 3, 4]")

  val secondHalf = head.split()
  assertThat(head.toString()).isEqualTo("[1, 2]")
  assertThat(secondHalf.toString()).isEqualTo("[3, 4]")
}

@Test
fun splitOddSize() {
  val head = Node(1, Node(2, Node(3, Node(4, Node(5)))))
  assertThat(head.toString()).isEqualTo("[1, 2, 3, 4, 5]")

  val secondHalf = head.split()
  assertThat(head.toString()).isEqualTo("[1, 2, 3]")
  assertThat(secondHalf.toString()).isEqualTo("[4, 5]")
}

@Test
fun splitFuzzy() {
  val rand = ThreadLocalRandom.current()
  val ctrl = mutableListOf<Int>()
  val size = rand.nextInt(0,100)

  var head: Node? = null
  var tail: Node? = null
  for (i in 0..size) {
    val n = rand.nextInt(0, 2 * size)

    ctrl.add(n)
    if (head == null) {
      head = Node(n)
      tail = head
    } else {
      tail?.next = Node(n)
      tail = tail?.next
    }
  }

  assertThat(head.toString()).isEqualTo(ctrl.toString())

  val secondHalf = head?.split()
  assertThat(head.toString()).isEqualTo(ctrl.subList(0, size/2 + 1).toString())
  //assertThat(secondHalf.toString()).isEqualTo(ctrl.subList(size - size/2, size).toString())
}
```
