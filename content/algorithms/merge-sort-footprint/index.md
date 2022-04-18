---
title: "Merge-sort Memory Footprint"
date: 2022-04-17T17:24:41+05:30

resources:
  - name: merge-sort-diagram
    src: "from-wiki.png"
    title: From Wikipedia
---

{{< toc >}}

## Background

Every book on algorithms and data-structures covers merge-sort algorithms. It has an {{< katex >}} O(N\times logN) {{< /katex >}} time complexity and {{< katex >}} O(N) {{< /katex >}} space complexity. But there are two interesting properties I want to explore which I haven't seen covered: _recursion depth_ and _memory footprint_. 

So I first write my own merge-sort, and hook up some counters and gauges for tracking:
- the ticks/progress of the algorithm
- depth of call stack
- extra memory used at each step

## Implementation

{{< tabs "merge-sort-code" >}}
{{< tab "Implementation" >}}

I maintain two member fields `clock` and `space` to track the progress of algorithm and it's extra memory consumption respectively. Also note the `ProgressObserver` to report these fields, as well as recursion depth at each tick of `clock`.

{{< highlight Java "linenos=table" >}}
public class MergeSort {

  public interface ProgressObserver {
    void report(int clock, int depth, float space);
  }

  private final int[] items;
  private final ProgressObserver observer;
  private int clock;
  private int space;

  public MergeSort(int[] items) {
    this(items, null);
  }

  public MergeSort(int[] items, ProgressObserver observer) {
    this.items = items;
    this.observer = observer;
    this.clock = 0;
    this.space = 0;
  }

  public void sort() {
    pingDepth(0);
    sort(items, 1);
  }

  public void sort(int[] items, int depth) {
    clock++;
    pingDepth(depth);

    if (items == null || items.length < 2) {
      return;
    }
    if (items.length == 2) {
      if (items[0] > items[1]) swap(items,0, 1);
      return;
    }

    int[] left = new int[items.length / 2];
    int[] right = new int[items.length - left.length];
    System.arraycopy(items, 0, left, 0, left.length);
    System.arraycopy(items, left.length, right, 0, right.length);

    space += items.length;
    sort(left, depth+1);
    sort(right, depth+1);
    merge(left, right, items);
    space -= items.length;
    pingDepth(depth);
  }

  private void pingDepth(int depth) {
    if (observer != null)
      observer.report(clock, depth, (0f+space) / items.length);
  }

  private void merge(int[] left, int[] right, int[] dst) {
    int l = 0, r = 0, c = 0;
    while (l < left.length && r < right.length) {
      if (left[l] < right[r])
        dst[c++] = left[l++];
      else
        dst[c++] = right[r++];
    }
    if (l == left.length) System.arraycopy(right, r, dst, c, right.length - r);
    else if (r == right.length) System.arraycopy(left, l, dst, c, left.length - l);
  }

  private void swap(int[] items, int i, int j) {
    int t = items[i];
    items[i] = items[j];
    items[j] = t;
  }
}
{{< /highlight >}}
{{< /tab >}}
{{< tab "Unit tests" >}}
{{< highlight Java "linenos=table" >}}

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import java.util.Arrays;
import java.util.concurrent.ThreadLocalRandom;
import org.junit.jupiter.api.Test;

class MergeSortTest {

  @Test
  public void testNull() {
    assertDoesNotThrow(() -> new MergeSort(null).sort());
  }

  @Test
  public void testEmpty() {
    int[] items = new int[]{};
    new MergeSort(items).sort();
    assertArrayEquals(new int[]{}, items);
  }

  @Test
  public void testSingle() {
    int[] items = new int[]{1};
    new MergeSort(items).sort();
    assertArrayEquals(new int[]{1}, items);
  }
  @Test
  public void testSorted() {
    int[] items = new int[]{1, 2, 3};
    new MergeSort(items).sort();
    assertArrayEquals(new int[]{1, 2, 3}, items);
  }

  @Test
  public void testSortedReverse() {
    int[] items = new int[]{3, 2, 1};
    new MergeSort(items).sort();
    assertArrayEquals(new int[]{1, 2, 3}, items);
  }

  @Test
  public void testSort() {
    int[] items = new int[]{19, 5, 21, 17, -4, 0, 19, 21, 6};
    new MergeSort(items).sort();
    assertArrayEquals(new int[]{-4, 0, 5, 6, 17, 19, 19, 21, 21}, items);
  }

  @Test
  public void testFuzzy() {
    int[] items = ThreadLocalRandom.current().ints(1000, 0, 500).boxed()
        .mapToInt(i -> i).toArray();
    int[] copy = new int[items.length];
    System.arraycopy(items, 0, copy, 0, items.length);

    new MergeSort(items).sort();
    Arrays.sort(copy);

    assertArrayEquals(copy, items);
  }
}
{{< /highlight >}}
{{< /tab >}}
{{< tab "Tracking code" >}}
{{< highlight Java "linenos=table" >}}
@Test
public void trackMemory() {
  int[] items = ThreadLocalRandom.current().ints(1000, 0, 500).boxed()
      .mapToInt(i -> i).toArray();
  System.out.printf("['Clock','Space']");
  ProgressObserver observer = (c, d, s) -> {
    System.out.printf(",\n[%d,%f]", c, s);
  };
  new MergeSort(items, observer).sort();
}

@Test
public void trackDepth() {
  int[] items = ThreadLocalRandom.current().ints(1000, 0, 500).boxed()
      .mapToInt(i -> i).toArray();
  System.out.printf("['Clock','Depth']");
  ProgressObserver observer = (c, d, s) -> {
    System.out.printf(",\n[%d,%d]", c, d);
  };
  new MergeSort(items, observer).sort();
}
{{< /highlight >}}
{{< /tab >}}
{{< /tabs >}}

## Memory Footprint

{{< merge-sort-plot >}}

Let's keep the merge-sort visualization from wikipedia in mind.

{{< img name="merge-sort-diagram" size="tiny" lazy=true >}}

First note that the merge-sort begins with a successive recursive calls, each one on a smaller chunk of the subarray:
- depth 1: Copies both halves of the array, thus taking up `N` space.
- depth 2: Copies both halves of the left subarray, taking up `N/2` space.
- depth 3: `N/4` space.
- and so on.

Recall that it's the convergent geometric series {{< katex >}} 1 + \frac{1}{2} + \frac{1}{4} + ... = 2 {{< /katex >}}. Makes sense that our memory graph jump straight to {{< katex >}} 2 \times N {{< /katex >}} range. Note the large drop in memory to just {{< katex >}} N {{< /katex >}} extra space halfway through the execution. That's the left subarray sorted with no smaller subarray copies in memory yet.

Next look at the graph of recursion depth. We jump straight to  {{< katex >}} \lceil O(log_2(1000)) \rceil = 10 {{< /katex >}} depth. Once the leaf nodes (i.e. base case) of recursion tree is reached, that's when we see first drops in depth. Similar to memory graph, there's a large drop to depth `2` halfway through. That's when left subarray is sorted and right subarray is next in line. 