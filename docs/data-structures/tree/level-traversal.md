# Level Order Traversal

<style>
.md-logo img {
  content: url('/data-structures/tree/logo.svg');
}
</style>

## Goal

Given a binary tree, print its nodes level by level.

## Example

![](/data-structures/tree/level-traversal.png){width=300}

## Implementation

```kotlin linenums="1"
fun levelOrderTraversal(root: TreeNode) {
  val queue = LinkedList<TreeNode>()
  queue.offer(root)
  var depth = 1

  while (queue.isNotEmpty()) {
    val layerWidth = queue.size

    // All these nodes have same `depth`.
    for (i in 1..layerWidth) {
      val n = queue.poll()
      print("${n.`val`} ")

      n.left?.let { queue.add(it) }
      n.right?.let { queue.add(it) }
    }

    // New layer started.
    println()
    depth++
  }
}
```

- `LinkedList` performs better than an `ArrayList` when used as a queue.
- First `while` loop acts over each layer, and the nested `while` loops nodes in that layer.
