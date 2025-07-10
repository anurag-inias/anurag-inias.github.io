# Find the shortest path in a maze

## Description

Given a maze in the form of a matrix, filled with $0s$ and $1s$, find the shortest path length between specific cells. You can only move in $4$ possible directions:

- top: $(r, c) \rightarrow (r-1, c)$
- bottom: $(r, c) \rightarrow (r+1, c)$
- left: $(r, c) \rightarrow (r, c-1)$
- left: $(r, c) \rightarrow (r, c+1)$

## Example

Shortest path between $(0, 0)$ to $(7, 5)$.

<style>
.highlight {
  font-weight: bold;
  background: #fdff32;
}
</style>

<pre>
<span class="highlight">1</span>  <span class="highlight">1</span>  <span class="highlight">1</span>  1  1  0  0  1  1  1
0  1  <span class="highlight">1</span>  1  1  1  0  1  0  1
0  0  <span class="highlight">1</span>  0  1  1  1  0  0  1
1  0  <span class="highlight">1</span>  <span class="highlight">1</span>  1  0  1  1  0  1
0  0  0  <span class="highlight">1</span>  0  0  0  1  0  1
1  0  1  <span class="highlight">1</span>  <span class="highlight">1</span>  0  0  1  1  0
0  0  0  0  <span class="highlight">1</span>  0  0  1  0  1
0  1  1  1  <span class="highlight">1</span>  <span class="highlight">1</span>  1  1  0  0
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
  println(shortestPath(board, Cell(0, 0), Cell(7, 5)))
}

data class Cell(val row: Int, val col: Int) {
  override fun toString(): String {
    return "($row, $col)"
  }
}

fun shortestPath(board: Array<IntArray>, src: Cell, dest: Cell): List<Cell> {
  /* Fill code here. */
}
```

## Solution

??? "Approach 1"

    We can backtrack to find all possible path, and pick the shortest path.

    ```kotlin linenums="1"
    fun shortestPath(board: Array<IntArray>, src: Cell, dest: Cell): List<Cell> {
      return helper(board, src, dest, mutableListOf()) ?: listOf()
    }

    fun helper(board: Array<IntArray>, node: Cell, dest: Cell, path: MutableList<Cell>): List<Cell>? {
      if (node == dest) {
        return path.toList()
      }
      path.add(node)

      var shortestPath: List<Cell>? = null
      var shortestPathLength = Int.MAX_VALUE

      val unvisitedNeighbours = board.neighbours(node).filter { it !in path }
      for (neighbour in unvisitedNeighbours) {
        val candidate = helper(board, neighbour, dest, path)
        if (candidate != null && candidate.size < shortestPathLength) {
          shortestPath = candidate
          shortestPathLength = candidate.size
        }
      }

      path.removeLast()
      return shortestPath
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

??? "Approach 2"

    Notice that this is essentially a unweighted graph. And we know BFS in an unweighted graph gives us shortest path.

    ```kotlin linenums="1"
    fun shortestPath(board: Array<IntArray>, src: Cell, dst: Cell): List<Cell> {
      val pred = mutableMapOf(src to src) // also acts as "seen"
      val queue = mutableListOf(src)

      while (queue.isNotEmpty() && dst !in pred) {
        val node = queue.removeFirst()
        for (neighbour in board.neighbours(node)) {
          if (neighbour in pred) continue
          queue += neighbour
          pred[neighbour] = node

          if (neighbour == dst) break // found it
        }
      }

      var cursor = dst
      val path = mutableListOf<Cell>()
      while (pred[cursor] != cursor) {
        path.add(0, cursor)
        cursor = pred[cursor]!!
      }
      return path
    }
    ```
