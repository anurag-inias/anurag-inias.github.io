---
title: "Tree Traversals"
---
{{< toc >}}

Traversing a tree involves iterating over its node in some order. I'm covering the DFS and BFS traversals.

## Depth-First Search

### a. Pre-order traversal

<pre>
        ┌────61────┐ 
     ┌─31─┐      ┌─80
   27    51     68   

61, 31, 27, 51, 80, 68
</pre>

* Visit the current node
* Recursively visit the left node.
* Recursively visit the right node.

{{< tabs "preorder" >}}

{{< tab "Recursive" >}}
{{< highlight Java "linenos=table" >}}
public List<Integer> traverse(TreeNode root) {
  List<Integer> out = new ArrayList<>();
  traverse(root, out);
  return out;
}

private void traverse(TreeNode node, List<Integer> out) {
  if (node == null) return;
  out.add(node.getValue());
  traverse(node.getLeft(), out);
  traverse(node.getRight(), out);
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "Iterative" >}}
{{< highlight Java "linenos=table" >}}
public List<Integer> iterative(TreeNode root) {
  List<Integer> out = new ArrayList<>();

  Deque<TreeNode> stack = new ArrayDeque<>();
  stack.push(root);
  while (!stack.isEmpty()) {
    TreeNode node = stack.pop();
    out.add(node.getValue());

    if (node.hasRight()) stack.push(node.getRight());
    if (node.hasLeft()) stack.push(node.getLeft());
  }

  return out;
}
{{< /highlight >}}
{{< /tab >}}

{{< /tabs >}}