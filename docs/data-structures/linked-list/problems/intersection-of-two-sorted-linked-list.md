# Intersection of two sorted linked list

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

## Problem

Given two sorted linked list, create a new list that's an intersection of the two.

## Example

$$
\begin{alignat}{1}
first &=  1 \rightarrow 4 \rightarrow 7 \rightarrow 10 \\
second &= 2 \rightarrow 4 \rightarrow 6 \rightarrow 8 \rightarrow 10 \\
\Rightarrow intersection &= 4 \rightarrow 10
\end{alignat}
$$

## Hint

??? "Expand"

    Two cursor technique.

## Solution

??? "Expand"

    ```kotlin
    fun intersection(first: Node?, second: Node?): Node? {
      if (first == null || second == null) return null

      var f = first
      var s = second

      var head: Node? = null
      var tail: Node? = null
      while (f != null && s != null) {
        when(f.value.compareTo(s.value)) {
          -1 -> f = f.next
          1 -> s = s.next
          else -> {
            if (head == null) {
              head = Node(f.value)
              tail = head
            } else {
              tail?.next = Node(f.value)
              tail = tail?.next
            }

            f = f.next
            s = s.next
          }
        }
      }
      return head
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun simple() {
  val first = Node(1, 4, 7, 10)
  val second = Node(2, 4, 6, 8, 10)

  assertThat(intersection(first, second)?.verbose()).isEqualTo("[4, 10]")
}

@Test
fun fuzzy() {
  val rand = ThreadLocalRandom.current()
  val first = mutableListOf<Int>()
  val second = mutableListOf<Int>()

  var sizeFirst = rand.nextInt(10, 100)
  var sizeSecond = rand.nextInt(10, 100)

  while (sizeFirst-- > 0) {
    first.add(rand.nextInt(0, 100))
  }
  while (sizeSecond-- > 0) {
    second.add(rand.nextInt(0, 100))
  }
  first.sort()
  second.sort()

  val expected = mutableListOf<Int>()
  var i = 0
  var j = 0
  while (i < first.size && j < second.size) {
    when(first[i].compareTo(second[j])) {
      -1 -> i++
      1 -> j++
      else -> {
        expected.add(first[i])
        i++
        j++
      }
    }
  }

  val head = intersection(
    Node(*first.toIntArray()),
    Node(*second.toIntArray()),
  )
  assertThat(head?.verbose()).isEqualTo(expected.toString())
}
```
