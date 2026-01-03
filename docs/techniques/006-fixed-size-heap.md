# Fixed size Heap 

It's quite easy to find the smallest and largest element in a list. But what about $k^{th}$ smallest? We can use a max-heap for that.

## Explanation

1. Create a max-heap and traverse the list.
2. Simply `offer` elements to the max-heap until the size $< k$.
3. Once heap is of size $k$, process any subsequent elements like this:
    - $e >= root$, discard it.
    - otherwise ($e < root$), replace root.

## Implementation

```kotlin
fun kthSmallest(nums: IntArray, k: Int) : Int {
  if (k > nums.size) throw IndexOutOfBoundsException()

  val maxHeap = PriorityQueue<Int>(Comparator.reverseOrder())
  maxHeap.addAll(nums.slice(0 until k)) // add [0, k) elements.

  for (i in k until nums.size) {
    if (nums[i] >= maxHeap.peek()) continue
    maxHeap.poll()
    maxHeap.offer(nums[i])
  }

  return maxHeap.poll()
}
```

## Unit tests

```kotlin
assertThat(kthSmallest(intArrayOf(8, 7, 6, 5, 4, 3, 2, 1), 1)).isEqualTo(1)
assertThat(kthSmallest(intArrayOf(8, 7, 6, 5, 4, 3, 2, 1), 2)).isEqualTo(2)
assertThat(kthSmallest(intArrayOf(8, 7, 6, 5, 4, 3, 2, 1), 3)).isEqualTo(3)
assertThat(kthSmallest(intArrayOf(8, 7, 6, 5, 4, 3, 2, 1), 8)).isEqualTo(8)
```