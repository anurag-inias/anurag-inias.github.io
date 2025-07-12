# Kruskal's algorithm

<style>
.md-logo img {
  content: url('/data-structures/graph/network-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/graph/network-dark.svg');
}
</style>

# About

Kruskal's algorithm is a greedy algorithm to find MST of a given graph.

## Pseudocode

$\ \ \ \ \ \ \ \ \underline{\text{Kruskal}(G)}$ <br>
${\small \ \ 1} \ \ \ \ \ M = \phi$ <br>
${\small \ \ 2} \ \ \ \ \ \textbf{for }v \in V \textbf{ do}$ <br>
${\small \ \ 3} \ \ \ \ \ \ \ \ \ \ \ add(v)$ <br>
${\small \ \ 4}$ <br>
${\small \ \ 5} \ \ \ \ \ Q = \{ (u, v) \ | \ (u, v) \in G.E \text{ order by ascending } w \}$ <br>
${\small \ \ 6} \ \ \ \ \ \textbf{for }(u, v) \in Q \textbf{ do}$ <br>
${\small \ \ 7} \ \ \ \ \ \ \ \ \ \ \ \textbf{if }\text{find}(u) \ne \text{find}(v) \textbf{ do}$ <br>
${\small \ \ 8} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \text{join}(u, v)$ <br>
${\small 9} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ M = M \cup (u, v)$ <br>
${\small 10}$ <br>
${\small 11} \ \ \ \ \ \textbf{return }M$ <br>

## Running time

$O(E \log V)$

## Concrete implementation

=== "Kruskal's Algorithm"

    ```kotlin linenums="1"
    fun kruskal(graph: Graph): List<Edge> {
      val ds = DisjointSet()
      for (vertex in graph.vertices) {
        ds.add(vertex)
      }

      val out = mutableListOf<Edge>()
      for (e in sortedEdges(graph)) {
        val (u, v, _) = e
        if (ds.find(u) != ds.find(v)) {
          ds.join(u, v)
          out.add(e)
        }
      }

      println(out.sumOf { it.weight })
      return out
    }
    ```

=== "Graph setup"

    ```kotlin linenums="1"
    // Data class for holding weight of an edge.
    data class Neighbour(val dst: Int, val weight: Int)

    class Graph {
      private val adjacency: MutableMap<Int, MutableList<Neighbour>> = HashMap()

      val vertices: List<Int>
        get() = adjacency.keys.stream().toList()

      fun neighbours(vertex: Int): List<Neighbour> = adjacency[vertex] ?: listOf()

      fun add(vararg vertices: Int): Graph {
        for (v in vertices)
          adjacency.putIfAbsent(v, ArrayList())
        return this
      }

      fun connect(src: Int, dst: Int, weight: Int): Graph {
        add(src, dst)
        if (src == dst) return this   // disallow self-loops.

        adjacency[src]?.add(Neighbour(dst, weight))
        adjacency[dst]?.add(Neighbour(src, weight))

        return this
      }
    }
    ```

=== "Disjoint setup"

    ```kotlin linenums="1"
    class DisjointSet {

      private val parent = HashMap<Int, Int>()
      private val size = HashMap<Int, Int>()

      fun add(node: Int): Boolean {
        if (node !in parent) {
          parent[node] = node
          size[node] = 1
          return true
        }
        return false
      }

      fun find(node: Int): Int? {
        // Node must be added prior to this.
        val p = parent[node] ?: return null

        if (p == node) return node
        parent[node] = find(p)!! // compression
        return parent[node]
      }

      fun join(bigger: Int, smaller: Int) {
        // Both nodes must be added prior to this.
        val parentBigger = find(bigger) ?: return
        val parentSmaller = find(smaller) ?: return

        when {
          parentBigger == parentSmaller -> return
          size[parentBigger]!! < size[parentSmaller]!! -> join(smaller, bigger)
          else -> { // merge by size.
            parent[parentSmaller] = parentBigger
            size[parentBigger] = size[parentBigger]!! + size[parentSmaller]!!
          }
        }
      }
    }
    ```

=== "Sort edges by weight"

    ```kotlin linenums="1"
    // Returns the list of all edges in ascending order of weight.
    fun sortedEdges(graph: Graph): List<Edge> {
      val edgeSet = mutableSetOf<Edge>()
      for (vertex in graph.vertices) {
        for ((neighbour, weight) in graph.neighbours(vertex)) {
          edgeSet.add(Edge(vertex, neighbour, weight))
        }
      }
      return edgeSet.toList().sortedBy { it.weight }
    }

    // Represents a weighted undirected edge.
    data class Edge(val first: Int, val second: Int, val weight: Int) {
      override fun toString(): String {
        return "($first, $second)"
      }

      override fun equals(other: Any?): Boolean {
        if (other === null) return false
        if (other === this) return true
        if (other !is Edge) return false
        if (weight != other.weight) return false
        if (first == other.first) return second == other.second
        if (first == other.second) return second == other.first
        return false
      }

      override fun hashCode(): Int {
        return 31 * weight + first * second
      }
    }
    ```

=== "Set up example graph"

    ```kotlin linenums="1"
    fun main() {
      val graph = Graph()
        .connect(1, 2, 5)
        .connect(1, 3, 6)
        .connect(1, 4, 4)
        .connect(2, 3, 1)
        .connect(2, 4, 2)
        .connect(3, 4, 2)
        .connect(3, 5, 5)
        .connect(3, 6, 3)
        .connect(4, 6, 4)
        .connect(5, 6, 4)
      println(kruskal(graph))
    }
    ```

## Example Run

<div markdown class="grid">

![](/data-structures/graph/minimum-spanning-tree/example-graph.png){width=250}

![](/data-structures/graph/minimum-spanning-tree/example-mst.png){width=250}

$\text{Graph }G$

$\text{Minimum Spanning Tree }T$

</div>

MST has the edges $(2, 3), (2, 4), (3, 6), (1, 4), (5, 6)$, summing up to $14$.
