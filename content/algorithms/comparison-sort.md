---
title: 'Comparison Sorting'
---
{{< toc >}}

I wanted to compare just how fast or slow an {{< katex >}} O(N^2) {{< /katex >}} sorting algorithm is compared to a {{< katex >}} O(N \times logN) {{< /katex >}} one. So here are the results that I found.

## Benchmark

_BubbleSort_ is ridiculously slow, so much infact that in our first graph it's hard to distinguish rest of the algorithms. _InsertionSort_ is significantly better, yet it too quite slow compared to the rest. Looking at the next graph, _QuickSort_ is a clear winner.

{{< comparison-sort-benchmark >}}

## Implementation

{{< tabs "sort-implementation" >}}
{{< tab "Interface" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.sort;

public interface Sort {

  void sort(int[] nums, int start, int endExclusive);

  default void sort(int[] nums) {
    if (nums == null || nums.length < 2) return;
    sort(nums, 0, nums.length);
  }

  default int[] sortCopy(int[] nums) {
    if (nums == null) return null;
    int[] copy = new int[nums.length];
    System.arraycopy(nums, 0, copy, 0, nums.length);
    sort(copy);
    return copy;
  }

  default void swap(int[] nums, int i, int j) {
    int t = nums[i];
    nums[i] = nums[j];
    nums[j] = t;
  }

}
{{< /highlight >}}
{{< /tab >}}

{{< tab "BubbleSort" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.sort;

public class BubbleSort implements Sort {

  @Override
  public void sort(int[] nums, int start, int endExclusive) {
    if (start < 0 || start >= endExclusive || endExclusive > nums.length)
      throw new IndexOutOfBoundsException();

    for (int i = start; i < endExclusive - 1; i++)
      for (int j = i + 1; j < endExclusive; j++) if (nums[i] > nums[j]) swap(nums, i, j);
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "InsertionSort" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.sort;

public class InsertionSort implements Sort {

  @Override
  public void sort(int[] nums, int start, int endExclusive) {
    if (start < 0 || start >= endExclusive || endExclusive > nums.length)
      throw new IndexOutOfBoundsException();

    for(int i = start+1; i < endExclusive; i++)
      insert(nums, i-1, nums[i]);
  }

  private void insert(int[] nums, int index, int value) {
    while (index >= 0 && nums[index] > value)
      nums[index+1] = nums[index--];
    nums[index+1] = value;
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "HeapSort" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.sort;

public class HeapSort implements Sort {

  @Override
  public void sort(int[] nums, int start, int endExclusive) {
    if (start < 0 || start >= endExclusive || endExclusive > nums.length)
      throw new IndexOutOfBoundsException();

    heapify(nums, start, endExclusive);
    for (int i = endExclusive - 1; i > start; i--) {
      swap(nums, start, i);
      heapifyDown(nums, start, i);
    }
  }

  private void heapify(int[] nums, int start, int endExclusive) {
    int length = endExclusive - start;
    for (int i = start + length / 2; i >= start; i--)
      heapifyDown(nums, i, endExclusive);
  }

  private void heapifyDown(int[] nums, int index, int endExclusive) {
    while (index < endExclusive) {
      int max = index;
      int left = 2 * index + 1;
      int right = 2 * index + 2;

      if (left < endExclusive && nums[left] > nums[max]) max = left;
      if (right < endExclusive && nums[right] > nums[max]) max = right;

      if (max == index) break;
      swap(nums, index, max);
      index = max;
    }
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "MergeSort" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.sort;

public class MergeSort implements Sort {

  @Override
  public void sort(int[] nums, int start, int endExclusive) {
    if (start < 0 || start >= endExclusive || endExclusive > nums.length)
      throw new IndexOutOfBoundsException();

    if (start + 1 == endExclusive) return;
    if (start + 2 == endExclusive) {
      if (nums[start] > nums[start+1]) swap(nums, start, start+1);
      return;
    }

    int length = endExclusive - start;
    int[] left = new int[length / 2];
    System.arraycopy(nums, start, left, 0, left.length);

    sort(left);
    sort(nums, start + left.length, endExclusive);

    int l = 0, r = start + left.length, c = start;
    while (l < left.length && r < endExclusive) {
      if (left[l] < nums[r]) nums[c++] = left[l++];
      else nums[c++] = nums[r++];
    }
    if (l < left.length) System.arraycopy(left, l, nums, c, left.length - l);
    // Nothing to do for right side, as it's already in place.
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "QuickSort" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.sort;

public class QuickSort implements Sort {

  private static class Range {
    int start, end;

    Range(int start, int end) {
      this.start = start;
      this.end = end;
    }
  }

  @Override
  public void sort(int[] nums, int start, int endExclusive) {
    if (start < 0 || start >= endExclusive || endExclusive > nums.length)
      throw new IndexOutOfBoundsException();

    Range r = partition3way(nums, start, endExclusive);

    if (r.start > start)
      sort(nums, start, r.start);
    if (endExclusive > r.end)
      sort(nums, r.end, endExclusive);
  }

  private Range partition3way(int[] nums, int start, int endExclusive) {
    int pivot = nums[start];
    int mid = start, end = endExclusive - 1;
    while (mid <= end) {
      if (nums[mid] == pivot)
        mid++;
      else if (nums[mid] < pivot)
        swap(nums, mid++, start++);  // Shift smaller numbers at front
      else
        swap(nums, mid, end--);      // Shift larger numbers at back
    }
    return new Range(start, mid);  // Elements same as pivot are in range [start, mid)
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "Unit test" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.sort;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SortTest {

  private Sort algo;

  @BeforeEach
  public void setup() {
    algo = new QuickSort();
  }

  @Test
  public void testEmpty() {
    assertDoesNotThrow(() -> algo.sort(null));
    assertNull(algo.sortCopy(null));
    assertArrayEquals(new int[0], algo.sortCopy(new int[] {}));
  }

  @Test
  public void testSingle() {
    assertArrayEquals(new int[] {1}, algo.sortCopy(new int[] {1}));
  }

  @Test
  public void testSorted() {
    assertArrayEquals(new int[] {1, 2, 3}, algo.sortCopy(new int[] {1, 2, 3}));
  }

  @Test
  public void testReverseSorted() {
    assertArrayEquals(new int[] {1, 2, 3}, algo.sortCopy(new int[] {3, 2, 1}));
  }

  @Test
  public void testInvalidRange() {
    assertThrows(RuntimeException.class, () -> algo.sort(new int[] {}, 0, 0));
  }

  @Test
  public void testSort() {
    int[] in = ThreadLocalRandom.current().ints(20, 0, 15).toArray();
    int[] copy = copy(in);
    Arrays.sort(copy);
    assertArrayEquals(copy, algo.sortCopy(in));
  }

  @Test
  public void testLarge() {
    int[] in = ThreadLocalRandom.current().ints(1000).toArray();
    int[] copy = copy(in);
    Arrays.sort(copy);
    assertArrayEquals(copy, algo.sortCopy(in));
  }

  private static int[] copy(int[] in) {
    int[] out = new int[in.length];
    System.arraycopy(in, 0, out, 0, in.length);
    return out;
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "Benchmark" >}}
{{< highlight Java "linenos=table" >}}
@Test
public void benchkmark() {
  System.out.print("['Size','Heap','Merge','Quick']");
  for (int size :
      List.of(
          10, 50, 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10_000, 20_000,
          30_000, 40_000, 50_000, 60_000, 70_000, 80_000, 90_000, 100_000)) {
    int[] in = ThreadLocalRandom.current().ints(size).toArray();
    System.out.printf(",\n[%d", size);

    for (Sort algo :
        new Sort[] {
          new HeapSort(), new MergeSort(), new QuickSort()
        }) {
      int[] cp = copy(in);
      long start = System.nanoTime();
      algo.sort(cp);
      long elapsed = System.nanoTime() - start;

      System.out.printf(",%d", elapsed);
    }

    System.out.print(']');
  }
}
{{< /highlight >}}
{{< /tab >}}
{{< /tabs >}}

Quick reference for time complexity:

__Bubble sort:__ {{< katex >}} O(n) {{< /katex >}} for best case. {{< katex >}} O(n^2) {{< /katex >}} for all other. Not a practical sorting algorithm.


__Insertion sort:__ {{< katex >}} O(n) {{< /katex >}} for best case. {{< katex >}} O(n^2) {{< /katex >}} for all other. Meaning it too is impractical for large input sizes. It's good for small input sizes and for partially sorted inputs.


__Heap sort:__ {{< katex >}} O(n \times log(n)) {{< /katex >}} for all cases.
  - Simple non-recursive code.
  - Does not suffer from quadratic performance like quicksort.
  - Still 2-3 times slower than well implemented quicksort.

__Merge sort:__ {{< katex >}} O(n \times log(n)) {{< /katex >}} for all cases.
  - Stable sorting algorithm.

__Quick sort:__ {{< katex >}} O(n \times log(n)) {{< /katex >}} for best and average, {{< katex >}} O(n^2) {{< /katex >}} worst.
  - Default sorting implementation in most places.