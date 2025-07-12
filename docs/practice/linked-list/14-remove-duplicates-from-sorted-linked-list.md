# Remove duplicates from sorted linked list

## Problem

Remove duplicate elements from a sorted linked list.

## Solution

??? "Expand"

    ```kotlin
    fun removeDuplicates() {
      var pred = this
      var cursor = this.next
      while (cursor != null) {
        if (pred.value != cursor.value) {
          pred = cursor           // Move to the next (prev, curr) pair
        } else {
          pred.next = cursor.next // Remove duplicate but don't progress `pred`
        }
        cursor = cursor.next      // Always move cursor
      }
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun simple() {
  val head = Node(1, 2, 2, 3, 3, 3, 3, 4, 5, 5, 5, 5, 5)
  assertThat(head.toString()).isEqualTo("[1, 2, 2, 3, 3, 3, 3, 4, 5, 5, 5, 5, 5]")

  head.removeDuplicates()
  assertThat(head.toString()).isEqualTo("[1, 2, 3, 4, 5]")
}

@Test
fun fuzzy() {
  val rand = ThreadLocalRandom.current()
  var ctrl = mutableListOf<Int>()
  var unique = 10
  var min = 0

  while (unique-- > 0) {
    val n = rand.nextInt(min, 100_000_000)
    var t = rand.nextInt(1, 5)

    while (t-- > 0) {
      ctrl.add(n)
    }
    min = n+1
  }
  val head = Node(*ctrl.toIntArray()) // list -> array -> spread operator
  assertThat(head.toString()).isEqualTo(ctrl.toString())

  head.removeDuplicates()
  ctrl = ctrl.stream().distinct().toList()
  assertThat(head.toString()).isEqualTo(ctrl.toString())
}
```
