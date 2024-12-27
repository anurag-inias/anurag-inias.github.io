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
