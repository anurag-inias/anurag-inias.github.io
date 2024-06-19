# Heap

## Priority Queue

Before we talk about heaps, lets first talk about **Priority queue**. Priority queue is an abstract data type (ADT) that's a generalization of regular queue and stack ADT.

Each element in a \\(PQ\\) has an associated priority. Elements with high priority are served before elements with lower priority. With this, we can think of a queue and stacks as specialization of \\(PQ\\):

- Queue: priority \\(\propto \text{time in queue}\\)
- Stack: priority \\(\propto \frac{1}{\text{time in stack}}\\)

## Heap

Heap is a complete binary tree, i.e. a tree in which every level, except possibly the last, is completely filled. And all nodes in the last level are as far left as possible.

A heap then also satisfies the heap property:

1. if a **max heap**, any given node \\(n\\) is \\(\ge\\) its children. The largest value is then at the root of the tree.
2. if a **min heap**, any given node \\(n\\) is \\(\le\\) its children. The smallest value is then at the root of the tree.

## Index relation

Heaps are usually implemented in arrays such that:

1. every node has atmost \\(d = 2\\) children.
2. a node at \\(i^{th}\\) index:
     - has its left child at index \\(2i + 1\\) and right child at \\(2i + 2\\).
     - or in generalized term: \\(\in [di+1, di + d]\\). 
3. a node at \\(i^{th}\\) index:
     - has its parent at index \\(\frac{i-1}{d}\\)

## Implementation

=== "sink"

    ```ruby linenums="1"
    sink(nums, i):
      while i < nums.size:
        l = 2i + 1
        r = 2i + 2
        
        minIndex = indexOf(min(nums[i], nums[l], nums[r]))
        if minIndex == i:
          return

        swap(i, minIndex)
        i = minIndex
    ```

=== "kotlin"

    ```kotlin linenums="1"
    fun ArrayList<Int>.sink(index: Int = 0, comparator: Comparator<Int> = naturalOrder()) {
      var i = index
      while (i < size) {
        val l = 2 * i + 1
        val r = 2 * i + 2
        var max = i

        if (l < size && comparator.compare(this[l], this[max]) < 0) max = l
        if (r < size && comparator.compare(this[r], this[max]) < 0) max = r

        if (max == i) return

        swap(max, i)
        i = max
      }
    }
    ```

=== "swim"

    ```ruby linenums="1"
    swim(nums, i):
      while i > 0:
        p = (i - 1) / 2

        minIndex = indexOf(min(nums[i], nums[p]))
        if minIndex == p:
          return

        swap(i, p)
        i = p
    ```

=== "kotlin"

    ```kotlin linenums="1"
    fun ArrayList<Int>.swim(index: Int = size - 1, comparator: Comparator<Int> = naturalOrder()) {
      var i = index
      while (i > 0) {
        val p = (i - 1) / 2
        if (comparator.compare(this[p], this[i]) < 0) return

        swap(i, p)
        i = p
      }
    }
    ```

=== "heapify"

    ```ruby linenums="1"
    heapify(nums):
      for i in [size / 2, 0]:
        sink(i)
    ```

=== "kotlin"

    ```kotlin linenums="1"
    fun ArrayList<Int>.heapify(comparator: Comparator<Int> = naturalOrder()) {
      for (i in size / 2 downTo 0)
        sink(i, comparator)
    }
    ```

Both `sink` and `swim` have running time of \\(O(log_d(n))\\), since that's the height of the tree. `heapify` gets ammortized to \\(O(n)\\).

## Optimal arity

Performance-wise \\(2-way \lt 3-way \approx 4-way \gt 5-way\\). Really it depends on the ratio of insert vs deletes, but generally one would get best performance at \\(3\\) or \\(4\\).