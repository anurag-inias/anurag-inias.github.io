# Singly Linked List

<link rel="stylesheet" type="text/css" href="http://tikzjax.com/v1/fonts.css">
<script src="https://tikzjax.com/v1/tikzjax.js"></script>

## Node

In a singly linked list implementation, each node in the list encapsulates a value and maintains a reference to the next node.

```kotlin linenums="1"
data class Node(var value: Int, var next: Node? = null) {
  override fun toString(): String = "$value"
}
```

## Linked List 

We maintain references to the head and the tail of the list, allowing \\(O(1)\\) insertion on both ends.

```kotlin linenums="1"
class LinkedList {

  private var _head: Node? = null
  private var _tail: Node? = null
  private var _size = 0

  val size: Int
    get() = _size

  fun isEmpty() = size == 0

  val head: Int?
    get() = _head?.value

  val tail: Int?
    get() = _tail?.value

  // Rest of the implementation goes here. //
}
```

## Traversal

<div markdown class="grid">

we can't directly access arbitrary elements in a linked list, and instead need to start scanning from the \\(head\\).

```kotlin linenums="1"
override fun toString(): String {
  val sb = StringBuilder().append('[')
  var cursor = _head
  while (cursor != null) {
    sb.append(cursor.value)
    cursor = cursor.next
    if (cursor != null) sb.append(", ")
  }
  return sb.append(']').toString()
}
```

</div>

## Insertion

<div markdown class="grid">

```kotlin linenums="1"
fun addFirst(value: Int) {
  _size++
  _head = Node(value, _head)
  _tail = _tail ?: _head
}

fun addFirst(vararg values: Int) {
  values.forEach { addFirst(it) }
}
```

<div markdown>

prepending an element at the front of the list just requires updating the \\(head\\) reference, which makes it an \\(O(1)\\) operation.

</div>

<div markdown>

since we are keeping track of the list end, adding an element at the back too is an \\(O(1)\\) operation.

</div>

```kotlin linenums="1"
fun addLast(value: Int) {
  _size++
  val node = Node(value)

  if (_head == null) _head = node
  else _tail!!.next = node

  _tail = node
}

fun addLast(vararg values: Int) {
  values.forEach { addLast(it) }
}
```

```kotlin linenums="1"
fun add(index: Int, value: Int) {
  if (index < 0 || index > size) 
    throw IndexOutOfBoundsException(
      "Index $index out of bounds for length $size"
    )
  when(index) {
    0 -> addFirst(value)
    size -> addLast(value)
    else -> {
      _size++
      
      var pred = _head
      for (i in 0..<(index-1)) 
        pred = pred!!.next
      
      pred!!.next = Node(value, pred.next)
    }
  }
}
```

<div markdown>
adding elements anywhere in the middle of the linked list requires \\(O(n)\\) moves just to find the insertion spot.

- \\(\text{add}(0, x)\\) is equivalent to prepending an element at the front.

- \\(\text{add}(size, x)\\) is same as appending an element at the end.

- \\(\text{add}(size-1, x)\\) is inserting an element just before the \\(tail\\). \\(0 \rightarrow 1 \rightarrow \check{2} \implies 0 \rightarrow 1 \rightarrow x \rightarrow 2\\)
</div>

</div>

## Deletion

<div markdown class="grid">

<div markdown>

removing an element from the front is an \\(O(1)\\) operation, as we just need to shift the \\(head\\) one position to the right. \\[1^h \rightarrow 2 \rightarrow 3 \implies 1 \rightarrow 2^h \rightarrow 3\\]

the prev \\(head\\) node is not deleted, but is rather left for gc to cleanup.

</div>

```kotlin linenums="1"
fun removeFirst(): Int? {
  if (head == null) return null

  _size--
  if (head == tail) {         // revert to empty list
    val value = head!!.value
    head = null
    tail = null
    return value
  }
  val value = head!!.value    // shift head to right
  head = head!!.next
  return value
}
```

```kotlin linenums="1"
fun removeLast(): Int? {
  if (head == null) return null

  _size--
  if (head == tail) {         // revert to empty list
    val value = head!!.value
    head = null
    tail = null
    return value
  }

  // Find predecessor of the tail.
  var pred = head
  while (pred!!.next != tail) pred = cursor.next

  val value = tail!!.value
  pred.next = null
  tail = pred
  return value
}
```

<div markdown>
removal of an element from the back in a singly-linked list is an \\(O(n)\\) operation, since we have no easy way to access the predecessor of the tail without traversing the list first.
</div>

<div markdown>
removing an arbitrary element from anywhere in the middle of the list again requires \\(O(n)\\) time  traversal.

the deletion itself is about skipping over target node by updading the \\(next\\) reference of the predecessor node.

<script type="text/tikz">
\begin{tikzpicture}[->,>=stealth',auto,node distance=3cm,
  thick,main node/.style={circle,draw,font=\sffamily\Large\bfseries}]

  \node[main node] (1) {1};
  \node[main node] (2) [right of=1] {2};
  \node[main node] (3) [right of=2] {3};

  \path[every node/.style={font=\sffamily\small}]
    (1) edge[cross out, red] node [right] {X} (2)
    (2) edge node [right] {} (3)
    (1) edge[bend left, green] node [right] {} (3);
\end{tikzpicture}
</script>

</div>

```kotlin linenums="1"
fun remove(index: Int): Int? {
  if (index < 0 || index >= size)
    throw IndexOutOfBoundsException("Index $index out of bounds for length $size")

  return when(index) {
    0 -> removeFirst()
    size - 1 -> removeLast()
    else -> {
      _size--
      var pred = _head
      for (i in 0..<(index-1)) pred = pred!!.next

      val value = pred!!.next!!.value
      pred.next = pred.next!!.next
      return value
    }
  }
}
```

</div>

## Getter

<div markdown class="grid">

```kotlin linenums="1"
operator fun get(index: Int): Int? {
  // saves time
  if (index < 0 || index >= size) return null
  if (index == size - 1) return tail

  var cursor = _head
  for (i in 0..<index) cursor = cursor!!.next
  return cursor!!.value
}
```

<div markdown>

in _Kotlin_ we can overload the `get` operator for this purpose.

Note the half-open interval \\([0, index)\\) in the for loop. That's because we begin at \\(head\\) before the loop even begins.

</div>

</div>

## Setter

<div markdown class="grid">

<div markdown>

again we check for an exceptional case with \\(size-1\\) to avoid the \\(O(n)\\) traversal.

</div>

```kotlin linenums="1"
operator fun set(index: Int, value: Int) {
  if (index < 0 || index >= size) 
    throw IndexOutOfBoundsException("Index $index out of bounds for length $size")
  
  if (index == size - 1) {
    _tail!!.value = value
    return
  }

  var cursor = _head
  for (i in 0..<index) cursor = cursor!!.next
  cursor!!.value = value
}
```

</div>

## Unit tests

```kotlin linenums="1"
package com.example.linkedlist

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows
import java.util.concurrent.ThreadLocalRandom

class LinkedListTest {

  @Test
  fun empty() {
    val list = LinkedList()

    assertThat(list.size).isEqualTo(0)
    assertThat(list.toString()).isEqualTo("[]")
    assertThat(list[0]).isNull()
    assertThrows<IndexOutOfBoundsException> { list[0] = 0 }
    assertThat(list.head).isNull()
    assertThat(list.tail).isNull()
  }

  @Test
  fun addFirst_simple() {
    val list = LinkedList()

    list.addFirst(1, 2, 3)

    assertThat(list.size).isEqualTo(3)
    assertThat(list.toString()).isEqualTo("[3, 2, 1]")
    assertThat(list[0]).isEqualTo(3)
    assertThat(list[1]).isEqualTo(2)
    assertThat(list[2]).isEqualTo(1)
    assertThat(list.head).isEqualTo(3)
    assertThat(list.tail).isEqualTo(1)
  }

  @Test
  fun addLast_simple() {
    val list = LinkedList()

    list.addLast(1, 2, 3)

    assertThat(list.size).isEqualTo(3)
    assertThat(list.toString()).isEqualTo("[1, 2, 3]")
    assertThat(list[0]).isEqualTo(1)
    assertThat(list[1]).isEqualTo(2)
    assertThat(list[2]).isEqualTo(3)
    assertThat(list.head).isEqualTo(1)
    assertThat(list.tail).isEqualTo(3)
  }

  @Test
  fun add_mixed() {
    val list = LinkedList()

    list.addFirst(2)
    list.addLast(3)
    list.addFirst(1)
    list.addLast(4)

    assertThat(list.size).isEqualTo(4)
    assertThat(list.toString()).isEqualTo("[1, 2, 3, 4]")
    assertThat(list[0]).isEqualTo(1)
    assertThat(list[1]).isEqualTo(2)
    assertThat(list[2]).isEqualTo(3)
    assertThat(list[3]).isEqualTo(4)
    assertThat(list.head).isEqualTo(1)
    assertThat(list.tail).isEqualTo(4)
  }

  @Test
  fun add_at() {
    val list = LinkedList()

    list.add(0, 1)
    assertThat(list.toString()).isEqualTo("[1]")
    assertThat(list.head).isEqualTo(1)
    assertThat(list.tail).isEqualTo(1)

    assertThrows<IndexOutOfBoundsException> { list.add(-1, 2) }
    assertThrows<IndexOutOfBoundsException> { list.add(2, 2) }

    list.add(1, 3)
    assertThat(list.toString()).isEqualTo("[1, 3]")
    assertThat(list.head).isEqualTo(1)
    assertThat(list.tail).isEqualTo(3)

    list.add(1, 2)
    assertThat(list.toString()).isEqualTo("[1, 2, 3]")
    assertThat(list.head).isEqualTo(1)
    assertThat(list.tail).isEqualTo(3)
  }

  @Test
  fun add_at_fuzzy() {
    val list = LinkedList()
    val ctrl = ArrayList<Int>()
    val rand = ThreadLocalRandom.current()

    for (i in 0..100) {
      val value = rand.nextInt()
      val index = rand.nextInt(ctrl.size + 1)

      ctrl.add(index, value)
      list.add(index, value)
      assertThat(list.toString()).isEqualTo(ctrl.toString())
    }
  }

  @Test
  fun removeFirst_simple() {
    val list = LinkedList()

    list.addFirst(2)
    list.addLast(3)
    list.addFirst(1)
    list.addLast(4)

    assertThat(list[0]).isEqualTo(1)
    assertThat(list.removeFirst()).isEqualTo(1)
    assertThat(list.size).isEqualTo(3)

    assertThat(list[0]).isEqualTo(2)
    assertThat(list.removeFirst()).isEqualTo(2)
    assertThat(list.size).isEqualTo(2)

    assertThat(list[0]).isEqualTo(3)
    assertThat(list.removeFirst()).isEqualTo(3)
    assertThat(list.size).isEqualTo(1)

    assertThat(list[0]).isEqualTo(4)
    assertThat(list.removeFirst()).isEqualTo(4)
    assertThat(list.size).isEqualTo(0)

    assertThat(list.removeFirst()).isNull()
    assertThat(list.size).isEqualTo(0)
  }

  @Test
  fun removeLast_simple() {
    val list = LinkedList()

    list.addFirst(2)
    list.addLast(3)
    list.addFirst(1)
    list.addLast(4)

    assertThat(list[3]).isEqualTo(4)
    assertThat(list.removeLast()).isEqualTo(4)
    assertThat(list.size).isEqualTo(3)

    assertThat(list[2]).isEqualTo(3)
    assertThat(list.removeLast()).isEqualTo(3)
    assertThat(list.size).isEqualTo(2)

    assertThat(list[1]).isEqualTo(2)
    assertThat(list.removeLast()).isEqualTo(2)
    assertThat(list.size).isEqualTo(1)

    assertThat(list[0]).isEqualTo(1)
    assertThat(list.removeLast()).isEqualTo(1)
    assertThat(list.size).isEqualTo(0)

    assertThat(list.removeLast()).isNull()
    assertThat(list.size).isEqualTo(0)
  }

  @Test
  fun remove_at_ends() {
    val list = LinkedList()

    list.addLast(1, 2, 3, 4)

    assertThat(list.remove(0)).isEqualTo(1)
    assertThat(list.head).isEqualTo(2)
    assertThat(list.tail).isEqualTo(4)

    assertThat(list.remove(2)).isEqualTo(4)
    assertThat(list.head).isEqualTo(2)
    assertThat(list.tail).isEqualTo(3)
  }

  @Test
  fun remove_at_middle() {
    val list = LinkedList()

    list.addLast(1, 2, 3, 4, 5)

    assertThat(list.remove(2)).isEqualTo(3)
    assertThat(list.toString()).isEqualTo("[1, 2, 4, 5]")
    assertThat(list.head).isEqualTo(1)
    assertThat(list.tail).isEqualTo(5)

    assertThat(list.remove(2)).isEqualTo(4)
    assertThat(list.toString()).isEqualTo("[1, 2, 5]")
    assertThat(list.head).isEqualTo(1)
    assertThat(list.tail).isEqualTo(5)
  }

  @Test
  fun remove_at_fuzzy() {
    val list = LinkedList()
    val ctrl = ArrayList<Int>()
    val rand = ThreadLocalRandom.current()

    rand.ints(100, 0, 1000).forEach {
      list.addLast(it)
      ctrl.addLast(it)
    }

    while (ctrl.isNotEmpty()) {
      val index = rand.nextInt(ctrl.size)

      val removed = ctrl[index]
      ctrl.removeAt(index)
      assertThat(list.remove(index)).isEqualTo(removed)
      assertThat(list.toString()).isEqualTo(ctrl.toString())
    }
    assertThat(list.size).isEqualTo(0)
  }

  @Test
  fun get_simple() {
    val list = LinkedList()

    assertThat(list[0]).isNull()
    assertThat(list[1]).isNull()
    assertThat(list[2]).isNull()
    assertThat(list[3]).isNull()

    list.addLast(3)
    list.addFirst(2)
    list.addLast(4)
    list.addFirst(1)

    assertThat(list[0]).isEqualTo(1)
    assertThat(list[1]).isEqualTo(2)
    assertThat(list[2]).isEqualTo(3)
    assertThat(list[3]).isEqualTo(4)
  }

  @Test
  fun set_simple() {
    val list = LinkedList()

    list.addLast(3)
    list.addFirst(2)
    list.addLast(4)
    list.addFirst(1)

    list[0] = 9
    list[1] = 8
    list[2] = 7
    list[3] = 6

    assertThat(list[0]).isEqualTo(9)
    assertThat(list[1]).isEqualTo(8)
    assertThat(list[2]).isEqualTo(7)
    assertThat(list[3]).isEqualTo(6)

    assertThrows<IndexOutOfBoundsException> { list[4] = 0 }
    assertThrows<IndexOutOfBoundsException> { list[5] = 1 }
    assertThrows<IndexOutOfBoundsException> { list[6] = 2 }
  }

  @Test
  fun fuzzy() {
    val list = LinkedList()
    val ctrl = ArrayList<Int>()
    val rand = ThreadLocalRandom.current()
    // Test add
    for (i in 0..100) {
      val addLast = rand.nextBoolean()
      val toBeAdded = rand.nextInt()

      if (addLast) {
        list.addLast(toBeAdded)
        ctrl.addLast(toBeAdded)
      }
      else {
        list.addFirst(toBeAdded)
        ctrl.addFirst(toBeAdded)
      }
    }
    // Test get
    for (i in 0..100) {
      assertThat(list[i]).isEqualTo(ctrl[i])
    }
    // Test toString
    assertThat(list.toString()).isEqualTo(ctrl.toString())
    // Test remove
    while (ctrl.isNotEmpty()) {
      val removeLast = rand.nextBoolean()

      if (removeLast) {
        assertThat(list.removeLast()).isEqualTo(ctrl.removeLast())
      } else {
        assertThat(list.removeFirst()).isEqualTo(ctrl.removeFirst())
      }
    }
    // Test size
    assertThat(list.size).isEqualTo(0)
  }
}
```