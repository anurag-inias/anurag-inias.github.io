# Reverse every group of k nodes

## Problem

Reverse every group of $k$ nodes in a given linked list.

$$
\begin{alignat}{1}
&{} \hspace{0.2em} 1 \rightarrow 2 \rightarrow 3 \rightarrow \hspace{0.4em} 4 \rightarrow 5 \rightarrow 6 \rightarrow \hspace{0.4em} 7 \rightarrow 8 \rightarrow 9 \rightarrow \hspace{0.4em} 10 \\
k = 3 \ \ &{} \fbox{3 $\rightarrow$ 2 $\rightarrow$ 1} \rightarrow \fbox{6 $\rightarrow$ 5 $\rightarrow$ 4} \rightarrow \fbox{9 $\rightarrow$ 8 $\rightarrow$ 7} \rightarrow \fbox{10} \\
\\
&{} \hspace{0.2em} 1 \rightarrow 2 \rightarrow 3 \rightarrow 4 \rightarrow 5 \rightarrow \hspace{0.2em} 6 \rightarrow 7 \rightarrow 8 \rightarrow 9 \rightarrow 10 \\
k = 5 \ \ &{} \fbox{5 $\rightarrow$ 4 $\rightarrow$ 3 $\rightarrow$ 2 $\rightarrow$ 1} \rightarrow \fbox{10 $\rightarrow$ 9 $\rightarrow$ 8 $\rightarrow$ 7 $\rightarrow$ 6}
\end{alignat}
$$

## Solution

??? "Expand"

    ```kotlin
    fun groupedReverse(head: Node? = null, groupSize: Int): Node? {
      if (head?.next == null) return head

      var cursor = head
      for (i in 0..<groupSize - 1) {
        cursor = cursor?.next
      }
      val nextGroup = cursor?.next
      cursor?.next = null

      val newHead = reverse(head = head)
      head.next = groupedReverse(nextGroup, groupSize) // this is actually now "tail" since this group has been reversed
      return newHead
    }

    private fun reverse(predecessor: Node? = null, head: Node? = null): Node? {
      if (head?.next == null) return head

      var prev = predecessor
      var curr = head
      while (curr != null) {
        val next = curr.next

        curr.next = prev

        prev = curr
        curr = next
      }
      return prev
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun reverse1() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 1)

  assertThat(list?.verbose()).isEqualTo("[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]")
}

@Test
fun reverse2() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 2)

  assertThat(list?.verbose()).isEqualTo("[2, 1, 4, 3, 6, 5, 8, 7, 10, 9]")
}

@Test
fun reverse3() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 3)

  assertThat(list?.verbose()).isEqualTo("[3, 2, 1, 6, 5, 4, 9, 8, 7, 10]")
}

@Test
fun reverse4() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 4)

  assertThat(list?.verbose()).isEqualTo("[4, 3, 2, 1, 8, 7, 6, 5, 10, 9]")
}

@Test
fun reverse5() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 5)

  assertThat(list?.verbose()).isEqualTo("[5, 4, 3, 2, 1, 10, 9, 8, 7, 6]")
}

@Test
fun reverse6() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 6)

  assertThat(list?.verbose()).isEqualTo("[6, 5, 4, 3, 2, 1, 10, 9, 8, 7]")
}

@Test
fun reverse7() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 7)

  assertThat(list?.verbose()).isEqualTo("[7, 6, 5, 4, 3, 2, 1, 10, 9, 8]")
}

@Test
fun reverse8() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 8)

  assertThat(list?.verbose()).isEqualTo("[8, 7, 6, 5, 4, 3, 2, 1, 10, 9]")
}

@Test
fun reverse9() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 9)

  assertThat(list?.verbose()).isEqualTo("[9, 8, 7, 6, 5, 4, 3, 2, 1, 10]")
}

@Test
fun reverse10() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 10)

  assertThat(list?.verbose()).isEqualTo("[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]")
}

@Test
fun reverse11() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 11)

  assertThat(list?.verbose()).isEqualTo("[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]")
}

@Test
fun reverse12() {
  var list: Node? = Node(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  list = groupedReverse(list, 12)

  assertThat(list?.verbose()).isEqualTo("[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]")
}
```
