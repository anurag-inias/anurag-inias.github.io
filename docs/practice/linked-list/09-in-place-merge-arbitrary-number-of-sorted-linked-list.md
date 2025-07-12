# In-place merge arbitrary number of sorted linked list

## Problem

Efficient merge arbitrary number of sorted linked list

## Hint

??? "What not to do"

    Lists can be arbitrary lengths. Tracking of all boundary conditions in a `for` loop will be cumbersome as hell.

??? "Bare minimum we care about"

    What do we actually care each time we process a node? Just that it is the _minimum_ of given $n$ candidates.

??? "What to use"

    Push _heads_ of all linked lists into a min-heap. This will act as our `for` loop for minimum value.

## Solution

??? "Expand"

    ```kotlin
    fun merge(vararg lists: Node): Node? {
      val pq = PriorityQueue(lists.size, Comparator<Node> { a, b -> a.value - b.value})
      for (head in lists) {
        pq.offer(head)
      }

      var head: Node? = null
      var tail: Node? = null
      while (pq.isNotEmpty()) {
        val n = pq.poll()
        if (head == null) {
          head = n
          tail = n
        } else {
          tail?.next = n
          tail = n
        }

        n.next?.let { pq.offer(it) }
      }

      return head
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun simple() {
  val first = Node(2, 9, 19)
  val second = Node(1, 10)
  val third = Node(2, 19, 25)

  assertThat(merge(first, second, third)?.verbose()).isEqualTo("[1, 2, 2, 9, 10, 19, 19, 25]")
}

@Test
fun fuzzy() {
  val rand = ThreadLocalRandom.current()
  var first = mutableListOf<Int>()
  var second = mutableListOf<Int>()
  var third = mutableListOf<Int>()

  var sizeFirst = rand.nextInt(10, 100)
  var sizeSecond = rand.nextInt(10, 100)
  var sizeThird = rand.nextInt(10, 100)

  while (sizeFirst-- > 0) {
    first.add(rand.nextInt(0, 100))
  }
  while (sizeSecond-- > 0) {
    second.add(rand.nextInt(0, 100))
  }
  while (sizeThird-- > 0) {
    third.add(rand.nextInt(0, 100))
  }
  first.sort()
  second.sort()
  third.sort()

  val expected = mutableListOf<Int>()
  expected.addAll(first)
  expected.addAll(second)
  expected.addAll(third)
  expected.sort()

  val head = merge(
    Node(*first.toIntArray()),
    Node(*second.toIntArray()),
    Node(*third.toIntArray()),
  )
  assertThat(head?.verbose()).isEqualTo(expected.toString())
}
```
