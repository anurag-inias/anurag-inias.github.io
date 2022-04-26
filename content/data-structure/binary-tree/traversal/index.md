---
title: "Tree Traversals"

resources:
  - name: inorder-steps
    src: "inorder-traversal.png"
    title: Nodes in the stack and its unwind direction
---
{{< toc >}}

Traversing a tree involves iterating over its node in some order. I'm covering the DFS and BFS traversals.

## Depth-First Search

### a. Pre-order traversal

<pre>
  ┌───4───┐
┌─2─┐   ┌─6
1   3   5  

4, 2, 1, 3, 6, 5
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
public List<Integer> traverse(TreeNode root) {
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

### b. Post-order traversal

<pre>
  ┌───4───┐
┌─2─┐   ┌─6
1   3   5  

1, 3, 2, 5, 6, 4
</pre>

* Recursively visit the left node.
* Recursively visit the right node.
* Visit the current node

{{< tabs "postorder" >}}

{{< tab "Recursive" >}}
{{< highlight Java "linenos=table" >}}
public List<Integer> traverse(TreeNode root) {
  List<Integer> out = new ArrayList<>();
  traverse(root, out);
  return out;
}

private void traverse(TreeNode node, List<Integer> out) {
  if (node == null) return;
  traverse(node.getLeft(), out);
  traverse(node.getRight(), out);
  out.add(node.getValue());
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "Iterative" >}}
{{< highlight Java "linenos=table" >}}
public List<Integer> iterative(TreeNode root) {
  Deque<TreeNode> inverter = new ArrayDeque<>();
  Deque<TreeNode> stack = new ArrayDeque<>();
  stack.push(root);
  while (!stack.isEmpty()) {
    TreeNode node = stack.pop();
    inverter.push(node);

    if (node.hasLeft()) stack.push(node.getLeft());
    if (node.hasRight()) stack.push(node.getRight());
  }


  List<Integer> out = new ArrayList<>(inverter.size());
  while (!inverter.isEmpty()) out.add(inverter.pop().getValue());
  return out;
}
{{< /highlight >}}
{{< /tab >}}

{{< /tabs >}}

### c. Inorder traversal

<pre>
  ┌───4───┐
┌─2─┐   ┌─6
1   3   5  

1, 2, 3, 4, 5, 6
</pre>

* Recursively visit the left node.
* Visit the current node
* Recursively visit the right node.

{{< img name="inorder-steps" size="small" lazy=true >}}

{{< tabs "inorder" >}}

{{< tab "Recursive" >}}
{{< highlight Java "linenos=table" >}}
public List<Integer> traverse(TreeNode root) {
  List<Integer> out = new ArrayList<>();
  traverse(root, out);
  return out;
}

private void traverse(TreeNode node, List<Integer> out) {
  if (node == null) return;
  traverse(node.getLeft(), out);
  out.add(node.getValue());
  traverse(node.getRight(), out);
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "Iterative" >}}
{{< highlight Java "linenos=table" >}}
public List<Integer> traverse(TreeNode root) {
  List<Integer> out = new ArrayList<>();
  Deque<TreeNode> stack = new ArrayDeque<>();

  while (current != null || !stack.isEmpty()) {
    if (current != null) {
      stack.push(current);
      current = current.getLeft();
    } else {
      current = stack.pop();
      out.add(current.getValue());
      current = current.getRight();
    }
  }

  return out;
}
{{< /highlight >}}
{{< /tab >}}

{{< /tabs >}}