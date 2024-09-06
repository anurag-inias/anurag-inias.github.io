# Generic graph search

<style>
.md-logo img {
  content: url('/data-structures/graph/network-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/graph/network-dark.svg');
}
</style>

## About

The algorithms we explore later are all specialiazation of this generic search algorithm.

## Pseudo-code

```ruby title="GenericSearch(G, s)" linenums="1"
bag.add(s)
while bag is not empty:
  u = bag.remove()
  if u is not visited:
    mark u visited
    for (u, v) in G:
      bag.add(v)
```

where *bag* is a placeholder ADT.

## Variants

1. Stack: using a stack as "bag" gives us DFS. This spits out a depth-first spanning tree, which in general is going to be thin and deep.
2. Queue: this gives us BFS. The spanning tree from this will be wide and shallow.
3. Priority queue: this is basically a family of algorithm on its own.
     - Edge weights as priority gives an algorithm for discovering Minimum spanning tree, roughly Prim's algorithm.
     - Vertex distance as priority gives shortest-path algorithm in weighted graphs, roughly Dijkstra's algorithm.
