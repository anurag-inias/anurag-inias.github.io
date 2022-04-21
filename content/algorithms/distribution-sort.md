---
title: 'Distribution Sorting'
---
{{< toc >}}

## Counting Sort

The idea behind _Counting Sort_ is simple -- count all distinct elements in the array, and then go over the counts to refill the array. It gives {{< katex >}} O(n+k) {{< /katex >}} worst case complexity.

{{< tabs "counting-sort-implementation" >}}

{{< tab "With array" >}}

We iterate over the array once to find the range of elements `[min, max]`. Then create an array with size of this range, to keep count of all elements. This will of course:
1. waste a ton of space.
2. fail when there's large difference between any two numbers.

{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.sort;

import java.util.Arrays;

public class CountingSort implements Sort {

  private static class Range {
    int min, max;

    Range(int min, int max) {
      this.min = min;
      this.max = max;
    }
  }

  @Override
  public void sort(int[] nums, int start, int endExclusive) {
    if (start < 0 || start >= endExclusive || endExclusive > nums.length)
      throw new IndexOutOfBoundsException();

    Range r = findElementsRange(nums, start, endExclusive);
    int[] counts = new int[r.max - r.min + 1]; // This will fail for too large a variation in array.
    countElements(nums, start, endExclusive, counts, r.min);

    int cursor = 0;
    for(int element = 0; element < counts.length; element++) {
      int count = counts[element];

      Arrays.fill(nums, cursor, cursor + count, element + r.min);
      cursor += count;
    }
  }

  private void countElements(int[] nums, int start, int endExclusive, int[] counts, int offset) {
    for (int i = start; i < endExclusive; i++)
      counts[nums[i]-offset]++;
  }

  private Range findElementsRange(int[] nums, int start, int endExclusive) {
    int min = nums[start];
    int max = nums[start];
    for (int i = start + 1; i < endExclusive; i++) {
      min = Math.min(min, nums[i]);
      max = Math.max(max, nums[i]);
    }
    return new Range(min, max);
  }

}
{{< /highlight >}}
{{< /tab >}}

{{< tab "With HashMap" >}}
An alternative is to use a `TreeMap` to track the counts. This will let us iterate over the entries during the `fill` phase in sorted order, and won't waste space for values that do not exist.

{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.sort;

import java.util.Arrays;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

public class TreeMapCountingSort implements Sort {
  
  @Override
  public void sort(int[] nums, int start, int endExclusive) {
    if (start < 0 || start >= endExclusive || endExclusive > nums.length)
      throw new IndexOutOfBoundsException();

    Map<Integer, Integer> counts = countElements(nums, start, endExclusive);
    int cursor = 0;
    for (Entry<Integer, Integer> e: counts.entrySet()) {
      Arrays.fill(nums, cursor, cursor + e.getValue(), e.getKey());
      cursor += e.getValue();
    }
  }

  private Map<Integer, Integer> countElements(int[] nums, int start, int endExclusive) {
    Map<Integer, Integer> map = new TreeMap<>();
    for (int i = start; i < endExclusive; i++)
      map.put(nums[i], map.getOrDefault(nums[i], 0) + 1);
    return map;
  }

}
{{< /highlight >}}
{{< /tab >}}

{{< tab "Benchmark" >}}
{{< highlight Java "linenos=table" >}}
@Test
public void benchkmark() {
  System.out.print("['Size','CountSort', 'TreeMapCountingSort', 'QuickSort']");
  for (int size :
      List.of(
          10, 50, 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10_000, 20_000,
          30_000, 40_000, 50_000, 60_000, 70_000, 80_000, 90_000, 100_000)) {
    int[] in = ThreadLocalRandom.current().ints(size, 0, size).toArray();  // So CountingSort won't crash with out-of-memory errors.
    System.out.printf(",\n[%d", size);

    for (Sort algo :
        new Sort[] {new CountingSort(), new TreeMapCountingSort(), new QuickSort()}) {
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

{{< countsortchart.inline >}}
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawCountingSortVsQuickSortChart);

  function drawCountingSortVsQuickSortChart() {
    var data = google.visualization.arrayToDataTable([
      ['Size','Counting Sort', 'TreeMap Counting Sort', 'Quick Sort'],
      [10,897900,236500,872400],
      [50,23600,353200,42400],
      [100,41900,424300,128500],
      [500,220500,2207500,735100],
      [1000,237900,1611400,212700],
      [2000,550700,2180300,648800],
      [3000,820300,3347500,717100],
      [4000,1187300,4403400,506300],
      [5000,1311500,9845600,4698900],
      [6000,1472700,10108200,820400],
      [7000,1604300,9315800,872700],
      [8000,2419300,12239800,1183800],
      [9000,1868600,10054000,1028600],
      [10000,2560600,10666200,1171600],
      [20000,2843100,21707200,2462400],
      [30000,1809800,24371800,3796000],
      [40000,3298000,27776300,5252900],
      [50000,1413400,35085600,6668100],
      [60000,1068600,42108600,8736800],
      [70000,1399400,49720500,10252100],
      [80000,1428200,62377000,11032200],
      [90000,1765600,63619100,12560300],
      [100000,1880000,71504900,14513400]
    ]);
    data.addColumn({type: 'string', role: 'tooltip'});
    var options = {
        title: 'Counting Sort vs Quick Sort',
        curveType: 'function',
        height: 500,
        legend: { position: 'right' },
        vAxis: { title: 'Nanoseconds' },
        hAxis: { title: 'Input Size' }
      };
    var chart = new google.visualization.LineChart(document.getElementById('counting_sort_vs_quick_sort'));
    chart.draw(data, options);
  }
</script>

<div id="counting_sort_vs_quick_sort"></div>
{{< /countsortchart.inline >}}

_Note_: I had to limit the range of elements here. Otherwise both versions of counting sort would fail with memory shortage.

## Bucket Sort

It's a generalization of counting sort. Turn each bucket to size `1` and we'll get the counting sort. It works as follows:
- Create `k` buckets.
- Scatter: Iterate over input and scatter them over buckets.
- Sort all non-empty bucket.
- Gather: Iterate over buckets and put elements back in input array.

{{< tabs "sort-implementation" >}}

{{< tab "Bucket" >}}
{{< highlight Java "linenos=table" >}}
class Bucket {
  private static final int DEFAULT_BUCKETS_SIZE = 32;

  private int[] items;
  private int size;

  public Bucket() {
    this.items = new int[DEFAULT_BUCKETS_SIZE];
    this.size = 0;
  }

  public void add(int value) {
    if (size == items.length) resize();
    items[size++] = value;
  }

  public int[] raw() {
    return items;
  }

  public void sort() {
    Arrays.sort(items, 0 , size);
  }

  public int size() {
    return size;
  }

  private void resize() {
    int[] newItems = new int[items.length * 2];
    System.arraycopy(items, 0, newItems, 0, items.length);
    items = newItems;
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "BucketSort" >}}
{{< highlight Java "linenos=table" >}}
public class BucketSort implements Sort {

  private static final int DEFAULT_BUCKETS_COUNT = 32;
  private int numsBucket;

  public BucketSort() {
    this(DEFAULT_BUCKETS_COUNT);
  }

  public BucketSort(int numsBucket) {
    this.numsBucket = numsBucket;
  }

  @Override
  public void sort(int[] nums, int start, int endExclusive) {
    if (start < 0 || start >= endExclusive || endExclusive > nums.length)
      throw new IndexOutOfBoundsException();

    Bucket[] buckets = new Bucket[numsBucket];
    fillBuckets(nums, start, endExclusive, buckets);

    int cursor = start;
    for (Bucket bucket: buckets) {
      if (bucket == null) continue;
      bucket.sort();
      System.arraycopy(bucket.raw(), 0, nums, cursor, bucket.size());
      cursor += bucket.size();
    }
  }

  private void fillBuckets(int[] nums, int start, int endExclusive, Bucket[] buckets) {
    int length = endExclusive - start;
    int[] r = findRange(nums, start, endExclusive);

    for(int i = start; i < endExclusive; i++) {
      int idx = findIndex(nums[i], r[0], r[1]);

      if (buckets[idx] == null) buckets[idx] = new Bucket();
      buckets[idx].add(nums[i]);
    }
  }

  private int[] findRange(int[] nums, int start, int endExclusive) {
    int min = nums[start];
    int max = nums[start];
    for (int i = start + 1; i < endExclusive; i++) {
      min = Math.min(min, nums[i]);
      max = Math.max(max, nums[i]);
    }
    return new int[]{min, max};
  }

  private int findIndex(int num, int min, int max) {
    // num / max turn the number into a fraction.
    // numsBucket * (num / max) tells us which bucket to insert this number in.
    // -min is need to handle the case when there are negative numbers in the array.

    // It also creates risk of overflow when numbers in the array have large absolute values.
    return (numsBucket * (num - min)) / (max - min + 1);
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< /tabs >}}

{{< countsortchart.inline >}}
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawBucketSortVsQuickSortChart);

  function drawBucketSortVsQuickSortChart() {
    var data = google.visualization.arrayToDataTable([
    ['Size','Counting Sort', 'Bucket Sort', 'Quic kSort'],
    [10,344400,566500,330600],
    [50,10300,21000,14500],
    [100,17900,40300,56900],
    [500,98500,158100,218700],
    [1000,118400,314600,115000],
    [2000,233400,684900,200000],
    [3000,409100,1307400,407200],
    [4000,413600,585700,221900],
    [5000,471000,782800,289000],
    [6000,558200,1039100,516300],
    [7000,757900,1205500,384300],
    [8000,906300,1304700,528200],
    [9000,1000400,1149300,435800],
    [10000,960100,1608500,499400],
    [20000,1312800,2425000,1801400],
    [30000,865200,1805000,1648600],
    [40000,690300,2824400,2235100],
    [50000,3497300,3534400,2728000],
    [60000,439300,3047600,3518300],
    [70000,562100,3370600,4018800],
    [80000,581200,3946000,4600600],
    [90000,656600,4334100,5266000],
    [100000,732200,5111400,5885000]
    ]);
    data.addColumn({type: 'string', role: 'tooltip'});
    var options = {
        title: 'Bucket Sort vs Quick Sort',
        curveType: 'function',
        height: 500,
        legend: { position: 'right' },
        vAxis: { title: 'Nanoseconds' },
        hAxis: { title: 'Input Size' }
      };
    var chart = new google.visualization.LineChart(document.getElementById('bucket_sort_vs_quick_sort'));
    chart.draw(data, options);
  }
</script>

<div id="bucket_sort_vs_quick_sort"></div>
{{< /countsortchart.inline >}}

### Analysis:
- Worst case: all elements in same bucket. Complexity would be same as algo that sorts each bucket, {{< katex >}} O(n^2) {{< /katex >}}. 
- Avg case: {{< katex >}} O(n + \frac{n^2}{k} + k) {{< /katex >}}
