# Find the shortest path in a maze

## Description

Given a maze in the form of a matrix, filled with $0s$ and $1s$, find the longest path length between specific cells. You can only move in $4$ possible directions:

- top: $(r, c) \rightarrow (r-1, c)$
- bottom: $(r, c) \rightarrow (r+1, c)$
- left: $(r, c) \rightarrow (r, c-1)$
- left: $(r, c) \rightarrow (r, c+1)$

This is identical to [previous problem](04-find-shortest-path-in-maze.md).

## Example

Longest path between $(0, 0)$ to $(7, 5)$.

$(0, 0) \rightarrow (0, 1) \rightarrow (0, 2) \rightarrow (0, 3) \rightarrow (0, 4) \rightarrow (1, 4) \rightarrow (1, 3) \rightarrow$

$(1, 2) \rightarrow (2, 2) \rightarrow (3, 2) \rightarrow (3, 3) \rightarrow (3, 4) \rightarrow (2, 4) \rightarrow (2, 5) \rightarrow$

$(2, 6) \rightarrow (3, 6) \rightarrow (3, 7) \rightarrow (4, 7) \rightarrow (5, 7) \rightarrow (6, 7) \rightarrow (7, 7) \rightarrow$

$(7, 6) \rightarrow (7, 5)$

<pre>
1  1  1  1  1  0  0  1  1  1
0  1  1  1  1  1  0  1  0  1
0  0  1  0  1  1  1  0  0  1
1  0  1  1  1  0  1  1  0  1
0  0  0  1  0  0  0  1  0  1
1  0  1  1  1  0  0  1  1  0
0  0  0  0  1  0  0  1  0  1
0  1  1  1  1  1  1  1  0  0
1  1  1  1  1  0  0  1  1  1
0  0  1  0  0  1  1  0  0  1
</pre>

## Stub

```kotlin linenums="1"
fun main() {
  val board: Array<IntArray> = arrayOf(
    intArrayOf(1, 1, 1, 1, 1, 0, 0, 1, 1, 1),
    intArrayOf(0, 1, 1, 1, 1, 1, 0, 1, 0, 1),
    intArrayOf(0, 0, 1, 0, 1, 1, 1, 0, 0, 1),
    intArrayOf(1, 0, 1, 1, 1, 0, 1, 1, 0, 1),
    intArrayOf(0, 0, 0, 1, 0, 0, 0, 1, 0, 1),
    intArrayOf(1, 0, 1, 1, 1, 0, 0, 1, 1, 0),
    intArrayOf(0, 0, 0, 0, 1, 0, 0, 1, 0, 1),
    intArrayOf(0, 1, 1, 1, 1, 1, 1, 1, 0, 0),
    intArrayOf(1, 1, 1, 1, 1, 0, 0, 1, 1, 1),
    intArrayOf(0, 0, 1, 0, 0, 1, 1, 0, 0, 1),
  )
  println(longestPath(board, Cell(0, 0), Cell(7, 5)))
}

data class Cell(val row: Int, val col: Int) {
  override fun toString(): String {
    return "($row, $col)"
  }
}

fun longestPath(board: Array<IntArray>, src: Cell, dest: Cell): List<Cell> {
  /* Fill code here. */
}
```

## Solution

??? "Expand"

    Just change one condition, and it's same as previous problem's solution.

    ```kotlin linenums="1"
    fun longestPath(board: Array<IntArray>, src: Cell, dest: Cell): List<Cell> {
      return helper(board, src, dest, mutableListOf()) ?: listOf()
    }

    fun helper(board: Array<IntArray>, node: Cell, dest: Cell, path: MutableList<Cell>): List<Cell>? {
      path.add(node)
      if (node == dest) {
        path.removeLast()
        return path.toList() + node
      }
      path.add(node)

      var longestPath: List<Cell>? = null
      var longestPathLength = Int.MIN_VALUE

      val unvisitedNeighbours = board.neighbours(node).filter { it !in path }
      for (neighbour in unvisitedNeighbours) {
        val candidate = helper(board, neighbour, dest, path)
        if (candidate != null && candidate.size > longestPathLength) {
          longestPath = candidate
          longestPathLength = candidate.size
        }
      }

      path.removeLast()
      return longestPath
    }

    val Cell.top: Cell
      get() = Cell(row - 1, col)

    val Cell.bottom: Cell
      get() = Cell(row + 1, col)

    val Cell.left: Cell
      get() = Cell(row, col - 1)

    val Cell.right: Cell
      get() = Cell(row, col + 1)

    fun Array<IntArray>.neighbours(cell: Cell): Stream<Cell> {
      return Stream.of(
        cell.left, cell.right, cell.top, cell.bottom,
      ).filter { it.row in 0..<size }
        .filter { it.col in 0..<size }
        .filter { this[it.row][it.col] == 1 }
    }
    ```
