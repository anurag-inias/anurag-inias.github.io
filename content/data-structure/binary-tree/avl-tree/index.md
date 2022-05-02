---
title: "AVL Tree"
---

{{< toc >}}

## Introduction

AVL tree (Adelson-Velsky and Landis) is a self-balancing tree. It maintains the property that for any given node, the height difference between its left and right subtrees is no more than {{< katex >}} 1 {{< /katex >}}. This has the advantage of keeping _lookup_, _insertion_ and _deletion_ under {{< katex >}} O(log(n)) {{< /katex >}}.

It is covered nicely in textbooks and wikipedia, but I always find provided implementation mentally fatiguing. There are just too many corner cases that scare away anyone who wants to learn it. So I'll cover it for the sake of my own recollection.

## Rotations

At the heart of AVT tree is the `rotation` operation, this rebalances the tree to enforce the balance property {{< katex >}} |h_{left} - h_{right}| ≤ 1 {{< /katex >}}. There can be 4 types of rotations, which in fact can be further simplified to just 2 types of rotations.

{{< tabs "rotations" >}}

{{< tab "Clockwise" >}}
When left subtree is too high.

<pre>
  ┌─3     ┌─2─┐
┌─2   =>  1   3
1
</pre>
{{< /tab >}}

{{< tab "Anti-clockwise" >}}
When right subtree is too high.

<pre>
1─┐         ┌─2─┐
  2─┐   =>  1   3
    3
</pre>
{{< /tab >}}

{{< tab "Anti-clockwise then clockwise" >}}
Rotate left subtree anti-clockwise, then apply clockwise rotation on root.

<pre>
┌──3      ┌─3      ┌─2─┐
1─┐  => ┌─2    =>  1   3
  2     1
</pre>
{{< /tab >}}

{{< tab "Clockwise then anti-clockwise" >}}
Rotate right subtree clockwise, then apply anti-clockwise rotation on root.

<pre>
1──┐     1─┐         ┌─2─┐
 ┌─3  =>   2─┐  =>   1   3
 2           3
</pre>
{{< /tab >}}

{{< /tabs >}}

## Changing parent

Rotation is in fact nothing more that changing parent of a node. 

<pre>
1─┐         ┌─2─┐
  2─┐   =>  1   3
    3
</pre>

See the above example. The anti-clockwise rotation is just these two operations in sequence:
1. Set `1` as parent of `2`'s left child (in this case `null`).
2. Set `2` as parent of `1`.
3. Not shown here: set the new root `2` as the left/right child of `1`'s original parent.

Breakding down rotations in terms of _changing parent_ operations helps keep the mental strain low.

## Implementation

`insertion` is our key operation. It involves a straightforward BST-insertion, followed by rebalancing of the nodes. Note two things here:
- We only rebalance the subtree affectect by the insertion, not the whole tree.
- Rebalance is called from bottom-to-top on all ancestors of the inserted node.

{{< tabs "avl-implementation" >}}

{{< tab "Implementation" >}}
{{< highlight Java "linenos=table,hl_lines=46 76 88 101 107 112" >}}
package dev.justanotherblog.tree;

public class TreeNode {
  protected int value;
  protected TreeNode left, right, parent;

  public TreeNode(int value) {
    this.value = value;
    this.left = null;
    this.right = null;
    this.parent = null;
  }

  public TreeNode(int value, TreeNode parent) {
    this.value = value;
    this.parent = parent;
    this.left = null;
    this.right = null;
  }


  // Make a BST from given values.
  public static TreeNode makeBST(int... values) {
    TreeNode root = null;
    for (int val : values) {
      if (root == null) root = new TreeNode(val);
      else root = root.sortedInsert(val);
    }
    return root;
  }

  // Returns the new root.
  public TreeNode sortedInsert(int key) {
    if (key < value) {
      if (hasLeft()) left = left.sortedInsert(key);
      else left = new TreeNode(key, this);
    } else {
      if (hasRight()) right = right.sortedInsert(key);
      else right = new TreeNode(key, this);
    }

    return rebalance();
  }

  // Returns the new root.
  private TreeNode rebalance() {
    int lHeight = height(left);
    int rHeight = height(right);
    if (Math.abs(lHeight - rHeight) <= 1) return this;

    if (lHeight > rHeight) {
      if (height(left.left) < height(left.right)) {
        // ┌──3      ┌─3
        // 1─┐  => ┌─2     First straighten the tree
        //   2     1
        left.anticlockwise();
      }
      //   ┌─3     ┌─2─┐
      // ┌─2   =>  1   3
      // 1
      return clockwise();
    }

    if (height(right.left) > height(right.right)) {
      // 1──┐     1─┐
      //  ┌─3  =>   2─┐    First straighten the tree
      //  2           3
      right.clockwise();
    }
    // 1─┐         ┌─2─┐
    //   2─┐   =>  1   3
    //     3
    return anticlockwise();
  }

  private TreeNode clockwise() {
    TreeNode newRoot = left;
    TreeNode ancestor = parent;

    setLeftChild(newRoot.right, this);
    setRightChild(this, newRoot);
    if (ancestor == null)  newRoot.parent = null;
    else setAncestor(newRoot, ancestor, ancestor.left == this);

    return newRoot;
  }

  private TreeNode anticlockwise() {
    TreeNode newRoot = right;
    TreeNode ancestor = parent;

    setRightChild(newRoot.left, this);
    setLeftChild(this, newRoot);
    if (ancestor == null)  newRoot.parent = null;
    else setAncestor(newRoot, ancestor, ancestor.left == this);

    return newRoot;
  }

  // Called after rotation. Updates the left/right reference of the original root's parent.
  private static void setAncestor(TreeNode child, TreeNode ancestor, boolean asLeftChild) {
    child.parent = ancestor;
    if (asLeftChild) ancestor.setLeft(child);
    else ancestor.setRight(child);
  }

  private static void setRightChild(TreeNode child, TreeNode parent) {
    parent.setRight(child);
    if (child != null) child.parent = parent;
  }

  private static void setLeftChild(TreeNode child, TreeNode parent) {
    parent.setLeft(child);
    if (child != null) child.parent = parent;
  }

  public static int height(TreeNode node) {
    if (node == null) return 0;
    return Math.max(height(node.getLeft()), height(node.getRight())) + 1;
  }

  public boolean isBalanced() {
    return Math.abs(height(left) - height(right)) <= 1;
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


{{< tab "Unit Test" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.tree;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.concurrent.ThreadLocalRandom;
import org.junit.jupiter.api.Test;

class TreeNodeTest {

  @Test
  public void testEmpty() {
    assertNull(TreeNode.makeBST());
  }

  @Test
  public void testLeaf() {
    assertEquals("1", TreeNode.makeBST(1).toString());
  }

  @Test
  public void testLeftOne() {
    String expected = """
      ┌─2
      1 \s""";
    assertEquals(expected, TreeNode.makeBST(2, 1).toString());
  }

  @Test
  public void testRightOne() {
    String expected = """
      1─┐
        2""";
    assertEquals(expected, TreeNode.makeBST(1, 2).toString());
  }

  @Test
  public void testClockwiseRotate() {
    String expected = """
      ┌─2─┐
      1   3""";
    assertEquals(expected, TreeNode.makeBST(3, 2, 1).toString());
  }

  @Test
  public void testAntiClockwiseRotate() {
    String expected = """
      ┌─2─┐
      1   3""";
    assertEquals(expected, TreeNode.makeBST(1, 2, 3).toString());
  }

  @Test
  public void testFuzzy() {
    TreeNode root = TreeNode.makeBST(ThreadLocalRandom.current().ints(1000, 0, 999).toArray());
    assertTrue(root.isBalanced());
  }

}
{{< /highlight >}}
{{< /tab >}}

{{< /tabs >}}

## Benchmark

tl;dr It pays off being tidy.

{{< countsortchart.inline >}}
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart1);

  function drawChart1() {
    var data = google.visualization.arrayToDataTable([
      ['Size','Unbalanced','Balanced'],
      [100,2391300,522600],
      [500,470100,451600],
      [1000,514400,544400],
      [2000,950000,1231200],
      [3000,1980100,2588200],
      [4000,2380100,1635600],
      [5000,2867100,2297200],
      [6000,2112500,1715300],
      [7000,1630600,2384700],
      [8000,2871600,2093900],
      [9000,1776100,2659400],
      [10000,2614300,3874900],
      [20000,7160700,5612400],
      [30000,11090400,17787700],
      [40000,13162300,13216100],
      [50000,16950100,20176200],
      [60000,20069300,24943900],
      [70000,27317300,27328900],
      [80000,30123400,36462100],
      [90000,39822100,40642300],
      [100000,45643100,45038000]
    ]);
    data.addColumn({type: 'string', role: 'tooltip'});
    var options = {
        title: 'Insertion - Unbalanced vs AVL tree',
        curveType: 'function',
        height: 500,
        legend: { position: 'right' },
        vAxis: { title: 'Nanoseconds' },
        hAxis: { title: 'Input Size' }
      };
    var chart = new google.visualization.LineChart(document.getElementById('diagram_1'));
    chart.draw(data, options);
  }
</script>

<div id="diagram_1"></div>
{{< /countsortchart.inline >}}

{{< countsortchart.inline >}}
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart2);

    function drawChart2() {
      var data = google.visualization.arrayToDataTable([
        ['Size','Unbalanced','Balanced'],
        [100,9500,1300],
        [500,3700,1800],
        [1000,3100,1600],
        [2000,2400,1000],
        [3000,3100,1500],
        [4000,5300,2500],
        [5000,3300,1400],
        [6000,3500,1400],
        [7000,5500,22500],
        [8000,4500,11900],
        [9000,3800,1300],
        [10000,6300,1500],
        [20000,7300,1200],
        [30000,7700,1600],
        [40000,9500,2600],
        [50000,10600,1800],
        [60000,8800,1700],
        [70000,8900,1400],
        [80000,7700,1600],
        [90000,8500,1400],
        [100000,7400,1900]
    ]);
    data.addColumn({type: 'string', role: 'tooltip'});
    var options = {
        title: 'Search - Unbalanced vs AVL tree',
        curveType: 'function',
        height: 500,
        legend: { position: 'right' },
        vAxis: { title: 'Nanoseconds' },
        hAxis: { title: 'Input Size' }
      };
    var chart = new google.visualization.LineChart(document.getElementById('diagram_2'));
    chart.draw(data, options);
  }
</script>

<div id="diagram_2"></div>
{{< /countsortchart.inline >}}

Note:
- For input of size {{< katex >}} S {{< /katex >}}, the values are in range {{< katex >}} [0, S) {{< /katex >}}.
- I altered the implementation to cache `height` of nodes, and recalulate it on `rebalance` calls, that saves insane amount of cycles.
