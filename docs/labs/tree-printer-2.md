# Tree Printer v2

## Example

```
                                                  Once_upon_a_midnight_dreary
                         ┌─────────────────────────────────────┴────────────────────┐
                 while_I_pondered                                             weak_and_weary
         ┌───────────────┼───────────────┐                                           └──────────────┬───────────────┐
Over_many_a_quaint       and        curious_volume                                          of_forgotten_lore While_I_nodded
```

## About

First verion of tree printer does not let you control the placement of child nodes. That is, if a node has only one child, it'll get placed below the parent. That's an issue if you are trying to print a binary search tree.

Similarly, perhaps someone trying to print a tree might want all children to be on right, or on left. To grant this control to caller, we alter `PrintableNode` in the following manner:

```kotlin linenums="1"
interface PrintableNode {

  fun content(): String

  fun children(): List<PrintableNode>

  fun leaf(): Boolean = children().isEmpty()

  fun left(): IntRange = 0..<children().size/2

  fun below(): Int? = with(children().size) {
    when (this % 2) {
      0 -> null
      else -> this / 2
    }
  }

  fun right(): IntRange = with(children().size) {
    when (this % 2) {
      0 -> this / 2..<this
      else -> (this / 2 + 1)..<this
    }
  }
}
```

## Implementation

```kotlin linenums="1"
package com.example.tree

fun print(node: PrintableNode): String {
  return printSubtree(node).rows.joinToString(separator = "\n")
}

private fun printSubtree(node: PrintableNode): PrintedSubtree {
  if (node.leaf()) {
    return PrintedSubtree(
      plumbAt = node.width / 2,
      rows = mutableListOf(StringBuilder(node.content()))
    )
  }

  // Step 1. Recursively create subtrees.
  // Each subtree column has even width from top to bottom.
  val subtrees = mutableListOf<PrintedSubtree>()
  for (child in node.children()) {
    subtrees.add(printSubtree(child))
  }

  // Step 2. Add column gutter.
  // All but the rightmost subtree is given a right padding.
  addColumnGutter(subtrees)

  // Step 3. Ensure that all subtree columns are same height.
  // This is useful before they can be stitched together.
  enforceMinimumHeight(subtrees)

  // Step 4. Stitch subtree columns together.
  // And adds a new row at the top with the plumbing set up.
  val merged = mergeColumns(node.content().length, subtrees, node.left(), node.below(), node.right())

  val rootRow = StringBuilder()
  val n = node.content().length
  val w = merged.width
  rootRow
    .append(" ".repeat(max(0, merged.plumbAt - n / 2)))
    .append(node.content())

  val rightPadding = w - merged.plumbAt - 1 - (n - n / 2)
  if (rightPadding < 0) {
    rootRow.append(" ".repeat(-rightPadding))
    for (row in merged.rows) {
      row.append(" ".repeat(-rightPadding))
    }
  } else {
    rootRow.append(" ".repeat(rightPadding))
  }

  merged.rows.addFirst(rootRow)
  trim(merged)
  return PrintedSubtree(merged.plumbAt, merged.rows)
}

private fun trim(subtree: PrintedSubtree) {
  val start = subtree.rows.minOf { row -> row.indexOfFirst { it != ' ' } }
  val end = subtree.rows.maxOf { row -> row.indexOfLast { it != ' ' } }

  for ((r, row) in subtree.rows.withIndex()) {
    val offset = end - start + 1 - row.length
    if (offset > 0) {
      row.append(" ".repeat(offset))
    }
    subtree.rows[r] = StringBuilder(row.subSequence(start..end))
  }
}

private fun columnsPlumbing(parentWidth: Int, subtrees: List<PrintedSubtree>, left: IntRange, below: Int?, right: IntRange): StringBuilder {
  val columns = subtrees.size
  val row = StringBuilder()

  for (index in left) {
    val column = subtrees[index]
    val w = column.width
    row
      .append((if (columns > 1 && index > 0) "─" else " ").repeat(column.plumbAt))
      .append((if (columns > 1 && index > 0) '┬' else '┌'))
      .append("─".repeat(w - column.plumbAt - 1))
  }
  if (below == null) {
    if (left.isEmpty()) {
      row
        .append(" ".repeat(parentWidth/2))
        .append('└')
        .append("─".repeat(parentWidth - 1 - parentWidth / 2))
    } else if (right.isEmpty()) {
      row
        .append("─".repeat(parentWidth/2))
        .append('┘')
        .append(" ".repeat(parentWidth - 1 - parentWidth / 2))
    } else {
      row
        .append("─".repeat(parentWidth/2))
        .append('┴')
        .append("─".repeat(parentWidth - 1 - parentWidth / 2))
    }
  } else {
    val column = subtrees[below]
    var padding = parentWidth - column.width
    if (padding < 0) padding = 0
    if (left.isEmpty() && right.isEmpty()) {
      row
        .append(" ".repeat(column.plumbAt + padding / 2))
        .append('|')
        .append(" ".repeat(column.width - column.plumbAt - 1 + padding - (padding / 2)))
    } else if (left.isEmpty()) {
      row
        .append(" ".repeat(column.plumbAt + padding / 2))
        .append('├')
        .append("─".repeat(column.width - column.plumbAt - 1 + padding - (padding / 2)))
    } else if (right.isEmpty()) {
      row
        .append("─".repeat(column.plumbAt + padding / 2))
        .append('┤')
        .append(" ".repeat(column.width - column.plumbAt - 1 + padding - (padding / 2)))
    } else {
      row
        .append("─".repeat(column.plumbAt + padding / 2))
        .append('┼')
        .append("─".repeat(column.width - column.plumbAt - 1 + padding - (padding / 2)))
    }
  }
  for (index in right) {
    val column = subtrees[index]
    val w = column.width
    row
      .append("─".repeat(column.plumbAt))
      .append((if (columns > 1 && index < columns - 1) '┬' else '┐'))
      .append((if (columns > 1 && index < columns - 1) "─" else " ").repeat(w - column.plumbAt - 1))
  }
  return row
}

// c1 c2  c3    c1 c2  c3
// aa bbb cc    aa|bbb|cc
// aa bbb cc => aa|bbb|cc
// aa     cc    aa|    cc
//        cc           cc
private fun addColumnGutter(subtrees: List<PrintedSubtree>) {
  for ((c, column) in subtrees.withIndex()) {
    if (c == subtrees.size - 1) continue
    for (row in column.rows) {
      row.append(' ')
    }
  }
}

// c1 c2  c3    c1 c2  c3
// aa|bbb|cc    aa|bbb|cc
// aa|bbb|cc => aa|bbb|cc
// aa|    cc    aa|•••|cc
//        cc    ••|•••|cc
private fun enforceMinimumHeight(subtrees: List<PrintedSubtree>) {
  val maxHeight = subtrees.maxOf { it.height }
  for (subtree in subtrees) {
    subtree.height = maxHeight
  }
}

// c1 c2  c3       c1
// aa|bbb|cc    aa|bbb|cc
// aa|bbb|cc => aa|bbb|cc
// aa|•••|cc    aa|•••|cc
// ••|•••|cc    ••|•••|cc
private fun mergeColumns(parentWidth: Int, subtrees: List<PrintedSubtree>, left: IntRange, below: Int?, right: IntRange): PrintedSubtree {
  val rows = mutableListOf(columnsPlumbing(parentWidth, subtrees, left, below, right))

  var plumbAt: Int? = null
  var width = 0
  val height = subtrees.first().height

  for (r in 0..<height) {
    val row = StringBuilder()
    for (i in left) {
      row.append(subtrees[i].rows[r])
      width += subtrees[i].width
    }
    if (below == null) {
      row.append(" ".repeat(parentWidth))
      if (plumbAt == null) plumbAt = width + parentWidth / 2
    } else {
      val padding = parentWidth - subtrees[below].width
      if (padding <= 0) {
        row.append(subtrees[below].rows[r])
        if (plumbAt == null) plumbAt = width + subtrees[below].plumbAt
      } else {
        row
          .append(" ".repeat(padding / 2))
          .append(subtrees[below].rows[r])
          .append(" ".repeat(padding - padding / 2))
        if (plumbAt == null) plumbAt = width + padding / 2 + subtrees[below].plumbAt
      }
    }
    for (i in right) {
      row.append(subtrees[i].rows[r])
    }
    rows.add(row)
  }

  return PrintedSubtree(plumbAt!!, rows)
}

private data class PrintedSubtree(
  val plumbAt: Int = -1,
  val rows: MutableList<StringBuilder> = mutableListOf()
) {
  val width = rows.firstOrNull()?.length ?: 0

  var height: Int
    get() = rows.size
    set(value) {
      while (rows.size < value) {
        rows.add(StringBuilder(" ".repeat(width)))
      }
    }
}

private val PrintableNode.width: Int
  get() = content().length
```

## Unit tests

```kotlin linenums="1"
package com.example.tree

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

class TreePrinterTest {

  @Test
  fun leaf() {
    val root = TextNode("abc")
    assertThat(print(root)).isEqualTo("abc")
  }

  @Test
  fun singleLeftChild() {
    var root = TextNode("abc")
    root.children.add(TextNode("prq"))
    root.left = 0..<1
    assertThat(print(root)).isEqualTo(
      """
   abc
 ┌──┘
prq
    """.trimIndent()
    )

    root.content = "hello"
    root.children.first().content = "hola"
    assertThat(print(root)).isEqualTo(
      """
    hello
  ┌───┘
hola
    """.trimIndent()
    )

    root.content = "hola"
    root.children.first().content = "bonjour"
    assertThat(print(root)).isEqualTo(
      """
       hola
   ┌─────┘
bonjour
    """.trimIndent()
    )
  }

  @Test
  fun singleBelowChild() {
    val root = TextNode("abc")
    root.children.add(TextNode("pqr"))
    root.below = 0
    assertThat(print(root)).isEqualTo(
      """
abc
 |
pqr
    """.trimIndent()
    )

    root.content = "hi"
    root.children.first().content = "bonjour"
    assertThat(print(root)).isEqualTo(
      """
  hi
   |
bonjour
    """.trimIndent()
    )

    root.content = "bonjour"
    root.children.first().content = "hi"
    assertThat(print(root)).isEqualTo(
      """
bonjour
   |
  hi
    """.trimIndent()
    )
  }

  @Test
  fun singleRightChild() {
    val root = TextNode("abc")
    root.children.add(TextNode("pqr"))
    root.right = 0..<1
    assertThat(print(root)).isEqualTo(
      """
        abc
         └──┐
           pqr
    """.trimIndent()
    )

    root.content = "hi"
    root.children.first().content = "bonjour"
    assertThat(print(root)).isEqualTo(
      """
hi
 └───┐
  bonjour
    """.trimIndent()
    )

    root.content = "bonjour"
    root.children.first().content = "hi"
    assertThat(print(root)).isEqualTo(
      """
bonjour
   └────┐
       hi
    """.trimIndent()
    )
  }

  @Test
  fun leftChain3() {
    val root = TextNode("abc")
    root.children.add(TextNode("pqr"))
    root.left = 0..<1
    root.children.first().children.add(TextNode("xyz"))
    root.children.first().left = 0..<1
    assertThat(print(root)).isEqualTo(
      """
            abc
          ┌──┘
         pqr
       ┌──┘
      xyz
    """.trimIndent()
    )

    root.content = "bonjour"
    root.children.first().content = "hi"
    root.children.first().children.first().content = "hello"
    assertThat(print(root)).isEqualTo(
      """
       bonjour
      ┌───┘
     hi
  ┌───┘
hello
    """.trimIndent()
    )
  }

  @Test
  fun rightChain3() {
    val root = TextNode("abc")
    root.children.add(TextNode("pqr"))
    root.right = 0..<1
    root.children.first().children.add(TextNode("xyz"))
    root.children.first().right = 0..<1
    assertThat(print(root)).isEqualTo(
      """
      abc
       └──┐
         pqr
          └──┐
            xyz
    """.trimIndent()
    )

    root.content = "bonjour"
    root.children.first().content = "hi"
    root.children.first().children.first().content = "hello"
    assertThat(print(root)).isEqualTo(
      """
bonjour
   └────┐
       hi
        └──┐
         hello
    """.trimIndent()
    )
  }

  @Test
  fun belowChain3() {
    val root = TextNode("abc")
    root.children.add(TextNode("pqr"))
    root.below = 0
    root.children.first().children.add(TextNode("xyz"))
    root.children.first().below = 0
    assertThat(print(root)).isEqualTo(
      """
        abc
         |
        pqr
         |
        xyz
    """.trimIndent()
    )

    root.content = "bonjour"
    root.children.first().content = "hi"
    root.children.first().children.first().content = "hello"
    assertThat(print(root)).isEqualTo(
      """
bonjour
   |
  hi
   |
 hello
    """.trimIndent()
    )
  }

  @Test
  fun leftRightChildren() {
    val root = TextNode("hi")
    root.children.add(TextNode("hello"))
    root.children.add(TextNode("bonjour"))
    root.left = 0..<1
    root.right = 1..<2
    assertThat(print(root)).isEqualTo(
      """
     hi
  ┌───┴───┐
hello   bonjour
    """.trimIndent()
    )

    root.content = "bonjour"
    root.children.first().content = "hello"
    root.children.last().content = "hi"
    assertThat(print(root)).isEqualTo(
      """
     bonjour
  ┌─────┴────┐
hello        hi
    """.trimIndent()
    )

    root.content = "hello"
    root.children.first().content = "bonjour"
    root.children.last().content = "hi"
    assertThat(print(root)).isEqualTo(
      """
       hello
   ┌─────┴───┐
bonjour      hi
    """.trimIndent()
    )
  }

  @Test
  fun leftBelowChildren() {
    val root = TextNode("hi")
    root.children.add(TextNode("hello"))
    root.children.add(TextNode("bonjour"))
    root.left = 0..<1
    root.below = 1
    assertThat(print(root)).isEqualTo(
      """
       hi
  ┌─────┤
hello bonjour
    """.trimIndent()
    )

    root.content = "bonjour"
    root.children.first().content = "hi"
    root.children.last().content = "hello"
    assertThat(print(root)).isEqualTo(
      """
  bonjour
 ┌───┤
hi  hello
    """.trimIndent()
    )

    root.content = "hello"
    root.children.first().content = "bonjour"
    root.children.last().content = "hi"
    assertThat(print(root)).isEqualTo(
      """
       hello
   ┌─────┤
bonjour  hi
    """.trimIndent()
    )
  }

  @Test
  fun belowRightChildren() {
    val root = TextNode("hi")
    root.children.add(TextNode("hello"))
    root.children.add(TextNode("bonjour"))
    root.below = 0
    root.right = 1..<2
    assertThat(print(root)).isEqualTo(
      """
 hi
  ├─────┐
hello bonjour
    """.trimIndent()
    )

    root.content = "bonjour"
    root.children.first().content = "hi"
    root.children.last().content = "hello"
    assertThat(print(root)).isEqualTo(
      """
bonjour
   ├─────┐
  hi    hello
    """.trimIndent()
    )

    root.content = "hello"
    root.children.first().content = "bonjour"
    root.children.last().content = "hi"
    assertThat(print(root)).isEqualTo(
      """
 hello
   ├────┐
bonjour hi
    """.trimIndent()
    )
  }

  @Test
  fun firstChildWithOneChild() {
    val root = TextNode("root")
    root.children.add(TextNode("first"))
    root.children.add(TextNode("second"))
    root.children.add(TextNode("third"))
    root.left = 0..<1
    root.below = 1
    root.right = 2..<3
    root.children.first().children.add(TextNode("first-first"))
    root.children.first().left = 0..<1
    assertThat(print(root)).isEqualTo(
      """
                 root
             ┌─────┼────┐
           first second third
     ┌───────┘
first-first
    """.trimIndent()
    )

    root.left = IntRange.EMPTY
    root.below = 0
    root.right = 1..<3
    assertThat(print(root)).isEqualTo(
      """
           root
             ├─────┬────┐
           first second third
     ┌───────┘
first-first
    """.trimIndent()
    )

    root.below = null
    root.right = 0..<3
    assertThat(print(root)).isEqualTo(
      """
root
  └──────────────┬─────┬────┐
               first second third
         ┌───────┘
    first-first
    """.trimIndent()
    )
  }

  @Test
  fun firstChildThreeChild() {
    val root = TextNode("root")
    root.children.add(TextNode("first"))
    root.children.add(TextNode("second"))
    root.children.add(TextNode("third"))
    root.left = 0..<1
    root.below = 1
    root.right = 2..<3
    root.children.first().children.add(TextNode("first-first"))
    root.children.first().children.add(TextNode("first-second"))
    root.children.first().children.add(TextNode("first-third"))
    root.children.first().left = 0..<1
    root.children.first().below = 1
    root.children.first().right = 2..<3
    assertThat(print(root)).isEqualTo(
      """
                                     root
                 ┌─────────────────────┼────┐
               first                 second third
     ┌───────────┼──────────┐
first-first first-second first-third
    """.trimIndent()
    )

    root.children.first().left = IntRange.EMPTY
    root.children.first().below = 0
    root.children.first().right = 1..<3
    assertThat(print(root)).isEqualTo(
      """
                                     root
     ┌─────────────────────────────────┼────┐
   first                             second third
     ├───────────┬──────────┐
first-first first-second first-third
    """.trimIndent()
    )

    root.children.first().left = IntRange.EMPTY
    root.children.first().below = null
    root.children.first().right = 0..<3
    assertThat(print(root)).isEqualTo(
      """
                                          root
  ┌─────────────────────────────────────────┼────┐
first                                     second third
  └───────┬───────────┬──────────┐
     first-first first-second first-third
    """.trimIndent()
    )

    root.left = IntRange.EMPTY
    root.below = 0
    root.right = 1..<3
    assertThat(print(root)).isEqualTo(
      """
root
  ├─────────────────────────────────────────┬────┐
first                                     second third
  └───────┬───────────┬──────────┐
     first-first first-second first-third
    """.trimIndent()
    )

    root.left = IntRange.EMPTY
    root.below = null
    root.right = 0..<3
    assertThat(print(root)).isEqualTo(
      """
root
  └───┬─────────────────────────────────────────┬────┐
    first                                     second third
      └───────┬───────────┬──────────┐
         first-first first-second first-third
    """.trimIndent()
    )
  }

  @Test
  fun secondChildThreeChild() {
    val root = TextNode("root")
    root.children.add(TextNode("first"))
    root.children.add(TextNode("second"))
    root.children.add(TextNode("third"))
    root.left = 0..<1
    root.below = 1
    root.right = 2..<3
    root.children[1].children.add(TextNode("second-first"))
    root.children[1].children.add(TextNode("second-second"))
    root.children[1].children.add(TextNode("second-third"))
    root.children[1].left = 0..<1
    root.children[1].below = 1
    root.children[1].right = 2..<3
    assertThat(print(root)).isEqualTo(
      """
                     root
  ┌────────────────────┼──────────────────────┐
first                second                   third
           ┌───────────┼────────────┐
     second-first second-second second-third
    """.trimIndent()
    )

    root.children[1].left = IntRange.EMPTY
    root.children[1].below = 0
    root.children[1].right = 1..<3
    assertThat(print(root)).isEqualTo(
      """
         root
  ┌────────┼──────────────────────────────────┐
first    second                               third
           ├───────────┬────────────┐
     second-first second-second second-third
    """.trimIndent()
    )

    root.children[1].left = IntRange.EMPTY
    root.children[1].below = null
    root.children[1].right = 0..<3
    assertThat(print(root)).isEqualTo(
      """
      root
  ┌─────┼───────────────────────────────────────────┐
first second                                        third
        └────────┬───────────┬────────────┐
           second-first second-second second-third
    """.trimIndent()
    )

    root.children[1].left = 0..<1
    root.children[1].below = null
    root.children[1].right = 1..<3
    assertThat(print(root)).isEqualTo(
      """
                  root
  ┌─────────────────┼───────────────────────────────┐
first             second                            third
           ┌────────┴────────┬────────────┐
     second-first       second-second second-third
    """.trimIndent()
    )

    root.left = IntRange.EMPTY
    root.below = 0
    root.right = 1..<3
    assertThat(print(root)).isEqualTo(
      """
root
  ├─────────────────┬───────────────────────────────┐
first             second                            third
           ┌────────┴────────┬────────────┐
     second-first       second-second second-third
    """.trimIndent()
    )

    root.left = IntRange.EMPTY
    root.below = null
    root.right = 0..<3
    assertThat(print(root)).isEqualTo(
      """
root
  └───┬─────────────────┬───────────────────────────────┐
    first             second                            third
               ┌────────┴────────┬────────────┐
         second-first       second-second second-third
    """.trimIndent()
    )
  }

  @Test
  fun edgar_allan_poe() {
    val root = TextNode("Once_upon_a_midnight_dreary")
    root.children.add(TextNode("while_I_pondered"))
    root.children.add(TextNode("weak_and_weary"))
    root.left = 0..<1
    root.below = null
    root.right = 1..<2
    root.children.first().children.add(TextNode("Over_many_a_quaint"))
    root.children.first().children.add(TextNode("and"))
    root.children.first().children.add(TextNode("curious_volume"))
    root.children.first().left = 0..<1
    root.children.first().below = 1
    root.children.first().right = 2..<3
    root.children.last().children.add(TextNode("of_forgotten_lore"))
    root.children.last().children.add(TextNode("While_I_nodded"))
    root.children.last().left = IntRange.EMPTY
    root.children.last().below = null
    root.children.last().right = 0..<2
    assertThat(print(root)).isEqualTo("""
                                                  Once_upon_a_midnight_dreary
                         ┌─────────────────────────────────────┴────────────────────┐
                 while_I_pondered                                             weak_and_weary
         ┌───────────────┼───────────────┐                                           └──────────────┬───────────────┐
Over_many_a_quaint       and        curious_volume                                          of_forgotten_lore While_I_nodded
    """.trimIndent())
  }

}

class TextNode(
  var content: String = "",
  val children: MutableList<TextNode> = mutableListOf(),
  var left: IntRange = IntRange.EMPTY,
  var below: Int? = null,
  var right: IntRange = IntRange.EMPTY,
) : PrintableNode {
  override fun content(): String = content

  override fun children(): List<PrintableNode> = children

  override fun left(): IntRange = left

  override fun below(): Int? = below

  override fun right(): IntRange = right
}
```
