# Get kth node from either end

## Problem

Given a linked list, find the $k^{\text{th}}$ node from front and back.

## Example

$$
1 \rightarrow 2 \rightarrow 3 \rightarrow 4 \rightarrow 5
$$

| $k^{\text{th}}$ | from front | from back |
| --------------- | ---------- | --------- |
| 0               | `null`     | `null`    |
| 1               | 1          | 5         |
| 2               | 2          | 4         |
| 3               | 3          | 3         |
| 4               | 4          | 2         |
| 5               | 5          | 1         |
| 6               | `null`     | `null`    |

## Hint

??? "Expand"

    ```
    Tortoise and hare
    ```

### Solution

??? "Expand"

    <div markdown class="grid">

    ```kotlin linenums="1" title="kth from front"
    fun kthNodeFromFront(head: Node?, k: Int): Node? {
      if (k < 1) return null

      var cursor = head
      for (i in 1..<k) { // loop is run k-1 times
        cursor = cursor?.next
      }
      return cursor
    }
    ```

    ```kotlin linenums="1" title="kth from back"
    fun kthNodeFromBack(head: Node?, k: Int): Node? {
      if (k < 1) return null

      var front = head
      var back = head
      for (i in 1..<k) { // loop is run k-1 times
        back = back?.next
      }
      if (back == null) return null
      while (back?.next != null) {
        front = front?.next
        back = back.next
      }
      return front
    }
    ```

    </div>

## Unit tests

```kotlin linenums="1"
@Test
fun kthNode() {
  val list = Node(1, 2, 3, 4, 5)
  assertThat(kthNodeFromFront(list, 0)?.value).isNull()
  assertThat(kthNodeFromBack(list, 0)?.value).isNull()

  assertThat(kthNodeFromFront(list, 1)?.value).isEqualTo(1)
  assertThat(kthNodeFromBack(list, 1)?.value).isEqualTo(5)

  assertThat(kthNodeFromFront(list, 2)?.value).isEqualTo(2)
  assertThat(kthNodeFromBack(list, 2)?.value).isEqualTo(4)

  assertThat(kthNodeFromFront(list, 3)?.value).isEqualTo(3)
  assertThat(kthNodeFromBack(list, 3)?.value).isEqualTo(3)

  assertThat(kthNodeFromFront(list, 4)?.value).isEqualTo(4)
  assertThat(kthNodeFromBack(list, 4)?.value).isEqualTo(2)

  assertThat(kthNodeFromFront(list, 5)?.value).isEqualTo(5)
  assertThat(kthNodeFromBack(list, 5)?.value).isEqualTo(1)

  assertThat(kthNodeFromFront(list, 6)?.value).isNull()
  assertThat(kthNodeFromBack(list, 6)?.value).isNull()
}
```
