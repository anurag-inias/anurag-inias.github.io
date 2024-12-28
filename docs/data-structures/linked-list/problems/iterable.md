# Iterable Linked List

Read more about iterators [here](/java/iterators).

=== "Singly Linked List"

    ```kotlin linenums="1"
    class LinkedList : Iterable<Int> {

      ...

      override fun iterator(): Iterator<Int> {
        return object: Iterator<Int> {

          var cursor = _head

          override fun hasNext(): Boolean = cursor != null

          override fun next(): Int {
            if (cursor == null) throw NoSuchElementException()
            val value = cursor!!.value
            cursor = cursor!!.next
            return value
          }
        }
      }
    }
    ```

=== "Doubly Linked List"

    ```kotlin linenums="1"
    class LinkedList : Iterable<Int> {

      ...

      override fun iterator(): Iterator<Int> {
        return object: Iterator<Int> {

          var cursor = sentinel.next

          override fun hasNext(): Boolean = cursor != sentinel

          override fun next(): Int {
            if (cursor == sentinel) throw NoSuchElementException()
            return cursor.value.also {
              cursor = cursor.next
            }
          }
        }
      }
    }
    ```

=== "Unit Tests"

    ```kotlin linenums="1"
    @Test
    fun iterator_empty() {
      val iter = list.iterator()

      assertThat(iter.hasNext()).isFalse()
    }

    @Test
    fun iterator_simple() {
      list.addLast(1, 2, 3)

      val iter = list.iterator()

      assertThat(iter.hasNext()).isTrue()
      assertThat(iter.next()).isEqualTo(1)
      assertThat(iter.hasNext()).isTrue()
      assertThat(iter.next()).isEqualTo(2)
      assertThat(iter.hasNext()).isTrue()
      assertThat(iter.next()).isEqualTo(3)
      assertThat(iter.hasNext()).isFalse()
      assertThrows<NoSuchElementException> { iter.next() }
    }

    @Test
    fun iterator_fuzzy() {
      val rand = ThreadLocalRandom.current()
      val ctrl = mutableListOf<Int>()

      for (i in 0..100) {
        val value = rand.nextInt()
        list.addLast(value)
        ctrl.add(value)
      }

      for ((i, v) in list.withIndex()) {
        assertThat(v).isEqualTo(ctrl[i])
      }
    }
    ```
