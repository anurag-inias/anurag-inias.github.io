---
title: "Tree Printing"
date: 2022-04-18T22:51:44+05:30
---

{{< toc >}}

Often I need help visualizing a tree-like structure while debugging. Here is simple override to `toString` for pretty-printing:

## Left-to-right print

{{< tabs "tree-print-l-2-r" >}}
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

## Top-to-bottom print

Previous version is just a handful of lines of codes but the printed tree is confusing to look at. Next version is for a more natural top-to-bottom tree:

{{< tabs "tree-print-t-2-b" >}}
{{< tab "Implementation" >}}
{{< highlight Java "linenos=table" >}}
private static boolean isIgnoredChar(char c) {
  return c == ' ' || c == '┌' || c == '─' || c == '┐' || c == '-';
}

private static int findRootOffset(String str, boolean fromLeft) {
  int offset = 0;

  if (fromLeft) {
    for (int i = 0; i < str.length() && isIgnoredChar(str.charAt(i)); i++)
      offset++;
  } else {
    for (int i = str.length()-1; i >= 0 && isIgnoredChar(str.charAt(i)); i--)
      offset++;
  }

  return offset;
}

private static void mergeSubtreeStrings(String left, String right, int middlePadding, StringBuilder sb) {
  String[] leftLines = left.split("\\n");
  String[] rightLines = right.split("\\n");
  int l = 0, r = 0;

  int maxWidth = 0;
  for (int i = 0; i < Math.max(leftLines.length, rightLines.length); i++) {
    int width = l < leftLines.length ? leftLines[l].length() : 0;
    width += middlePadding;
    width += r < rightLines.length ? rightLines[r].length() : 0;
    maxWidth = Math.max(maxWidth, width);
  }

  while (l < leftLines.length && r < rightLines.length) {
    int width = leftLines[l].length() + middlePadding + rightLines[r].length();
    sb.append('\n');
    sb.append(leftLines[l++]);
    sb.append(" ".repeat(middlePadding));
    sb.append(rightLines[r++]);
    sb.append(" ".repeat(maxWidth - width));
  }
  while (l < leftLines.length) sb.append('\n').append(leftLines[l]).append(" ".repeat(maxWidth - leftLines[l++].length()));
  while (r < rightLines.length) sb.append('\n').append(" ".repeat(maxWidth - rightLines[r].length())).append(rightLines[r++]);
}

@Override
public String toString() {
  if (isLeaf()) return String.valueOf(value);

  StringBuilder sb = new StringBuilder();

  String self = String.valueOf(value);
  String left = this.left == null ? "" : this.left.toString();
  String right = this.right == null ? "" : this.right.toString();

  boolean hasLeft = !left.isEmpty();
  boolean hasRight = !right.isEmpty();

  // Build the first row. Here we have the root of this node.
  if (hasLeft) {
    String leftRoot = left.split("\\n")[0];
    int dashes = findRootOffset(leftRoot, false) + 1;
    int spaces = leftRoot.length() - dashes;

    sb.append(" ".repeat(spaces)).append('┌').append("─".repeat(dashes));
  }
  sb.append(self);
  if (hasRight) {
    String rightRoot = right.split("\\n")[0];
    int dashes = findRootOffset(rightRoot, true) + 1;
    int spaces = rightRoot.length() - dashes;

    sb.append("─".repeat(dashes)).append('┐').append(" ".repeat(spaces));
  }

  // Add the following rows which have the left and right subtree in them.
  int extra = (hasLeft && hasRight) ? 2 : 1;
  mergeSubtreeStrings(left, right, self.length() + extra, sb);

  return sb.toString();
}
{{< /highlight >}}
{{< /tab >}}
{{< tab "Unit test" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.avl;

import static org.junit.jupiter.api.Assertions.*;

import java.util.concurrent.ThreadLocalRandom;
import org.junit.jupiter.api.Test;

class TreeNodeTest {

  @Test
  public void testLeaf() {
    assertEquals("10", new TreeNode(10).toString());
  }

  @Test
  public void testJustLeftChild() {
    String expected = """
        ┌─10
      ┌─9  \s
      8    \s""";
    TreeNode root = new TreeNode(10, new TreeNode(9), null);
    root.getLeft().setLeft(new TreeNode(8));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testJustRightChild() {
    String expected = """
      10─┐\s
         19""";
    TreeNode root = new TreeNode(10, null, new TreeNode(19));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testBothChild() {
    String expected = """
        ┌─10─┐\s
      123    45""";
    TreeNode root = new TreeNode(10, new TreeNode(123), new TreeNode(45));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testLeftChain() {
    String expected = """
            ┌─5
          ┌─4 \s
        ┌─3   \s
      ┌─2     \s
      1       \s""";
    TreeNode root = new TreeNode(5, new TreeNode(4, new TreeNode(3, new TreeNode(2, new TreeNode(1), null), null), null), null);
    assertEquals(expected, root.toString());
  }

  @Test
  public void testRightChain() {
    String expected = """
      1─┐     \s
        2─┐   \s
          3─┐ \s
            4─┐
              5""";
    TreeNode root = new TreeNode(1, null, new TreeNode(2, null, new TreeNode(3, null, new TreeNode(4, null, new TreeNode(5)))));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testBothChildWithLeftChain() {
    String expected = """
            ┌─5─┐\s
          ┌─4   10
        ┌─3      \s
      ┌─2        \s
      1          \s""";
    TreeNode root = new TreeNode(5, new TreeNode(4, new TreeNode(3, new TreeNode(2, new TreeNode(1), null), null), null), new TreeNode(10));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testBothChildWithRightChain() {
    String expected = """
      ┌─1─┐     \s
      0   2─┐   \s
            3─┐ \s
              4─┐
                5""";
    TreeNode root = new TreeNode(1, new TreeNode(0), new TreeNode(2, null, new TreeNode(3, null, new TreeNode(4, null, new TreeNode(5)))));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testPerfectTree() {
    String expected = """
        ┌───4────┐  \s
      ┌─2─┐    ┌─61─┐
      1   3   56    7""";
    TreeNode root = new TreeNode(4, new TreeNode(2), new TreeNode(61));
    root.getLeft().setLeft(new TreeNode(1));
    root.getLeft().setRight(new TreeNode(3));
    root.getRight().setLeft(new TreeNode(56));
    root.getRight().setRight(new TreeNode(7));
    assertEquals(expected, root.toString());
  }

  @Test
  public void testDoublePerfectTree() {
    String expected = """
            ┌───────8─────────┐         \s
        ┌───4───┐        ┌────12────┐   \s
      ┌─2─┐   ┌─6─┐   ┌─10─┐      ┌─14─┐\s
      1   3   5   7   9    11    13    15""";
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
{{< tab "Example trees" >}}
<pre>
    ┌─────────────8
┌───1───────┐      
0─┐   ┌─────7─┐    
  0   2─┐     7─┐  
        4─┐     7  
          4        


        ┌───────────────────14───────┐          
    ┌───5───┐                   ┌────16─┐       
┌───4─┐   ┌─6────────────┐     15─┐     16─┐    
2─┐   4   5            ┌─12       15       19─┐ 
  2             ┌─────10                      19
              ┌─8─┐                             
              6   8─┐                           
                    9    

                               ┌──────────────────────────────────────15─┐ 
                  ┌───────────-2─────────────────────────────┐           18
          ┌─────-13──────┐                        ┌──────────12────┐       
      ┌─-16──┐        ┌─-9──┐              ┌─────10────┐         ┌─14      
  ┌─-18     -15     -13    -5     ┌────────3───┐     ┌─11─┐     13         
-19                              -1────┐     ┌─7    10    11               
                                     ┌─1─┐   5                             
                                    -1   1     

                                             ┌───────────────────35──────────┐    
                              ┌─────────────27───────┐               ┌───────37─┐ 
        ┌────────────────────20────┐            ┌────29───────┐     35─┐        37
┌───────8──────────────┐         ┌─26─┐        27─┐      ┌────33       35─┐       
3─────┐     ┌──────────17─┐     24    26─┐        27    31─┐              35      
  ┌───6   ┌─9─┐           19             26                32                     
  4─┐     8   13─┐                                                                
    5            13─┐                                                             
                    16                                                            
</pre>
{{< /tab >}}
{{< /tabs >}}

### Tree Printer

The logic for printing the tree can be extracted to a helper class. This can be used to print any binary tree-like data structure.

{{< tabs "tree-printer-class" >}}
{{< tab "Implementation" >}}
{{< highlight Java "linenos=table" >}}
import java.util.function.Supplier;

public class BinaryTreePrinter<T> {

  public static class BinaryTreePrinterBuilder<T> {
    private Supplier<String> self, left, right;

    public BinaryTreePrinterBuilder<T> self(Supplier<String> self) {
      this.self = self;
      return this;
    }

    public BinaryTreePrinterBuilder<T> left(Supplier<String> left) {
      this.left = left;
      return this;
    }

    public BinaryTreePrinterBuilder<T> right(Supplier<String> right) {
      this.right = right;
      return this;
    }

    public BinaryTreePrinter<T> build() {
      if (self == null || right == null || left == null) throw new IllegalArgumentException();
      return new BinaryTreePrinter<>(self, left, right);
    }
  }

  private final Supplier<String> self, left, right;

  private BinaryTreePrinter(Supplier<String> self, Supplier<String> left,
      Supplier<String> right) {
    this.self = self;
    this.left = left;
    this.right = right;
  }

  public static <T> BinaryTreePrinterBuilder<T> newBuilder() {
    return new BinaryTreePrinterBuilder<>();
  }

  public String printToString() {
    String self = this.self.get();
    String left = this.left.get();
    String right = this.right.get();

    boolean hasLeft = !left.isEmpty();
    boolean hasRight = !right.isEmpty();
    if (!hasLeft  && !hasRight) return self;

    StringBuilder sb = new StringBuilder();
    // Build the first row. Here we have the root of this node.
    if (hasLeft) {
      String leftRoot = left.split("\\n")[0];
      int dashes = findRootOffset(leftRoot, false) + 1;
      int spaces = leftRoot.length() - dashes;

      sb.append(" ".repeat(spaces)).append('┌').append("─".repeat(dashes));
    }
    sb.append(self);
    if (hasRight) {
      String rightRoot = right.split("\\n")[0];
      int dashes = findRootOffset(rightRoot, true) + 1;
      int spaces = rightRoot.length() - dashes;

      sb.append("─".repeat(dashes)).append('┐').append(" ".repeat(spaces));
    }

    // Add the following rows which have the left and right subtree in them.
    int extra = (hasLeft && hasRight) ? 2 : 1;
    mergeSubtreeStrings(left, right, self.length() + extra, sb);

    return sb.toString();
  }

  private boolean isLeaf() {
    return !left.get().isEmpty() && !right.get().isEmpty();
  }

  private static boolean isIgnoredChar(char c) {
    return c == ' ' || c == '┌' || c == '─' || c == '┐' || c == '-';
  }

  private static int findRootOffset(String str, boolean fromLeft) {
    int offset = 0;

    if (fromLeft) {
      for (int i = 0; i < str.length() && isIgnoredChar(str.charAt(i)); i++)
        offset++;
    } else {
      for (int i = str.length()-1; i >= 0 && isIgnoredChar(str.charAt(i)); i--)
        offset++;
    }

    return offset;
  }

  private static void mergeSubtreeStrings(String left, String right, int middlePadding, StringBuilder sb) {
    String[] leftLines = left.split("\\n");
    String[] rightLines = right.split("\\n");
    int l = 0, r = 0;

    int maxWidth = 0;
    for (int i = 0; i < Math.max(leftLines.length, rightLines.length); i++) {
      int width = l < leftLines.length ? leftLines[l].length() : 0;
      width += middlePadding;
      width += r < rightLines.length ? rightLines[r].length() : 0;
      maxWidth = Math.max(maxWidth, width);
    }

    while (l < leftLines.length && r < rightLines.length) {
      int width = leftLines[l].length() + middlePadding + rightLines[r].length();
      sb.append('\n');
      sb.append(leftLines[l++]);
      sb.append(" ".repeat(middlePadding));
      sb.append(rightLines[r++]);
      sb.append(" ".repeat(maxWidth - width));
    }
    while (l < leftLines.length) sb.append('\n').append(leftLines[l]).append(" ".repeat(maxWidth - leftLines[l++].length()));
    while (r < rightLines.length) sb.append('\n').append(" ".repeat(maxWidth - rightLines[r].length())).append(rightLines[r++]);
  }

}
{{< /highlight >}}
{{< /tab >}}
{{< tab "Usage" >}}
{{< highlight Java "linenos=table" >}}
@Override
public String toString() {
  return BinaryTreePrinter.newBuilder()
      .self(() -> String.valueOf(value))
      .left(() -> left == null ? "" : left.toString())
      .right(() -> right == null ? "" : right.toString())
      .build().printToString();
}
{{< /highlight >}}
{{< /tab >}}
{{< /tabs >}}