# Heap

<style>
  input {
    padding: 0.5rem;
    border: 1px solid var(--md-typeset-color);
    border-radius: 2px;
    font-size: 0.8rem;
  }
  button {
    background-color: #eee;
    border-radius: 2px;
    box-shadow: 2px 2px #ddd;
    padding: 0.5rem;
  }
  button:active {
    box-shadow: none;
  }
  .stages {
    display: flex !important;
    overflow: auto;
    margin-top: 0.4rem;
  }
  .stage {
    font-size: 0.6rem;
    background-color: #eee;
    border-radius: 2px;
    box-shadow: 2px 2px #ddd;
    margin: 0 0.4rem 0.4rem 0 !important;
    padding: 0.5rem;
  }
  .stage > .index {
    display: block;
    margin: 0.2rem auto 0 !important;
    text-align: center;
    font-style: italic;
    color: orange;
  }
</style>

A _heap_ is a complete binary tree [^1] where the following holds true for all nodes:

1. $parent \le child$ if it's a _min heap_.
2. $parent \ge child$ if it's a _max heap_.

Heap is an implementation of Priority Queue [^2]. What sets _heap_ apart from other Binary Tree implementations, is that it's best implemented as an array.

Given a node at index $i$, we can find its parent and children nodes for arity $D$ as following:

1. parent at index $\frac{i-1}{D}$.
2. children at indices $[Di + 1, \ Di + 2, ..., \ Di + D]$.

## Implementation

=== "Heapify"

    Takes an array <input type="text" id="heapify-input" value="15 14 13 12 11"/> of length $N$ and calls `sink` on indices $\Big[\lfloor \frac{N-1}{2} \rfloor, ..., 0\Big]$ in order. Has the amortized time complexity of $O(n)$.

    <div id="heapify-stages" class="stages">
    </div>

    ```javascript
    function heapify() {
      const times = Math.floor((items.length - 1) / 2);
      for (let i = times; i >= 0; i--) {
        sink(i);
      }
    }
    ```

=== "Push"

    Takes the heap <input type="text" id="swim-input" value="11 12 13 15 14"/> and pushes the element <input type="number" id="append-input" value="8"/> at the end of it. This is followed by `swim` operation on newly added element to bubble it up to its right place. Has the time complexity of $O(log \ n)$.

    <div id="swim-stages" class="stages">
    </div>

    ```javascript
    function push(item) {
      items.push(item);
      swim(items.length - 1);
    }

    function swim(index) {
      while(index > 0) {
        let parent = Math.floor((index - 1) / 2);
        if (items[index] >= items[parent]) return;

        [items[parent], items[index]] = [items[index], items[parent]];
        index = parent;
      }
    }
    ```

=== "Pop"

    Takes the heap <input type="text" id="sink-input" value="11 12 13 15 14"/> and <button id="pop-input">pops</button> its root. The root gets replaced with the last element of the heap, followed by `sink` operation on the new root to restore the min-heap property. Has the time complexity of $O(log \ n)$.

    <div id="sink-stages" class="stages">
    </div>

    ```javascript
    function pop() {
      let last = items.length-1;
      [items[0], item[last]] = [items[last], items[0]]; // swap the root with last element
      let top = items.pop();                            // pop the last element (old root)
      sink(0);
      return top;
    }

    function sink(index) {
      while(index < items.length) {
        let left = 2 * index + 1;
        let right = 2 * index + 2;
        let min = index;

        if (left < items.length && items[left] < items[index]) 
          min = left;
        if (right < items.length && items[right] < items[min]) // pay attention
          min = right;

        if(min === index) 
          return;

        [items[min], items[index]] = [items[index], items[min]];
        index = min;
      }
    }
    ```

## n-ary Heap

=== "Boilerplate"

    Notice that we don't use `Heap<T extends Comparable>`. That'd be too strict of a condition.

    ```java
    import java.util.ArrayList;
    import java.util.Collection;
    import java.util.Collections;
    import java.util.Comparator;
    import java.util.Optional;
    import java.util.stream.IntStream;

    public class Heap<T> {
      private static final int DEFAULT_ARITY = 2;

      private final int arity;                  // lets us control arity.
      private final Comparator<T> comparator;   // allows switching between min and max heap variants.
      private ArrayList<T> items;
      private int size;

      public Heap(Comparator<T> comparator) {
        this(DEFAULT_ARITY, comparator);
      }
      public Heap(int arity, Comparator<T> comparator) {
        if (arity < 1)
          throw new IllegalArgumentException("Arity must be > 0");
        this.arity = arity;
        this.comparator = comparator;

        this.items = new ArrayList<>();
        this.size = 0;
      }

      public Heap(int arity, Comparator<T> comparator, Collection<T> source) {
        this(arity, comparator);

        this.items = new ArrayList<>(source);
        this.size = source.size();
        heapify();
      }
    }
    ```

=== "Heapify"

    ```java
    private void heapify() {
      for (int i = (size - 1) / arity; i >= 0; i--)
        sink(i);
    }
    ```

=== "Push"

    ```java
    public void offer(T value) {
      items.add(value);
      size++;
      swim(size - 1);
    }

    private void swim(int index) {
      while (index > 0) {
        int parent = (index - 1) / arity;

        // parent <= node
        if (comparator.compare(items.get(parent), items.get(index)) <= 0)
          return;

        Collections.swap(items, index, parent);
        index = parent;
      }
    }
    ```

=== "Pop"

    ```java
    public Optional<T> peek() {
      if (size == 0) return Optional.empty();
      return Optional.of(items.get(0));
    }

    public Optional<T> poll() {
      if (size == 0) return Optional.empty();

      T value = items.get(0);
      Collections.swap(items, 0, --size);
      sink(0);
      return Optional.of(value);
    }

    private void sink(int index) {
      while (index < size) {
        int minIndex = IntStream.rangeClosed(arity * index + 1, arity * index + arity)
            .filter(i -> i < size)
            .reduce((i, j) -> {
              int comparison = comparator.compare(items.get(i), items.get(j));
              return comparison < 0 ? i : j;
            }).orElse(index);

        if (minIndex == index || comparator.compare(items.get(index), items.get(minIndex)) < 0)
          return;

        Collections.swap(items, index, minIndex);
        index = minIndex;
      }
    }
    ```

=== "Unit tests"

    ```java
    import static org.assertj.core.api.Assertions.assertThat;
    import static org.junit.jupiter.api.Assertions.*;

    import java.util.ArrayList;
    import java.util.Arrays;
    import java.util.Collections;
    import java.util.Comparator;
    import java.util.List;
    import java.util.concurrent.ThreadLocalRandom;
    import java.util.stream.Collectors;
    import org.junit.jupiter.api.BeforeEach;
    import org.junit.jupiter.api.Test;

    class HeapTest {

      @Test
      public void testEmpty() {
        Heap<Integer> minHeap = new Heap<>(Integer::compare);
        assertThat(minHeap.peek()).isEmpty();
        assertThat(minHeap.poll()).isEmpty();

        minHeap.offer(9);
        assertThat(minHeap.peek()).contains(9);
        assertThat(minHeap.poll()).contains(9);
        assertThat(minHeap.poll()).isEmpty();
      }

      @Test
      public void testMinHeap() {
        Heap<Integer> minHeap = new Heap<>(Integer::compare);

        for (int i = 10; i >= 1; i--)
          minHeap.offer(i);

        for (int i = 1; i <= 10; i++)
          assertThat(minHeap.poll()).contains(i);
        assertThat(minHeap.poll()).isEmpty();
      }

      @Test
      public void testMinOctaHeap() {
        Heap<Integer> minHeap = new Heap<>(8, Integer::compare);

        for (int i = 10; i >= 1; i--)
          minHeap.offer(i);

        for (int i = 1; i <= 10; i++)
          assertThat(minHeap.poll()).contains(i);
        assertThat(minHeap.poll()).isEmpty();
      }

      @Test
      public void testMaxHeap() {
        Heap<Integer> maxHeap = new Heap<>((i, j) -> j - i);

        for (int i = 1; i <= 10; i++)
          maxHeap.offer(i);

        for (int i = 10; i >= 1; i--)
          assertThat(maxHeap.poll()).contains(i);
        assertThat(maxHeap.poll()).isEmpty();
      }

      @Test
      public void testMaxOctaHeap() {
        Heap<Integer> maxHeap = new Heap<>(8, (i, j) -> j - i);

        for (int i = 1; i <= 10; i++)
          maxHeap.offer(i);

        for (int i = 10; i >= 1; i--)
          assertThat(maxHeap.poll()).contains(i);
        assertThat(maxHeap.poll()).isEmpty();
      }

      @Test
      public void testFuzzy() {
        int arity = ThreadLocalRandom.current().nextInt(2, 10);
        int[] feed = ThreadLocalRandom.current().ints(1000, 0, 800).toArray();

        Heap<Integer> minHeap = new Heap<>(arity, Integer::compare);
        for (int n: feed)
          minHeap.offer(n);

        Arrays.sort(feed);

        for (int n: feed)
          assertThat(minHeap.poll()).contains(n);
        assertThat(minHeap.poll()).isEmpty();
      }

      @Test
      public void testHeapifyFuzzy() {
        int arity = ThreadLocalRandom.current().nextInt(2, 10);
        List<Integer> feed = ThreadLocalRandom.current().ints(1000, 0, 800)
            .boxed().collect(Collectors.toList());

        Heap<Integer> minHeap = new Heap<>(arity, Integer::compare, feed);
        Collections.sort(feed);

        for (int n: feed)
          assertThat(minHeap.poll()).contains(n);
        assertThat(minHeap.poll()).isEmpty();
      }
    }
    ```

## Benchmark

<div id="push_arity_curve" style="width: 100%"></div>
<div id="pop_arity_curve" style="width: 100%"></div>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawPushChart);
  google.charts.setOnLoadCallback(drawPopChart);

  function drawPushChart() {
    var data = google.visualization.arrayToDataTable([
      ['Arity', 'avg push (ns)'],
      [2, 70],
      [3, 58],
      [4, 48],
      [5, 31],
      [6, 40],
      [7, 41],
      [8, 44],
      [9, 130],
      [10, 105],
      [11, 38],
      [12, 50],
      [13, 68],
      [14, 17],
      [15, 16],
      [16, 19],
      [17, 16],
      [18, 17],
      [19, 16],
      [20, 17],
      [21, 17],
      [22, 18],
      [23, 20],
      [24, 16],
      [25, 16],
      [26, 22],
      [27, 14],
      [28, 23],
      [29, 17],
      [30, 16],
      [31, 17],
      [32, 14],
    ]);

    var options = {
      title: 'Average push time (ns)',
      curveType: 'function',
      legend: 'none',
      vAxis: { title: 'average push (ns)' },
      hAxis: { title: 'arity' }
    };

    var chart = new google.visualization.ColumnChart(document.getElementById('push_arity_curve'));

    chart.draw(data, options);
  }

  function drawPopChart() {
    var data = google.visualization.arrayToDataTable([
      ['Arity', 'avg pop (ns)'],
      [2, 9361],
      [3, 1650],
      [4, 1032],
      [5, 3952],
      [6, 1847],
      [7, 1672],
      [8, 1491],
      [9, 1520],
      [10, 1404],
      [11, 1511],
      [12, 1342],
      [13, 1362],
      [14, 668],
      [15, 808],
      [16, 769],
      [17, 962],
      [18, 814],
      [19, 918],
      [20, 789],
      [21, 768],
      [22, 869],
      [23, 800],
      [24, 836],
      [25, 827],
      [26, 855],
      [27, 1116],
      [28, 823],
      [29, 1072],
      [30, 879],
      [31, 929],
      [32, 1096],
    ]);

    var options = {
      title: 'Average pop time (ns)',
      curveType: 'function',
      legend: 'none',
      vAxis: { title: 'average pop (ns)' },
      hAxis: { title: 'arity' }
    };

    var chart = new google.visualization.ColumnChart(document.getElementById('pop_arity_curve'));

    chart.draw(data, options);
  }
</script>

[^1]: A complete binary tree is a binary tree where all layers are full, except maybe the last one. The last level, if not full, has all values to the left.

[^2]: ADT similar to Queue or Stack. In Queue/Stack, the order of serving depends on order of insertion, whereas in PQ, it depends on the given _priority_ of the elements.

<script>
class BinaryTreeNode {
  #value;
  #left = null;
  #right = null;

  constructor(value, left = null, right = null) {
    this.#value = value;
    this.#left = left;
    this.#right = right;
  }

  left() {
    return this.#left;
  }

  setLeft(node) {
    this.#left = node;
  }

  right() {
    return this.#right;
  }

  setRight(node) {
    this.#right = node;
  }

  isLeaf() {
    return this.#left == null && this.#right == null;
  }

  layerWiseInsert(value) {
    let queue = [this];
    while(queue.length > 0) {
      let [node] = queue.splice(0, 1);
      if (node.left() == null) {
        node.setLeft(new BinaryTreeNode(value));
        return;
      } else {
        queue.push(node.#left);
      }
      if (node.right() == null) {
        node.setRight(new BinaryTreeNode(value));
        return;
      } else {
        queue.push(node.#right);
      }
    }
  }

  valueAsText() {
    return `(${this.#value})`;
  }
}

class BinaryTree {
  #root = null;

  layerWiseInsert(value) {
    if (this.#root == null) {
      this.#root = new BinaryTreeNode(value);
      return;
    }
    this.#root.layerWiseInsert(value);
  }

  layerWiseInserts(values = []) {
    for (let v of values)
      this.layerWiseInsert(v);
  }

  toString() {
    return BinaryTreePrint.print(this.#root);
  }
}

class Line {
  #line
  #valueStartIndex;
  #valueLength;

  constructor() {
    this.#line = "";
    this.#valueStartIndex = -1;
    this.#valueLength = -1;
  }

  setValueText(content) {
    this.#valueStartIndex = this.#line.length;
    this.#valueLength = content.length;
    this.#line += content;
  }

  append(content) {
    this.#line += content;
    return this;
  }

  length() {
    return this.#line.length;
  }

  valueStartIndex() {
    return this.#valueStartIndex;
  }

  valueLength() {
    return this.#valueLength;
  }

  line() {
    return this.#line;
  }
}

class BinaryTreePrint {

  static print(root) {
    let lines = BinaryTreePrint.printLines(root);
    return lines.map(line => line.line()).join('\n');
  }

  static printLines(root) {
    let rootLine = new Line();
    let outLines = [rootLine];

    if (root == null) {
      rootLine.setValueText('null');
      return outLines;
    }
    if (root.isLeaf()) {
      rootLine.setValueText(root.valueAsText());
      return outLines;
    }

    if (root.left() != null) {
      let leftLines = BinaryTreePrint.printLines(root.left());
      BinaryTreePrint.processLeftLines(leftLines, outLines, rootLine);
    }

    rootLine.setValueText(root.valueAsText());

    if (root.right() != null) {
      let rightLines = BinaryTreePrint.printLines(root.right());
      BinaryTreePrint.processRightLines(rightLines, outLines, rootLine);
    }

    return outLines;
  }

  static processLeftLines(leftLines, outLines, rootLine) {
    let endIndexOfLeftRoot = leftLines[0].valueStartIndex() + leftLines[0].valueLength() - 1;
    rootLine.append(' '.repeat(endIndexOfLeftRoot) + '╭-');

    let lineLengths = leftLines.map(l => l.length());
    let longestLeftLineLength = Math.max(...lineLengths);
    rootLine.append('-'.repeat(longestLeftLineLength - (endIndexOfLeftRoot + 1)));

    outLines.push(...leftLines);
  }

  static processRightLines(rightLines, outLines, rootLine) {
    let lineLengths = outLines.map(line => line.length());
    let longestOutLineLength = Math.max(...lineLengths);
    outLines
        .filter(l => l.length() < longestOutLineLength)
        .forEach(l => l.append(' '.repeat(longestOutLineLength - l.length())));

    let startIndexOfRightRoot = rightLines[0].valueStartIndex();
    rootLine.append('-'.repeat(startIndexOfRightRoot) + '-╮');

    while (outLines.length < rightLines.length + 1)
      outLines.add(new Line().append(' '.repeat(longestOutLineLength)));

    for (let i = 0; i < rightLines.length; i++) {
      outLines[i + 1].append(' ').append(rightLines[i].line());
    }
  }
}

class MinHeap {
  #items = [];
  #printHeapifyStages;

  constructor(items = [], printHeapifyStages = false) {
    this.#items = items;
    this.#printHeapifyStages = printHeapifyStages;
    this.#heapify();
  }

  append(item) {
    this.#items.push(item);
    this.#swim(this.#items.length - 1);
  }

  pop() {
    if (this.#items.length === 0) return;
    showSinkStage(this.toString());
    let root = this.#items[0];
    this.#items[0] = this.#items[this.#items.length-1];
    this.#items.pop();
    this.#sink(0, true)
    return root;
  }

  #sink(index = 0, printSinkStages = false) {
    printSinkStages && showSinkStage(this.toString());
    while(index < this.#items.length) {
      let left = 2 * index + 1;
      let right = 2 * index + 2;
      let min = index;

      if (left < this.#items.length && this.#items[left] < this.#items[index]) min = left;
      if (right < this.#items.length && this.#items[right] < this.#items[min]) min = right;

      if(min === index) return;
      [this.#items[min], this.#items[index]] = [this.#items[index], this.#items[min]];
      printSinkStages && showSinkStage(this.toString());
      index = min;
    }
  }

  #swim(index) {
    showSwimStage(this.toString());
    while(index > 0) {
      let parent = Math.floor((index-1) / 2);
      if (this.#items[index] >= this.#items[parent]) return;
      [this.#items[parent], this.#items[index]] = [this.#items[index], this.#items[parent]];
      showSwimStage(this.toString());
      index = parent;
    }
  }

  #heapify() {
    const iterations = Math.floor((this.#items.length - 1) / 2);
    this.#printHeapifyStages && showHeapifyStage(this.toString());
    for (let i = iterations; i >= 0; i--) {
      this.#sink(i);
      this.#printHeapifyStages && showHeapifyStage(this.toString());
    }
  }

  toString() {
    let tree = new BinaryTree();
    tree.layerWiseInserts(this.#items);
    return tree.toString();
  }
}

function showHeapifyStage(content) {
  let stage = document.createElement('pre');
  stage.className = 'stage';
  stage.innerText = content;
  document.getElementById('heapify-stages').appendChild(stage);
}

function processHeapifyInput() {
  document.getElementById('heapify-stages').innerHTML = '';
  let value = document.getElementById('heapify-input').value;
  let items = value.split(/\s+/).map(x => x.trim()).filter(x => x.length > 0).map(x => Number(x));
  new MinHeap(items, true);
}

function showSwimStage(content) {
  let stage = document.createElement('pre');
  stage.className = 'stage';
  stage.innerText = content;
  document.getElementById('swim-stages').appendChild(stage);
}

function processSwimInput() {
  document.getElementById('swim-stages').innerHTML = '';
  let value = document.getElementById('append-input').value.trim();
  if (value.length > 0) {
    let startValue = document.getElementById('swim-input').value;
    let items = startValue.split(/\s+/).map(x => x.trim()).filter(x => x.length > 0).map(x => Number(x));
    let heap = new MinHeap(items, false);
    heap.append(Number(value));
  }
}

function showSinkStage(content) {
  let stage = document.createElement('pre');
  stage.className = 'stage';
  stage.innerText = content;
  document.getElementById('sink-stages').appendChild(stage);
}

function popHeap(heap) {
  document.getElementById('sink-stages').innerHTML = '';  

  let root = heap.pop();
  if (root) {
    alert$.next(`popped the root ${root}`);
  } else {
    alert$.next('nothing to pop');
  }
}

function processSinkInput() {
  document.getElementById('sink-stages').innerHTML = '';

  let startValue = document.getElementById('sink-input').value;
  let items = startValue.split(/\s+/).map(x => x.trim()).filter(x => x.length > 0).map(x => Number(x));
  let heap = new MinHeap(items, false);
  showSinkStage(heap.toString());

  document.getElementById('pop-input').onclick = (event) => popHeap(heap);
}

document.addEventListener("DOMContentLoaded", (event) => {
  document.getElementById('heapify-input').onkeyup = processHeapifyInput;

  document.getElementById('append-input').onchange = processSwimInput;
  document.getElementById('append-input').onkeyup = processSwimInput;
  document.getElementById('swim-input').onkeyup = processSwimInput;

  document.getElementById('sink-input').onkeyup = processSinkInput;
  processHeapifyInput();
  processSwimInput();
  processSinkInput();
});

</script>