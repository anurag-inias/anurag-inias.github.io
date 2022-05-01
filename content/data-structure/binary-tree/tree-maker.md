---
title: "Tree Making"
---

{{< toc >}}

`TreeNode` class with helper static methods for generating a tree from given values.

{{< tabs "treenode-implementation" >}}

{{< tab "TreeNode" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.tree;

import java.util.ArrayDeque;
import java.util.Queue;

public class TreeNode {
  private int value;
  private TreeNode left, right;

  // Make a BST from given values.
  public static TreeNode makeBST(int... values) {
    TreeNode root = null;
    for (int val : values) {
      if (root == null) root = new TreeNode(val);
      else root.sortedInsert(val);
    }
    return root;
  }

  // Make a tree layer by layer from given values.
  public static TreeNode makeLayerWise(Integer... values) {
    if (values.length == 0) return null;

    TreeNode root =  new TreeNode(values[0]);
    Queue<TreeNode> queue = new ArrayDeque<>();
    queue.offer(root);

    for (int i = 1; i < values.length; i += 2) {
      TreeNode left = values[i] == null ? null : new TreeNode(values[i]);
      TreeNode right = i+1 >= values.length || values[i + 1] == null ? null : new TreeNode(values[i+1]);
      TreeNode parent = queue.poll();

      parent.setLeft(left);
      parent.setRight(right);

      if (left != null) queue.add(left);
      if (right != null) queue.add(right);
    }

    return root;
  }

  public TreeNode(int value) {
    this.value = value;
    this.left = null;
    this.right = null;
  }

  public TreeNode(int value, TreeNode left, TreeNode right) {
    this.value = value;
    this.left = left;
    this.right = right;
  }

  public void sortedInsert(int key) {
    if (key < value) {
      if (hasLeft()) left.sortedInsert(key);
      else left = new TreeNode(key);
    } else {
      if (hasRight()) right.sortedInsert(key);
      else right = new TreeNode(key);
    }
  }

  public boolean isLeaf() {
    return !hasLeft() && !hasRight();
  }

  public int getValue() {
    return value;
  }

  public void setValue(int value) {
    this.value = value;
  }

  public TreeNode getLeft() {
    return left;
  }

  public void setLeft(TreeNode left) {
    this.left = left;
  }

  public TreeNode getRight() {
    return right;
  }

  public void setRight(TreeNode right) {
    this.right = right;
  }

  public boolean hasLeft() {
    return left != null;
  }

  public boolean hasRight() {
    return right != null;
  }

  @Override
  public String toString() {
    return BinaryTreePrinter.newBuilder()
        .self(String.valueOf(value))
        .left(left == null ? "" : left.toString())
        .right(right == null ? "" : right.toString())
        .build()
        .printToString();
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "Unit Tests" >}}
{{< highlight Java "linenos=table" >}}

package dev.justanotherblog.tree;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class TreeNodeTest {

  @Test
  public void testLayerWise_Empty() {
    assertNull(TreeNode.makeLayerWise());
  }

  @Test
  public void testLayerWise_Leaf() {
    assertEquals("1", TreeNode.makeLayerWise(1).toString());
  }

  @Test
  public void testLayerWise_Perfect() {
    String expected = """
        ┌─1─┐
        2   3""";
    assertEquals(expected, TreeNode.makeLayerWise(1, 2, 3).toString());
  }

  @Test
  public void testLayerWise_LeftChain() {
    String expected = """
            ┌─1
          ┌─2 \s
        ┌─3   \s
        4     \s""";
    assertEquals(expected, TreeNode.makeLayerWise(1, 2, null, 3, null, 4).toString());
  }

  @Test
  public void testLayerWise_RightChain() {
    String expected = """
        1─┐   \s
          2─┐ \s
            3─┐
              4""";
    assertEquals(expected, TreeNode.makeLayerWise(1, null, 2, null, 3, null, 4).toString());
  }

  @Test
  public void testLayerWise_LeftImbalanced() {
    String expected = """
        ┌─1─────┐
        2     ┌─3
            ┌─4 \s
            5   \s""";
    assertEquals(expected, TreeNode.makeLayerWise(1, 2, 3, null, null, 4, null, 5).toString());
  }

  @Test
  public void testLayerWise_RightImbalanced() {
    String expected = """
            ┌─1─┐
          ┌─2   3
        ┌─4     \s
        5       \s""";
    assertEquals(expected, TreeNode.makeLayerWise(1, 2, 3, 4, null, null, null, 5).toString());
  }

  @Test
  public void testBST_Empty() {
    assertNull(TreeNode.makeBST());
  }

  @Test
  public void testBST_Leaf() {
    assertEquals("1", TreeNode.makeBST(1).toString());
  }

  @Test
  public void testBST_Perfect() {
    String expected = """
        ┌─2─┐
        1   3""";
    assertEquals(expected, TreeNode.makeBST(2, 1, 3).toString());
  }

  @Test
  public void testBST_LeftChain() {
    String expected = """
            ┌─4
          ┌─3 \s
        ┌─2   \s
        1     \s""";
    assertEquals(expected, TreeNode.makeBST(4, 3, 2, 1).toString());
  }

  @Test
  public void testBST_RightChain() {
    String expected = """
        1─┐   \s
          2─┐ \s
            3─┐
              4""";
    assertEquals(expected, TreeNode.makeBST(1, 2, 3, 4).toString());
  }

  @Test
  public void testBST_LeftImbalanced() {
    String expected = """
        ┌─2─────┐
        1     ┌─5
            ┌─4 \s
            3   \s""";
    assertEquals(expected, TreeNode.makeBST(2, 1, 5, 4, 3).toString());
  }

  @Test
  public void testBST_RightImbalanced() {
    String expected = """
            ┌─4─┐
          ┌─3   5
        ┌─2     \s
        1       \s""";
    assertEquals(expected, TreeNode.makeBST(4, 5, 3, 2, 1).toString());
  }

}

{{< /highlight >}}
{{< /tab >}}

{{< /tabs >}}