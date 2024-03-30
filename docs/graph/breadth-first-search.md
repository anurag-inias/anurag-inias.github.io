# Breadth-first Search

## About

BFS explores the vertices of a graph in layers, each layer corresponding to increasing distance from the source. First layer discovers vertices neighbouring to the _source_, second layer discovers neighbours of the first layer and so on.

It has a running time of \\(O(V+E)\\).

## Implementation

<div class="grid" markdown>

```ruby title="Pseudocode" hl_lines="2 6 7"
Q = stack.push(u)
mark u as visited
while Q is not empty:
  v = Q.poll()
  for each edge (v, w):
    if w is not visted:
      mark w as visited
      Q.push(w)
```

```kotlin title="Kotlin" linenums="1"
fun bfs(graph: Graph, source: Vertex) {
  val visited = HashSet<Vertex>()
  val queue = ArrayList<Vertex>()

  queue.add(source)
  visited.add(source)

  while (queue.isNotEmpty()) {
    val u = queue.removeFirst()
    print("$u ")

    for (v in graph.neighbours(u))
      if (!visited.contains(v)) {
        visited.add(v)
        queue.add(v)
      }
  }
}
```

</div>

Pay attention to the fact that we mark vertices `visited` before enqueuing them.

## Properties

- BFS gives the shortest path in an unweighted graph, since in an unweighted graph, the shortest path is just the least number of hops.
- Consequently, it also gives the minimum spanning tree in an unweighted graph. Any spanning tree would be minimum spanning tree in an unweighted graph, so both BFS and DFS would work. 

