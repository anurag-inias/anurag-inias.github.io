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

## Demo

=== "Heapify"

    Takes an array <input type="text" id="heapify-input" value="15 14 13 12 11"/> of length $N$ and calls `sink` on indices $\Big[\lfloor \frac{N-1}{2} \rfloor, ..., 0\Big]$ in order. Has the amortized time complexity of $O(n)$.

    <div id="heapify-stages" class="stages">
    </div>

=== "Push"

    Takes the heap <input type="text" id="swim-input" value="11 12 13 15 14"/> and pushes the element <input type="number" id="append-input" value="8"/> at the end of it. This is followed by `swim` operation on newly added element to bubble it up to its right place. Has the time complexity of $O(log \ n)$.

    <div id="swim-stages" class="stages">
    </div>

=== "Pop"

    Takes the heap <input type="text" id="sink-input" value="11 12 13 15 14"/> and <button id="pop-input">pops</button> its root. The root gets replaced with the last element of the heap, followed by `sink` operation on the new root to restore the min-heap property. Has the time complexity of $O(log \ n)$.

    <div id="sink-stages" class="stages">
    </div>

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