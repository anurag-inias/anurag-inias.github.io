# Find number of unique paths in a maze

## Description

Given a maze in the form of a matrix, filled with $0s$ and $1s$, find all unique paths between given source and destination. You can only move in $4$ possible directions:

- top: $(r, c) \rightarrow (r-1, c)$
- bottom: $(r, c) \rightarrow (r+1, c)$
- left: $(r, c) \rightarrow (r, c-1)$
- left: $(r, c) \rightarrow (r, c+1)$

## Example

Four unique paths exist between $(0, 0)$ and $(3, 3)$.

```
1  1  1  1
1  1  0  1
0  1  0  1
1  1  1  1
```

- $(0, 0) \rightarrow (0, 1) \rightarrow (0, 2) \rightarrow (0, 3) \rightarrow (1, 3) \rightarrow (2, 3) \rightarrow (3, 3)$
- $(0, 0) \rightarrow (0, 1) \rightarrow (1, 1) \rightarrow (2, 1) \rightarrow (3, 1) \rightarrow (3, 2) \rightarrow (3, 3)$
- $(0, 0) \rightarrow (1, 0) \rightarrow (1, 1) \rightarrow (2, 1) \rightarrow (3, 1) \rightarrow (3, 2) \rightarrow (3, 3)$
- $(0, 0) \rightarrow (1, 0) \rightarrow (1, 1) \rightarrow (0, 1) \rightarrow (0, 2) \rightarrow (0, 3) \rightarrow (1, 3) \rightarrow (2, 3) \rightarrow (3, 3)$

## Stub

```kotlin linenums="1"
fun main() {
  val board: Array<IntArray> = arrayOf(
    intArrayOf(1, 1, 1, 1),
    intArrayOf(1, 1, 0, 1),
    intArrayOf(0, 1, 0, 1),
    intArrayOf(1, 1, 1, 1),
  )
  distinctPaths(board,Cell(0, 0), Cell(3, 3))
}

data class Cell(val row: Int, val col: Int) {
  override fun toString(): String {
    return "($row, $col)"
  }
}

fun distinctPaths(board: Array<IntArray>, src: Cell, dst: Cell) {
  /* Fill here. */
}
```

## Solution

??? "Expand"

    ```kotlin linenums="1"
    fun distinctPaths(board: Array<IntArray>, src: Cell, dst: Cell) {
      helper(board, src, dst, mutableListOf())
    }

    fun helper(board: Array<IntArray>, node: Cell, dst: Cell, path: MutableList<Cell>) {
      path.add(node)
      if (node == dst) {
        println(path)
        path.removeLast()
        return
      }

      val unvisitedNeighbours = board.neighbours(node).filter { it !in path }
      for (neighbour in unvisitedNeighbours) {
        helper(board, neighbour, dst, path)
      }

      path.removeLast()
    }
    ```
