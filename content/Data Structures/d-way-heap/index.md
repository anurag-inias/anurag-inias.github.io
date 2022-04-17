---
title: "d-way Heap"
date: 2022-04-16T13:44:24+05:30

resources:
  - name: binary-heap
    src: "heap-diagram.png"
    title: Binary Heap
---

{{< toc >}}

## Introduction

First some basics. A heap is a complete binary tree, where each node satisfies the ___heap property___:
- In a _max-heap_, heap property says that {{< katex >}} parent ≥ child {{< /katex >}}.
- In a _min-heap_, heap property says that {{< katex >}} parent ≤ child {{< /katex >}}.

{{< hint info >}}
A complete tree is a binary tree where all levels, except possibly the last, are completely filled. And nodes at the last level are filled from left to a point.

A full tree or a proper tree is one where even the last level is filled.
{{< /hint >}}

Heap is how a _Priority Queue_ is typically implemented. Note that a priority queue is just specialization of a queue where each element has an associated priority, based on which elements are dequeued. 

Counterintuitively, heaps are best implemented on top of an array, and not as "collection of nodes-with-references". That's because the _complete tree_ property means that it's trivial to find the parent and children of any node. For a node at index {{< katex >}} i {{< /katex >}}:
- Its parent node is at index {{< katex >}} (i - 1) / 2 {{< /katex >}}.
- Its left child is at index {{< katex >}} 2i+1 {{< /katex >}} and right child at {{< katex >}} 2i+2 {{< /katex >}}.

{{< img name="binary-heap" size="tiny" lazy=true >}}

This extends to a _d-ary heap_ as well:
- Parent node at index {{< katex >}} (i - 1) / d {{< /katex >}}.
- Child nodes at {{< katex >}} \{ di+1, di+2, di+3, ... di+d \} {{< /katex >}}.


## Implementation
Here is an implementation of a d-ary heap in Java:

{{< tabs "d-ary-heap" >}}
{{< tab "Implementation" >}}
{{< highlight Java "linenos=table" >}}
public class MaxHeap {

  private static final int DEFAULT_CAPACITY = 32;
  private static final int DEFAULT_ARITY = 2;

  private final int arity;
  private int[] items;
  private int size;

  public MaxHeap() {
    this(DEFAULT_CAPACITY, DEFAULT_ARITY);
  }

  public MaxHeap(int[] items, int arity) {
    if (items == null || items.length < 1) throw new IllegalArgumentException("didn't know you could create an empty array");
    if (arity <= 0) throw new IllegalArgumentException("arity must be >= 1");

    this.items = items;
    this.size = items.length;
    this.arity = arity;
    heapify();
  }

  public MaxHeap(int capacity, int arity) {
    if (capacity <= 0) throw new IllegalArgumentException("capacity must be >= 1");
    if (arity <= 0) throw new IllegalArgumentException("arity must be >= 1");

    this.items = new int[capacity];
    this.size = 0;
    this.arity = arity;
  }

  public int min() {
    if (size == 0) throw new IndexOutOfBoundsException("heap is empty");
    return items[0];
  }

  public int pop() {
    int value = min();
    swap(0, --size);
    heapifyDown(0);
    return value;
  }

  public void push(int value) {
    if (size == items.length) resize();
    items[size++] = value;
    heapifyUp(size - 1);
  }

  public int size() {
    return size;
  }

  public boolean isEmpty() {
    return size == 0;
  }

  // Takes an array and turns it into a heap.
  private void heapify() {
    for (int i = size / 2; i >= 0; i--)
      heapifyDown(i);
  }

  // Enforces heap property bottom-to-top.
  private void heapifyUp(int index) {
    while (index > 0) {
      int parent = (index - 1) / arity;
      if (items[index] < items[parent]) break;
      swap(index, parent);
      index = parent;
    }
  }

  // Enforces heap property top-to-bottom.
  private void heapifyDown(int index) {
    while (index < size) {
      int max = index;
      for (int i = 0; i < arity; i++) {
        int childIndex = arity * index + i + 1;
        if (childIndex < size && items[childIndex] > items[max]) max = childIndex;
      }
      if (max == index) break;

      swap(index, max);
      index = max;
    }
  }

  private void resize() {
    int[] newItems = new int[items.length * 2];
    System.arraycopy(items, 0, newItems, 0, items.length);
    items = newItems;
  }

  private void swap(int i, int j) {
    int t = items[i];
    items[i] = items[j];
    items[j] = t;
  }

} 
{{< /highlight >}}
{{< /tab >}}

{{< tab "Unit Test" >}}
{{< highlight Java "linenos=table" >}}
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import org.junit.jupiter.api.Test;

class MaxHeapTest {

  @Test
  public void testAritySane() {
    assertThrows(IllegalArgumentException.class, () -> new MaxHeap(100, 0));
    assertDoesNotThrow(() -> new MaxHeap(100, 1));
  }

  @Test
  public void testCapacitySane() {
    assertThrows(IllegalArgumentException.class, () -> new MaxHeap(0, 10));
    assertThrows(IllegalArgumentException.class, () -> new MaxHeap(null, 10));
    assertThrows(IllegalArgumentException.class, () -> new MaxHeap(new int[0], 10));
    assertDoesNotThrow(() -> new MaxHeap(1, 10));
  }

  @Test
  public void testEmptyPop() {
    MaxHeap heap = new MaxHeap();
    assertThrows(IndexOutOfBoundsException.class, heap::pop);
  }

  @Test
  public void testSorted() {
    MaxHeap heap = new MaxHeap();
    heap.push(1);
    heap.push(2);
    heap.push(3);
    assertEquals(3, heap.pop());
    assertEquals(2, heap.pop());
    assertEquals(1, heap.pop());
    assertThrows(IndexOutOfBoundsException.class, heap::pop);
  }

  @Test
  public void testReverseSorted() {
    MaxHeap heap = new MaxHeap();
    heap.push(3);
    heap.push(2);
    heap.push(1);
    assertEquals(3, heap.pop());
    assertEquals(2, heap.pop());
    assertEquals(1, heap.pop());
    assertThrows(IndexOutOfBoundsException.class, heap::pop);
  }

  @Test
  public void testPopFuzzy() {
    List<Integer> items = ThreadLocalRandom.current().ints(1000, 0, 500).boxed().toList();
    MaxHeap heap = new MaxHeap(4, 19);
    items.forEach(heap::push);

    items.stream()
        .sorted((a, b) -> b - a)
        .forEach(
            item -> {
              assertEquals(item, heap.min());
              assertEquals(item, heap.pop());
            });
    assertThrows(IndexOutOfBoundsException.class, heap::pop);
  }

  @Test
  public void testConstructionFromArray() {
    MaxHeap heap = new MaxHeap(new int[]{1, 2, 3}, 2);
    assertEquals(3, heap.pop());
    assertEquals(2, heap.pop());
    assertEquals(1, heap.pop());
    assertThrows(IndexOutOfBoundsException.class, heap::pop);
  }
}
{{< /highlight >}}
{{< /tab >}}
{{< /tabs >}}


## Running time
- Both `heapifyUp` and `heapifyDown` have time complexity of {{< katex >}} O(log_dN) {{< /katex >}}.
- `heapify` will be called atmost {{< katex >}} N/2 {{< /katex >}} times, taking {{< katex >}} O(log_dN) {{< /katex >}} time in each iteration. However, note that sub-heaps are smaller down the tree. The actual complexity comes out to be {{< katex >}} O(N) {{< /katex >}}.

## Benchmark

Now we compare the relative time complexity of heaps with different arity. For reference I'm using _Ryzen 5900HX_ and 16 GiB of RAM. What I see here is diminishing returns after 5-arity.

{{< heap-benchmark >}}

{{< tabs "benchmark" >}}
{{< tab "Code change" >}}

I'll not measure the actual time for operations, but instead use a `counter` to track the number of primitive operations. Just updating the following two methods is enough:

{{< highlight Java "linenos=table" >}}
  private void swap(int i, int j) {
    counter++;
    // -- snip --
  }

  private void resize() {
    counter += items.length;
    // -- snip --
  }
{{< /highlight >}}
{{< /tab >}}
{{< tab "Benchmark" >}}

Here I'm running `push` method on heaps of different arity for same set of inputs. The resultant count of `operations` is exported to be shown on this page. 

{{< highlight Java "linenos=table" >}}
  public void benchmarkPush() {
    StringBuilder sb = new StringBuilder();
    sb.append("['Size'");
    for (int arity = 2; arity <= 8; arity++)
      sb.append(String.format(",'%d-way'", arity));
    sb.append(']');

    for (int size: Arrays.asList(10, 100, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 50000, 100000)) {
      sb.append(String.format(",\n[%d", size));
      List<Integer> nums = ThreadLocalRandom.current().ints(size, 0, size/2).boxed().toList();

      for (int arity = 2; arity <= 8; arity++) {
        MaxHeap heap = new MaxHeap(1, arity);
        nums.forEach(heap::push);
        sb.append(',').append(heap.getCounter());
      }
      sb.append(']');
    }
    System.out.println(sb);
  }
{{< /highlight >}}
{{< /tab >}}
{{< /tabs >}}

## Miscellaneous

Since I keep forgetting it

{{< katex display >}}
  log_ba = \frac{log_ca}{log_cb}
{{< /katex >}}