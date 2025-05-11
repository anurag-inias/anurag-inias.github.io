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

## Pseudocode

$\ \ \ \ \ \ \ \ \underline{\text{GenericSearch}()}$ <br>
${\small \ \ 1} \ \ \ \ \ \text{mark all vertices as unexplored}$ <br>
${\small \ \ 2} \ \ \ \ \ \textbf{for }s \in V \textbf{ do}$ <br>
${\small \ \ 3} \ \ \ \ \ \ \ \ \ \ \ \textbf{if }s \text{ is unexplored}\textbf{ then}$ <br>
${\small \ \ 4} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \text{search}(s)$ <br>
${\small \ \ 5}$ <br>
${\small \ \ 6} \ \ \ \ \ \underline{\text{search}(s)}$ <br>
${\small \ \ 7} \ \ \ \ \ \text{mark }s\text{ as explored}$ <br>
${\small \ \ 9} \ \ \ \ \ \textbf{while } \text{there is an edge } (u, v) \in E \text{ with } u \text{ explored and } v \text{ unexplored} \textbf{ do}$ <br>
${\small 10} \ \ \ \ \ \ \ \ \ \ \ \text{choose some such edge }(u, v) \ \ \ \ {\small\text{// unspecified}}$ <br>
${\small 11} \ \ \ \ \ \ \ \ \ \ \ \text{mark }v\text{ as explored}$ <br>

## Variants

By giving an order to edges to process at line number $10$ we get different concrete implementations of the generic search algorithm:

1.  BFS: use a $\text{queue}$ to pick edges in first come first serve (LIFO) order.

2.  DFS: use a $\text{stack}$ to pick edges in last come first serve (FIFO) order.

3.  Priority queue: this is basically a family of algorithm on its own.

    - Edge weights as priority gives an algorithm for discovering Minimum spanning tree, roughly Prim's algorithm.

    - Vertex distance as priority gives shortest-path algorithm in weighted graphs, roughly Dijkstra's algorithm.
