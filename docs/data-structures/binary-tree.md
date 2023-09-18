# Binary Tree

Abstract data type that stores elements hierarchically. Each element, save for the root, have a _parent_ element and zero or more children.

## Definitions

- internal node - has one ore more children
- leaf node - has no children
- full binary / proper tree - all nodes have 0 or 2 children.
- perfect binary tree - a full binary tree where all leaves have same depth.
- complete binary tree - all levels, except possibly the last, are completely filled. Heap is a complete binary tree.
- balanced binary tree - difference in height of left and right subtrees is $\le 1$.

## Properties

```
  ╭---1---╮      height: 2 = log(leaves)
╭-2-╮   ╭-3-╮    nodes: 7, leaves: 4, internal: 3
4   5   6   7
```

- A binary tree with $l$ leaves has minimum height $h \ge log_2(l)$.
- With $n$ nodes, a binary tree has minimum height $h \ge log_2(n+1) - 1$.
- $e = n-1$ where $e$ is total edges.

## Traversal

```
              ╭-8----╮
           ╭-11    ╭-56-╮
    ╭-----19      33    4
 ╭-78-╮          
89    115        
```

=== "BFS / Level-order traversal"

    Traverse the tree one level at a time.

    ```javascript
    ['8', '11', '56', '19', '33', '4', '78', '89', '115']

    function bfs(root) {
      let queue = [root], out = [];
      
      while(queue.length > 0) {
        let [node] = queue.splice(0, 1); // dequeue front
        out.push(node);

        if (node.left() != null)
          queue.push(node.left())
        if (node.right() != null)
          queue.push(node.right())
      }

      return out;
    }
    ```

    We can use it to populate a tree in layers:

    ```javascript
    function buildTree(values) {
      let root = null;
      for (let v of values) {
        let newNode = new BinaryTreeNode(v);
        if (root == null) 
          root = newNode;
        else
          populate(root, newNode)
      }	
      return root;
    }

    function populate(root, value) {
      let queue = [root];
      let newNode = new BinaryTreeNode(value);
      
      while(queue.length > 0) {
        let [node] = queue.splice(0, 1); // dequeue front

        if (node.left() != null)
          queue.push(node.left())
        else {
          node.setLeft(newNode);
          break;
        }
        if (node.right() != null)
          queue.push(node.right())
        else {
          node.setRight(newNode);
          break;
        }
      }
    }
    ```

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
    return `${this.#value}`;
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

let root = new BinaryTreeNode(
	8, 
	new BinaryTreeNode(
		11, 
		new BinaryTreeNode(
			19, 
			new BinaryTreeNode(78, new BinaryTreeNode(89), new BinaryTreeNode(115)), 
			null
		), 
		null
	), 
	new BinaryTreeNode(56, new BinaryTreeNode(33), new BinaryTreeNode(4))
)  
</script>