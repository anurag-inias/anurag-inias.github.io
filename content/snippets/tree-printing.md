---
title: "Tree Printing"
date: 2022-04-18T22:51:44+05:30
draft: true
---

Often I need help visualizing a tree-like structure while debugging. Here is simple override to `toString` for pretty-printing:

{{< tabs "pretty-print-tree" >}}
{{< tab "Implementation" >}}
{{< highlight Java "linenos=table" >}}
@Override
public String toString() {
  if (isLeaf()) return String.valueOf(value);

  StringBuilder sb = new StringBuilder();
  sb.append(value).append('\n');

  boolean hasLeft = left != null;
  boolean hasRight = right != null;

  if (hasLeft) {
    if (hasRight) sb.append("├─").append(left.toString().replaceAll("\\n", "\n| "));
    else sb.append("└─").append(left.toString().replaceAll("\\n", "\n  "));
  }
  if (hasRight) {
    if (hasLeft) sb.append('\n');
    sb.append("└─").append(right.toString().replaceAll("\\n", "\n  "));
  }

  return sb.toString();
}
{{< /highlight >}}
{{< /tab >}}
{{< tab "Unit test" >}}
{{< highlight Java "linenos=table" >}}
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class TreeNodeTest {

  @Test
  public void testLeaf() {
    assertEquals("10", new TreeNode(10).toString());
  }

  @Test
  public void testJustLeftChild() {
    String expected = """
        10
        └─9""";
    TreeNode root = new TreeNode(10, new TreeNode(9), null);
    assertEquals(expected, root.toString());
  }

  @Test
  public void testJustRightChild() {
    String expected = """
        10
        └─19""";
    TreeNode root = new TreeNode(10, null, new TreeNode(19));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testBothChild() {
    String expected = """
        10
        ├─9
        └─19""";
    TreeNode root = new TreeNode(10, new TreeNode(9), new TreeNode(19));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testLeftChain() {
    String expected = """
        5
        └─4
          └─3
            └─2
              └─1""";
    TreeNode root = new TreeNode(5, new TreeNode(4, new TreeNode(3, new TreeNode(2, new TreeNode(1), null), null), null), null);
    assertEquals(expected, root.toString());
  }

  @Test
  public void testRightChain() {
    String expected = """
        1
        └─2
          └─3
            └─4
              └─5""";
    TreeNode root = new TreeNode(1, null, new TreeNode(2, null, new TreeNode(3, null, new TreeNode(4, null, new TreeNode(5)))));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testBothChildWithLeftChain() {
    String expected = """
        5
        ├─4
        | └─3
        |   └─2
        |     └─1
        └─10""";
    TreeNode root = new TreeNode(5, new TreeNode(4, new TreeNode(3, new TreeNode(2, new TreeNode(1), null), null), null), new TreeNode(10));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testBothChildWithRightChain() {
    String expected = """
        1
        ├─0
        └─2
          └─3
            └─4
              └─5""";
    TreeNode root = new TreeNode(1, new TreeNode(0), new TreeNode(2, null, new TreeNode(3, null, new TreeNode(4, null, new TreeNode(5)))));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testPerfectTree() {
    String expected = """
        4
        ├─2
        | ├─1
        | └─3
        └─6
          ├─5
          └─7""";
    TreeNode root = new TreeNode(4, new TreeNode(2), new TreeNode(6));
    root.getLeft().setLeft(new TreeNode(1));
    root.getLeft().setRight(new TreeNode(3));
    root.getRight().setLeft(new TreeNode(5));
    root.getRight().setRight(new TreeNode(7));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testDoublePerfectTree() {
    String expected = """
        8
        ├─4
        | ├─2
        | | ├─1
        | | └─3
        | └─6
        |   ├─5
        |   └─7
        └─12
          ├─10
          | ├─9
          | └─11
          └─14
            ├─13
            └─15""";
    TreeNode leftRoot = new TreeNode(4, new TreeNode(2), new TreeNode(6));
    leftRoot.getLeft().setLeft(new TreeNode(1));
    leftRoot.getLeft().setRight(new TreeNode(3));
    leftRoot.getRight().setLeft(new TreeNode(5));
    leftRoot.getRight().setRight(new TreeNode(7));

    TreeNode rightRoot = new TreeNode(12, new TreeNode(10), new TreeNode(14));
    rightRoot.getLeft().setLeft(new TreeNode(9));
    rightRoot.getLeft().setRight(new TreeNode(11));
    rightRoot.getRight().setLeft(new TreeNode(13));
    rightRoot.getRight().setRight(new TreeNode(15));

    TreeNode root = new TreeNode(8, leftRoot, rightRoot);
    assertEquals(expected, root.toString());
  }

}
{{< /highlight >}}
{{< /tab >}}
{{< /tabs >}}
