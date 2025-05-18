# Dijkstra's Algorithm

<style>
.md-logo img {
  content: url('/data-structures/graph/network-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/graph/network-dark.svg');
}
</style>

## About

Dijkstra's algorithm solves the single-source shortest path problem with only non-negative edge weights.

## Problem

Given a directed graph $G = (V, E),$ a starting vertex $s \in V,$ and a non-negative length for each edge $e \in E$, find the shortest distance $d$ of each vertex from $s$.
