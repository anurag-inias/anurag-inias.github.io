# Linked List

## About

Linked list is a linear data structure in which objects are ordered through a _reference_ in each object. 

## Singly linked list

=== "Node"

    Not much going on here.

    ```kotlin
    class Node(val value: Int, var next: Node? = null) {

      val hasNext: Boolean
        get() = next != null

      override fun toString(): String {
        return "$value"
      }
    }
    ```

=== "Linked list"

    Maintain a reference to the first and the last element of the linked list.

    ```kotlin
    class LinkedList {
      private var head: Node? = null
      private var tail: Node? = null
      private var _size: Int = 0

      val size: Int
        get() = _size

      val empty: Boolean
        get() = _size == 0
    ```

    Adding and removing elements on both ends is straighforward \\(O(1)\\) operation.

    ```kotlin
    fun addBack(value: Int) {
      val n = Node(value)

      head = head ?: n   // handle adding the first element
      tail?.next = n     
      tail = n           // new element is always the last one

      _size++
    }

    fun addFront(value: Int) {
      head = Node(value, head)  // new element is always at head
      tail = tail ?: head       // handle adding the first element

      _size++
    }
    ```

    Removing elements is not that straightforward. In a singly linked list, removing element at the front is \\(O(1)\\) operation, but for removing the tail requires iterating the whole list, and thus \\(O(n)\\).

    ```kotlin
    fun removeBack(): Int? {
      if (tail == null) return null     // nothing to return

      val last = tail!!.value
      _size--

      if (head == tail) {
        head = null; tail = null        // handle single element
      } else {
        tail = head
        while (tail?.next?.hasNext == true) {
          tail = tail?.next
        }
        tail?.next = null               // shift tail back
      }
      return last
    }

    fun removeFront(): Int? {
      if (head == null) return null     // nothing to return     

      val first = head!!.value
      _size--

      if (head == tail) {
        head = null; tail = null        // handle single element
      } else {
        head = head?.next               // shift head
      }
      return first
    }
    ```

=== "Unit tests"

    ```kotlin
    import org.assertj.core.api.Assertions.assertThat
    import org.junit.jupiter.api.BeforeEach
    import org.junit.jupiter.api.Test
    import java.util.ArrayDeque
    import java.util.concurrent.ThreadLocalRandom
    import java.util.stream.Collectors

    class LinkedListTest {

      private lateinit var list: LinkedList

      @BeforeEach
      fun setup() {
        list = LinkedList()
      }

      @Test
      fun addBack() {
        assertThat(list.toString()).isEqualTo("[]")

        list.addBack(1)
        assertThat(list.toString()).isEqualTo("[1]")

        list.addBack(2)
        assertThat(list.toString()).isEqualTo("[1, 2]")

        list.addBack(3)
        assertThat(list.toString()).isEqualTo("[1, 2, 3]")
      }

      @Test
      fun addFront() {
        assertThat(list.toString()).isEqualTo("[]")

        list.addFront(1)
        assertThat(list.toString()).isEqualTo("[1]")

        list.addFront(2)
        assertThat(list.toString()).isEqualTo("[2, 1]")

        list.addFront(3)
        assertThat(list.toString()).isEqualTo("[3, 2, 1]")
      }

      @Test
      fun addMix() {
        assertThat(list.toString()).isEqualTo("[]")

        list.addBack(1)
        assertThat(list.toString()).isEqualTo("[1]")

        list.addFront(0)
        assertThat(list.toString()).isEqualTo("[0, 1]")

        list.addBack(2)
        assertThat(list.toString()).isEqualTo("[0, 1, 2]")

        list.addFront(-1)
        assertThat(list.toString()).isEqualTo("[-1, 0, 1, 2]")
      }

      @Test
      fun removeFront() {
        list.addBack(3)
        list.addFront(2)
        list.addBack(4)
        list.addFront(1)
        list.addBack(5)
        assertThat(list.toString()).isEqualTo("[1, 2, 3, 4, 5]")

        assertThat(list.removeFront()).isEqualTo(1)
        assertThat(list.toString()).isEqualTo("[2, 3, 4, 5]")

        assertThat(list.removeFront()).isEqualTo(2)
        assertThat(list.toString()).isEqualTo("[3, 4, 5]")

        assertThat(list.removeFront()).isEqualTo(3)
        assertThat(list.toString()).isEqualTo("[4, 5]")

        assertThat(list.removeFront()).isEqualTo(4)
        assertThat(list.toString()).isEqualTo("[5]")

        assertThat(list.removeFront()).isEqualTo(5)
        assertThat(list.toString()).isEqualTo("[]")
      }

      @Test
      fun removeBack() {
        list.addBack(3)
        list.addFront(2)
        list.addBack(4)
        list.addFront(1)
        list.addBack(5)
        assertThat(list.toString()).isEqualTo("[1, 2, 3, 4, 5]")

        assertThat(list.removeBack()).isEqualTo(5)
        assertThat(list.toString()).isEqualTo("[1, 2, 3, 4]")

        assertThat(list.removeBack()).isEqualTo(4)
        assertThat(list.toString()).isEqualTo("[1, 2, 3]")

        assertThat(list.removeBack()).isEqualTo(3)
        assertThat(list.toString()).isEqualTo("[1, 2]")

        assertThat(list.removeBack()).isEqualTo(2)
        assertThat(list.toString()).isEqualTo("[1]")

        assertThat(list.removeBack()).isEqualTo(1)
        assertThat(list.toString()).isEqualTo("[]")
      }

      @Test
      fun random() {
        val items = ThreadLocalRandom.current().ints(100, 0, 999).boxed().collect(Collectors.toCollection { ArrayDeque() })
        items.forEach { list.addBack(it) }

        while (!list.empty) {
          assertThat(list.toString()).isEqualTo(items.toString())
          assertThat(list.removeFront()).isEqualTo(items.removeFirst())
          assertThat(list.removeBack()).isEqualTo(items.removeLast())
        }
      }
    ```

## Doubly linked list

=== "Node"

    We are using a setter trickery here to cut down our pointers bookkeeping. This helps with mutual linking b/w two nodes.

    ```kotlin
    class Node(val value: Int, var _prev: Node? = null, var _next: Node? = null) {

      val hasNext: Boolean
        get() = next != null

      var prev: Node?
        get() = _prev
        set(value) {
          _prev = value
          value?._next = this  // careful to not use "next" here, else we get stuck in stack overflow
        }

      var next: Node?
        get() = _next
        set(value) {
          _next = value
          value?._prev = this  // same here
        }

      override fun toString(): String {
        return "$value"
      }
    }
    ```

=== "Linked list"

    Straightforward here, nothing new.

    ```kotlin
    class LinkedList {

      private var head: Node? = null
      private var tail: Node? = null
      private var _size: Int = 0

      val size: Int
        get() = _size

      val empty: Boolean
        get() = _size == 0
    ```

    Adding elements at either end is a bit easy if we are mindful about triggering our setters.

    ```kotlin
    fun addBack(value: Int) {
      val n = Node(value)

      head = head ?: n
      tail?.next = n    // also sets the prev of new tail
      tail = n

      _size++
    }

    fun addFront(value: Int) {
      val n = Node(value)

      n.next = head     // also sets the prev of old head
      head = n
      tail = tail ?: n

      _size++
    }
    ```

    Removing elements at each end is now \\(O(1)\\).

    ```kotlin
    fun removeBack(): Int? {
      if (tail == null) return null

      val last = tail!!.value
      _size--

      if (head == tail) {
        head = null; tail = null
      } else {
        tail = tail?.prev  // shift back tail
        tail?.next = null  // avoid memory leak
      }

      return last
    }

    fun removeFront(): Int? {
      if (head == null) return null

      val front = head!!.value
      _size--

      if (head == tail) {
        head = null; tail = null
      } else {
        head = head?.next  // shift head
        head?.prev = null  // avoid memory leak
      }

      return front
    }
    ```

=== "Unit tests"

    Same as singly linked list.