# Depth-first Search

<style>
.md-logo img {
  content: url('/data-structures/graph/network-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/graph/network-dark.svg');
}
.deleted {
  background-color: #faafa8;
  display: inline-block;
  width: 100%;
}
:root [data-md-color-scheme=slate] .deleted {
  background-color: #77172e;
}
.elevated {
  background-color: #d4e4ed;
  display: inline-block;
  width: 100%;
}
.elevation-target {
  display: inline-block;
  border-bottom: 1px #d4e4ed solid;
  width: 100%;
}
:root [data-md-color-scheme=slate] .elevated {
  background-color: #256377;
}
:root [data-md-color-scheme=slate] .elevation-target {
  border-bottom: 1px #256377 solid;
}
.box {
  display: inline-block;
  width: 12px;
  height: 12px;
  margin-bottom: -2px;
}

</style>

## Intro

<div class="grid" markdown>

It's helpful to consider DFS in contrast to its sibling BFS. Where BFS is the cautious approach, clearing up the graph layer-by-layer, DFS is the head-first adventure in the maze. <br> <br> BFS is akin to a group of people exploring a maze, splitting off into subgroups at each intersection. Whereas DFS is like a lone explorer uncovering a maze.

![](dfs.gif){ loading=lazy }

</div>

## Pseudocode

<div class="grid" markdown>

<div markdown>
$\ \ \ \ \ \ \ \text{Recursive } \underline{\text{DFS}()}$ <br>
${\small \ \ 1} \ \ \ \ \ \text{mark all vertices as unexplored}$ <br>
${\small \ \ 2} \ \ \ \ \ \textbf{for }s \in V \textbf{ do}$ <br>
${\small \ \ 3} \ \ \ \ \ \ \ \ \ \ \ \textbf{if }s \text{ is unexplored}\textbf{ then}$ <br>
${\small \ \ 4} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \text{dfs}(s)$ <br>
${\small \ \ 5}$ <br>
${\small \ \ 6} \ \ \ \ \ \underline{\text{dfs}(s)}$ <br>
${\small \ \ 7} \ \ \ \ \ \text{mark }s \text{ as explored}$ <br>
${\small \ \ 8} \ \ \ \ \ \textbf{for }\text{each edge }(s, u) \in E\textbf{ do}$ <br>
${\small \ \ 9} \ \ \ \ \ \ \ \ \ \ \ \textbf{if }u \text{ is unexplored}\textbf{ then}$ <br>
${\small 10} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \text{DFS}(u)$

</div>

<div markdown>
$\ \ \ \ \ \ \ \ \text{Iterative } \underline{\text{DFS}()}$ <br>
${\small \ \ 1} \ \ \ \ \ \text{mark all vertices as unexplored}$ <br>
${\small \ \ 2} \ \ \ \ \ \textbf{for }s \in V \textbf{ do}$ <br>
${\small \ \ 3} \ \ \ \ \ \ \ \ \ \ \ \textbf{if }s \text{ is unexplored}\textbf{ then}$ <br>
${\small \ \ 4} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \text{dfs}(s)$ <br>
${\small \ \ 5}$ <br>
${\small \ \ 6} \ \ \ \ \ \underline{\text{dfs}(s)}$ <br>
${\small \ \ 7} \ \ \ \ \ S := \{s\}$ <br>
${\small \ \ 8} \ \ \ \ \ \textbf{while } S \text{ is not empty} \textbf{ do}$ <br>
${\small \ \ 9} \ \ \ \ \ \ \ \ \ \ \ v := S.\text{poll()}$ <br>
${\small 10} \ \ \ \ \ \ \ \ \ \ \ \textbf{if }w \text{ is unexplored }\textbf{ then}$  <br>
${\small 11} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \text{mark }w\text{ as explored}$
${\small 12} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \textbf{for }\text{each edge }(v, w) \in E\textbf{ do}$ <br>
${\small 13} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ S.\text{offer}(w)$ <br>

</div>

<div markdown>

### Difference from BFS

<span class="box" style="background-color: #faafa8;"></span> are deleted lines. <span class="box" style="background-color: #d4e4ed;"></span> are shifted lines.

</div>

<span/>

<div markdown>
$\ \ \ \ \ \ \ \underline{\text{bfs}(s)}$ <br>
<span class="deleted">${\small 1} \ \ \ \ \ \text{mark }s\text{ as explored}$</span> <br>
${\small 2} \ \ \ \ \ Q := \{s\}$ <br>
${\small 3} \ \ \ \ \ \text{while } Q \text{ is not empty} \text{ do}$ <br>
<span class="elevation-target">${\small 4} \ \ \ \ \ \ \ \ \ \ \ v := Q.\text{poll()}$ </span> <br>
${\small 5} \ \ \ \ \ \ \ \ \ \ \ \text{for }\text{each edge }(v, w) \in E\text{ do} \ \ \ \ \ \ \ \ \ \uparrow$ <br>
<span class="elevated">${\small 6} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \text{if }w \text{ is unexplored }\text{ then}$ </span> <br>
<span class="elevated">${\small 7} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \text{mark }w\text{ as explored}$ </span> <br>
${\small 8} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Q.\text{offer}(w) \ \ {\Tiny\text{// has pre-check}}$<br>
</div>

<div markdown>
$\ \ \ \ \ \ \ \underline{\text{dfs}(s)}$ <br>
${\small 1}$<br>
${\small 2} \ \ \ \ \ S := \{s\}$ <br>
${\small 3} \ \ \ \ \ \textbf{while } S \text{ is not empty} \textbf{ do}$ <br>
${\small 4} \ \ \ \ \ \ \ \ \ \ \ v := S.\text{pop()} \ \ {\Tiny\text{// has post-check}}$ <br>
<span class="elevated">${\small 5} \ \ \ \ \ \ \ \ \ \ \ \textbf{if }w \text{ is unexplored }\textbf{ then}$ </span> <br>
<span class="elevated">${\small 6} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \text{mark }w\text{ as explored}$ </span>
${\small 7} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \textbf{for }\text{each edge }(v, w) \in E\textbf{ do}$ <br>
${\small 8} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ S.\text{push}(w)$ <br>

</div>

<div markdown>
1. Uses a $\text{queue}$ as the $\text{bag}$.
2. Checks if a vertex is $\text{explored}$ before bagging it.
3. Consequently, $Q$ always has $\text{explored}$ vertices.
</div>

<div markdown>
1. Uses a $\textbf{stack}$ as the $\text{bag}$.
2. Checks if a vertex is $\text{explored}$ **after unbagging** it.
3. Consequently, $s$ should not be marked $\text{explored}$ at the start of the subroutine.
</div>

</div>

### Why postpone $\text{explored}$ check?

<div class="grid" markdown>

If we just replace queue with stack in BFS, that would not be enough for it to be DFS. `DFS(G, 2)` would spit out `2, 3, 1, 4`. The strategy of "carry on" exploring a path gets disrupted when the next vertex on said path is already marked visited.

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 244.9398193359375 242.1428985595703" height="200">
  <g transform="translate(90.00009155273438 10) rotate(0 2.7099990844726562 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(87.71862030029297 85.642822265625) rotate(0 7.1199951171875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(48.147178649902344 149.2142791748047) rotate(0 6.80999755859375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(135.04721069335938 147.78565979003906) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round"><g transform="translate(70.00006103515625 161.29702530418444) rotate(0 28.571456909179688 -0.6864076853945562)"><path d="M0 0 C9.52 -0.23, 47.62 -1.14, 57.14 -1.37 M0 0 C9.52 -0.23, 47.62 -1.14, 57.14 -1.37" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(86.57144165039062 105.2138667785772) rotate(0 -13.32079926665432 18.393089498894994)"><path d="M0 0 C-4.44 6.13, -22.2 30.66, -26.64 36.79 M0 0 C-4.44 6.13, -22.2 30.66, -26.64 36.79" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(104.28573608398438 105.67627072040335) rotate(0 15.850694695968343 19.018988968411605)"><path d="M0 0 C5.28 6.34, 26.42 31.7, 31.7 38.04 M0 0 C5.28 6.34, 26.42 31.7, 31.7 38.04" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(93.18247074756766 38.571441650390625) rotate(0 -0.3302059878339776 20.285690307617188)"><path d="M0 0 C-0.11 6.76, -0.55 33.81, -0.66 40.57 M0 0 C-0.11 6.76, -0.55 33.81, -0.66 40.57" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(73.42868041992188 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M0 0 C-6.76 8.95, -33.81 44.76, -40.57 53.71 M0 0 C-6.76 8.95, -33.81 44.76, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(73.42868041992188 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M-33.24 29.81 C-36.11 39.18, -38.99 48.55, -40.57 53.71 M-33.24 29.81 C-34.9 35.23, -36.56 40.64, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(73.42868041992188 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M-19.59 40.12 C-27.81 45.45, -36.04 50.78, -40.57 53.71 M-19.59 40.12 C-24.34 43.2, -29.09 46.28, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g mask="url(#mask-zK9cLogAqVV9WaNBeScmd)" stroke-linecap="round"><g transform="translate(55.142913818359375 184.85719299316406) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M0 0 C15.05 -0.1, 75.24 -0.48, 90.29 -0.57" stroke="#e03131" stroke-width="2.5" fill="none" stroke-dasharray="1.5 8"></path></g><g transform="translate(55.142913818359375 184.85719299316406) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M66.85 8.13 C71.84 6.27, 76.84 4.42, 90.29 -0.57" stroke="#e03131" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g><g transform="translate(55.142913818359375 184.85719299316406) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M66.74 -8.97 C71.76 -7.18, 76.77 -5.39, 90.29 -0.57" stroke="#e03131" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g></g><mask id="mask-zK9cLogAqVV9WaNBeScmd"><rect x="0" y="0" fill="#fff" width="245.42868041992188" height="285.4286346435547"></rect><rect x="94.66580200195312" y="172.07147216796875" fill="#000" width="11.239990234375" height="25" opacity="1"></rect></mask><g transform="translate(94.66580200195312 172.07147216796875) rotate(0 5.6199951171875 12.5)"><text x="5.6199951171875" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">x</text></g><g transform="translate(10 207.1428985595703) rotate(0 112.46990966796875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Did not "push onwards"</text></g></svg>

The right approach then is to postpone marking vertices visited. This gives us the right result `2, 3, 4, 1`. Let vertices be pushed to the stack multiple times; _visit_ them from the most recently traversed edge.

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 140.2090110596016 194.8088534473485" height="160">
  <g transform="translate(67.1429443359375 10) rotate(0 2.7099990844726562 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(64.8614730834961 85.642822265625) rotate(0 7.1199951171875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(25.29003143310547 149.2142791748047) rotate(0 6.80999755859375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(112.1900634765625 147.78565979003906) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round"><g transform="translate(47.14291381835943 161.29454441711863) rotate(0 28.57145690917966 -0.6854106107120685)"><path d="M0 0 C9.52 -0.23, 47.62 -1.14, 57.14 -1.37 M0 0 C9.52 -0.23, 47.62 -1.14, 57.14 -1.37" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(63.71429443359375 105.19053641329424) rotate(0 -13.322925765192053 18.404754681536474)"><path d="M0 0 C-4.44 6.13, -22.2 30.67, -26.65 36.81 M0 0 C-4.44 6.13, -22.2 30.67, -26.65 36.81" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(81.4285888671875 105.65413369214286) rotate(0 15.852669093809425 19.03005748254185)"><path d="M0 0 C5.28 6.34, 26.42 31.72, 31.71 38.06 M0 0 C5.28 6.34, 26.42 31.72, 31.71 38.06" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(70.35662956109286 38.571441650390625) rotate(0 -0.34173385564980663 20.285690307617188)"><path d="M0 0 C-0.11 6.76, -0.57 33.81, -0.68 40.57 M0 0 C-0.11 6.76, -0.57 33.81, -0.68 40.57" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(50.571533203125 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M0 0 C-6.76 8.95, -33.81 44.76, -40.57 53.71 M0 0 C-6.76 8.95, -33.81 44.76, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(50.571533203125 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M-33.24 29.81 C-36.11 39.18, -38.99 48.55, -40.57 53.71 M-33.24 29.81 C-34.9 35.23, -36.56 40.64, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(50.571533203125 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M-19.59 40.12 C-27.81 45.45, -36.04 50.78, -40.57 53.71 M-19.59 40.12 C-24.34 43.2, -29.09 46.28, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(39.92324445803911 184.8088534473485) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M0 0 C15.05 -0.1, 75.24 -0.48, 90.29 -0.57 M0 0 C15.05 -0.1, 75.24 -0.48, 90.29 -0.57" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(39.92324445803911 184.8088534473485) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M66.85 8.13 C71.84 6.27, 76.84 4.42, 90.29 -0.57 M66.85 8.13 C76.12 4.69, 85.4 1.24, 90.29 -0.57" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(39.92324445803911 184.8088534473485) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M66.74 -8.97 C71.76 -7.18, 76.77 -5.39, 90.29 -0.57 M66.74 -8.97 C76.06 -5.65, 85.37 -2.32, 90.29 -0.57" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(90.00009155273438 89.4285888671875) rotate(0 -0.5714263916015625 -32.857154846191406)"><path d="M0 0 C-0.19 -10.95, -0.95 -54.76, -1.14 -65.71 M0 0 C-0.19 -10.95, -0.95 -54.76, -1.14 -65.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(90.00009155273438 89.4285888671875) rotate(0 -0.5714263916015625 -32.857154846191406)"><path d="M7.81 -42.37 C5.57 -48.22, 3.32 -54.07, -1.14 -65.71 M7.81 -42.37 C5.69 -47.92, 3.56 -53.46, -1.14 -65.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(90.00009155273438 89.4285888671875) rotate(0 -0.5714263916015625 -32.857154846191406)"><path d="M-9.28 -42.08 C-7.24 -48, -5.2 -53.93, -1.14 -65.71 M-9.28 -42.08 C-7.35 -47.69, -5.42 -53.3, -1.14 -65.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>

</div>

i.e. Give multiple edges: \\(a \rightarrow t, b \rightarrow t, c \rightarrow t\\) leading to the same destination vertex \\(t\\); the incomplete version of DFS (i.e. just BFS with stack) takes the first encountered edge \\(a \rightarrow t\\) to \\(t\\). The complete solution is to pick the last encountered edge \\(c \rightarrow t\\).

## Highlights

- It has the running time of \\(O(V+E)\\).

## DFS tree

If we are to trace the above DFS algorithm running on a graph, it'd lead us to a tree structure. Let's call it $G_{\pi}$. It will have all the vertices of \\(G\\), meaning it'll be a spanning tree (or forest if there are multiple connected components). However, not all the edges of \\(G\\) will be present in $G_{\pi}$. We classify edges of \\(G\\) in following manner:

1. _Tree edge:_ an edge of \\(G\\) that is also present in $G_{\pi}$. This is an edge DFS actually traversed.
2. _Back edge:_ an edge of \\(G\\) leading a vertex back to its ancestor (proper or parent) in $G_{\pi}$.
3. _Forward edge:_ an edge of \\(G\\) leading a vertex to its proper descendant in $G_{\pi}$.
4. _Cross edge:_ all other edges.

An undirected graph can only have #1 and #2, as there are no _one-way_ edges. DFS will traverse would-be forward/cross edges, turning them into tree edges or back edges.

From this, identifying a back edge in an undirected graph is straightforward:

<div class="grid" markdown>

```ruby title="recursive DFS(G, s)" linenums="1" hl_lines="6 7"
mark s visited
print u
for (s, u) in G:
  if u is not visited:
    DFS(G, u)
  else:
    error("back edge. loop detected.")
```

```ruby title="iterative DFS(G, s)" linenums="1" hl_lines="9 10"
S.push(s)
while S is not empty:
  u = S.pop()
  if u is not visited:
    mark u visited
    print u
    for (u, v) in G:
      S.push(v)
  else:
    error("back edge. loop detected.")
```

</div>

## Vertex coloring

Introduce a third state after _visited_, called _explored_ to mark vertices whose neighbours are all visited. When an edge \\(u \rightarrow v\\) is first traversed, the color of \\(v\\) determines the type of this edge:

1. `WHITE` indicates it's a tree edge.
2. `GRAY` indicates it's a back edge.
3. `BLACK` indicates it's a forward or cross edge.

=== "recursive"

    ```ruby linenums="1"
    DFS(G):
      for u in G:
        u.color = WHITE
      for u in G:
        if u.color is WHITE:
          DFS(G, u)

    DFS(G, u):
      u.color = GRAY
      for (u, v) in G:
        switch(v.color):
          WHITE: DFS(G, v)
          GRAY:  # u -> v is back edge
          BLACK: # u -> v is forward/cross edge
      u.color = BLACK
    ```

=== "kotlin"

    ```kotlin linenums="1"
    fun Graph.dfs() {
      val color = HashMap<Int, Color>()
      for (u in vertices)
        if ((color[u] ?: Color.WHITE) == Color.WHITE)
          dfs(u, u, 0, color)
    }

    fun Graph.dfs(
      source: Int,
      parent: Int = source,
      indent: Int = 0,
      color: HashMap<Int, Color> = HashMap()
    ) {
      println(" ".repeat(indent) + "$parent-$source tree")
      color[source] = Color.GRAY

      val ci = indent + "$parent-".length
      for (n in neighbours(source)) {
        when(color[n] ?: Color.WHITE) {
          Color.WHITE -> dfs(n, source, ci, color)
          Color.GRAY -> println(" ".repeat(ci) + "$source-$n back")
          Color.BLACK -> println(" ".repeat(ci) + "$source-$n forward/cross")
        }
      }
      color[source] = Color.BLACK
    }

    enum class Color { WHITE, GRAY, BLACK }
    ```

=== "iterative"

    ```ruby linenums="1"
    DFS(G):
      for u in G:
        u.color = WHITE
      for u in G:
        if u.color is WHITE:
          DFS(G, u)

    DFS(G, s):
      S.push(<∅, s, false>)
      while S is not empty:
        p, u, black = S.pop()
        if black:
          u.color = BLACK
          continue

        print "p -> u"

        switch(u.color):
          WHITE:
            u.color = GRAY
            S.push(<p, u, true>) # to later mark u as explored
            for (u, v) in G:
              S.push(<u, v, false>)
          GRAY:  # p -> u is back edge
          BLACK: # p -> u is forward/cross edge
    ```

=== "kotlin"

    ```kotlin linenums="1"
    fun Graph.dfs() {
      val color = HashMap<Int, Color>()
      for (u in vertices)
        if (color.getOrDefault(u, Color.WHITE) == Color.WHITE)
          dfs(u, color)
    }

    fun Graph.dfs(
      source: Int,
      color: HashMap<Int, Color> = HashMap(),
    ) {
      val stack = ArrayDeque<Record>().apply { this.add(Record(source, source)) }
      while (stack.isNotEmpty()) {
        val r = stack.removeFirst()
        val c = color.getOrDefault(r.src, Color.WHITE)
        if (r.explored) {
          color[r.src] = Color.BLACK
          continue
        }
        println("$r ${c.type}")

        if (c == Color.WHITE) {
          color[r.src] = Color.GRAY

          // set up a memo to mark u `BLACK` when all neighbours are explored.
          stack.addFirst(r.copy(explored = true))

          // push neighbours in reverse order to mimic recusive dfs output.
          for (v in neighbours(r.src).reversed())
            stack.addFirst(Record(r.src, v, r.childIndent()))
        }
      }
    }

    data class Record(
      val pred: Int,
      val src: Int,
      val indent: Int = 0,
      val explored: Boolean = false
    ) {
      fun childIndent(): Int = indent + "$pred-".length
      override fun toString(): String {
        if (explored) return "$src explored"
        return " ".repeat(indent) + "$pred-$src"
      }
    }

    enum class Color(val type: String) {
      WHITE("tree"), GRAY("back"), BLACK("forward/cross")
    }
    ```

    1. hello

<div class="grid" markdown>

### Example run

<span>

```ruby linenums="1"
1-1 tree
  1-2 tree
    2-1 back
    2-3 tree
      3-2 back
      3-1 back
      3-4 tree
        4-2 back
        4-1 back
        4-3 back
    2-4 forward/cross
  1-3 forward/cross
  1-4 forward/cross
```

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 141.51434326171875 149.64280700683594" height="120">
  <g transform="translate(65.56714630126953 10) rotate(0 2.7099990844726562 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(62.71437072753906 74.92847442626953) rotate(0 7.1199951171875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(10 112.64277648925781) rotate(0 6.80999755859375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(118.71435546875 114.64280700683594) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round"><g transform="translate(59.85295867919922 88.45775341974183) rotate(0 -16.562538052309662 12.655519062760078)"><path d="M0 0 C-5.52 4.22, -27.6 21.09, -33.13 25.31 M0 0 C-5.52 4.22, -27.6 21.09, -33.13 25.31" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(80.42436981201172 90.3067120074881) rotate(0 17.787845611572266 15.08297932621204)"><path d="M0 0 C5.93 5.03, 29.65 25.14, 35.58 30.17 M0 0 C5.93 5.03, 29.65 25.14, 35.58 30.17" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(67.91935867542236 36) rotate(0 -0.07211355440611555 18.964237213134766)"><path d="M0 0 C-0.02 6.32, -0.12 31.61, -0.14 37.93 M0 0 C-0.02 6.32, -0.12 31.61, -0.14 37.93" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(29.567237854003963 124.88887204649251) rotate(0 41.42855834960935 -0.034995567774018355)"><path d="M0 0 C13.81 -0.01, 69.05 -0.06, 82.86 -0.07 M0 0 C13.81 -0.01, 69.05 -0.06, 82.86 -0.07" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(15.52679134263741 111.14274597167969) rotate(0 21.877370472480123 -40.71464349171035)"><path d="M0 0 C7.29 -13.57, 36.46 -67.86, 43.75 -81.43 M0 0 C7.29 -13.57, 36.46 -67.86, 43.75 -81.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(78.13867950439453 29.95840096158105) rotate(0 23.775752241648377 41.44933498063526)"><path d="M0 0 C7.93 13.82, 39.63 69.08, 47.55 82.9 M0 0 C7.93 13.82, 39.63 69.08, 47.55 82.9" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>

```ruby linenums="1"
0-0 tree
  0-2 tree
    2-0 back
    2-6 tree
      6-2 back
      6-4 tree
        4-6 back
        4-5 tree
          5-4 back
          5-0 back
          5-3 tree
            3-4 back
            3-5 back
        4-3 forward/cross
        4-7 tree
          7-4 back
          7-1 tree
            1-7 back
          7-0 back
  0-5 forward/cross
  0-7 forward/cross
```

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 180.49137115478516 211.7143096923828" height="160">
  <g transform="translate(10 10.500015258789062) rotate(0 6.879997253417969 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(93.83417510986328 10) rotate(0 7.1199951171875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(16.83423614501953 176.7143096923828) rotate(0 6.17999267578125 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">5</text></g><g transform="translate(100.4056167602539 176.14280700683594) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g transform="translate(55.54853057861328 130.8571319580078) rotate(0 6.80999755859375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round"><g transform="translate(33.999969482421875 188.7857208251953) rotate(0 29.714309692382812 0)"><path d="M0 0 C9.9 0, 49.52 0, 59.43 0 M0 0 C9.9 0, 49.52 0, 59.43 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(31.71429443359375 173.35716247558594) rotate(0 9.714263916015625 -13.142868041992188)"><path d="M0 0 C3.24 -4.38, 16.19 -21.9, 19.43 -26.29 M0 0 C3.24 -4.38, 16.19 -21.9, 19.43 -26.29" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(75.142822265625 146.5000457763672) rotate(0 12 13.714279174804688)"><path d="M0 0 C4 4.57, 20 22.86, 24 27.43 M0 0 C4 4.57, 20 22.86, 24 27.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(100.11991119384766 79.99998474121094) rotate(0 5.379997253417969 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">7</text></g><g transform="translate(55.977088928222656 76.42860412597656) rotate(0 2.7099990844726562 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g stroke-linecap="round"><g transform="translate(67.71432495117188 90.38973310592377) rotate(0 12.85711669921875 0.028216028677121585)"><path d="M0 0 C4.29 0.01, 21.43 0.05, 25.71 0.06 M0 0 C4.29 0.01, 21.43 0.05, 25.71 0.06" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(105.1629345563212 105.999984741211) rotate(0 0.9548937491055938 32.2500305175781)"><path d="M0 0 C0.32 10.75, 1.59 53.75, 1.91 64.5 M0 0 C0.32 10.75, 1.59 53.75, 1.91 64.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(15.71429443359375 32.78572082519531) rotate(0 2.85711669921875 69.71430969238281)"><path d="M0 0 C0.95 23.24, 4.76 116.19, 5.71 139.43 M0 0 C0.95 23.24, 4.76 116.19, 5.71 139.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(27.142822265625 20.51993882605143) rotate(0 31.142852783203125 0.22967394617921855)"><path d="M0 0 C10.38 0.08, 51.9 0.38, 62.29 0.46 M0 0 C10.38 0.08, 51.9 0.38, 62.29 0.46" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(22.571441650390625 28.214279174804688) rotate(0 37.714263916015625 24.857147216796875)"><path d="M0 0 C12.57 8.29, 62.86 41.43, 75.43 49.71 M0 0 C12.57 8.29, 62.86 41.43, 75.43 49.71" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(157.6913833618164 76.85713195800781) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">6</text></g><g stroke-linecap="round"><g transform="translate(111.71429443359375 29.928573608398438) rotate(0 23.428573608398438 23.428573608398438)"><path d="M0 0 C7.81 7.81, 39.05 39.05, 46.86 46.86 M0 0 C7.81 7.81, 39.05 39.05, 46.86 46.86" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(162.57144165039062 100.21434020996094) rotate(0 -23.14288330078125 40.85713195800781)"><path d="M0 0 C-7.71 13.62, -38.57 68.1, -46.29 81.71 M0 0 C-7.71 13.62, -38.57 68.1, -46.29 81.71" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>

```ruby linenums="1"
1-1 tree
  1-2 tree
3-3 tree
4-4 tree
  4-3 forward/cross
5-5 tree
  5-9 tree
    9-14 tree
      14-15 tree
         15-11 tree
            11-8 tree
               8-3 forward/cross
               8-4 forward/cross
            11-12 tree
               12-8 forward/cross
               12-16 tree
         15-12 forward/cross
6-6 tree
  6-2 forward/cross
  6-7 tree
    7-3 forward/cross
    7-11 forward/cross
  6-12 forward/cross
10-10 tree
   10-13 tree
      13-9 forward/cross
   10-14 forward/cross
   10-11 forward/cross
```

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 406.320617885659 353.1903024009223" height="240">
  <g transform="translate(10 15.369098136339346) rotate(0 2.7099990844726562 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(127.97729251722865 14.170937208091061) rotate(0 7.1199951171875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(253.50816637895366 10.941834464732324) rotate(0 6.80999755859375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(367.19905843837535 10) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g transform="translate(13.094998267336678 114.66999244167556) rotate(0 6.17999267578125 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">5</text></g><g transform="translate(131.07229078456544 113.47183151342739) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">6</text></g><g transform="translate(256.60316464629045 110.2427287700686) rotate(0 5.379997253417969 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">7</text></g><g transform="translate(370.29405670571214 109.30089430533627) rotate(0 7.649993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">8</text></g><g transform="translate(13.329118059141138 219.0685161641906) rotate(0 6.089996337890625 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">9</text></g><g transform="translate(134.57048029070302 218.68635710028786) rotate(0 9.589996337890625 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">10</text></g><g transform="translate(260.10135415242803 215.45725435692907) rotate(0 5.4199981689453125 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">11</text></g><g transform="translate(373.7922462118497 214.51541989219675) rotate(0 9.829994201660156 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">12</text></g><g transform="translate(16.005500042345375 318.1903024009223) rotate(0 9.519996643066406 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">13</text></g><g transform="translate(137.24686227390737 316.9921414726739) rotate(0 9.109992980957031 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">14</text></g><g transform="translate(264.4097398643232 313.7630387293152) rotate(0 8.889991760253906 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">15</text></g><g transform="translate(378.1006319237449 312.8212042645829) rotate(0 9.109992980957031 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">16</text></g><g stroke-linecap="round"><g transform="translate(17.931008364465356 142.36249650286715) rotate(0 1.3750657947521177 32.64058819366829)"><path d="M0 0 C0.46 10.88, 2.29 54.4, 2.75 65.28 M0 0 C0.46 10.88, 2.29 54.4, 2.75 65.28" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(17.931008364465356 142.36249650286715) rotate(0 1.3750657947521177 32.64058819366829)"><path d="M-6.78 42.17 C-3.68 49.7, -0.57 57.22, 2.75 65.28 M-6.78 42.17 C-3.65 49.77, -0.51 57.38, 2.75 65.28" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(17.931008364465356 142.36249650286715) rotate(0 1.3750657947521177 32.64058819366829)"><path d="M10.3 41.45 C7.84 49.21, 5.38 56.97, 2.75 65.28 M10.3 41.45 C7.82 49.29, 5.33 57.13, 2.75 65.28" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(24.819194718550648 315.35753766454343) rotate(0 -0.47555906832474193 -34.2725919223592)"><path d="M0 0 C-0.16 -11.42, -0.79 -57.12, -0.95 -68.55 M0 0 C-0.16 -11.42, -0.79 -57.12, -0.95 -68.55" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(24.819194718550648 315.35753766454343) rotate(0 -0.47555906832474193 -34.2725919223592)"><path d="M7.92 -45.17 C5.98 -50.29, 4.03 -55.42, -0.95 -68.55 M7.92 -45.17 C4.67 -53.74, 1.42 -62.3, -0.95 -68.55" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(24.819194718550648 315.35753766454343) rotate(0 -0.47555906832474193 -34.2725919223592)"><path d="M-9.17 -44.94 C-7.37 -50.11, -5.57 -55.28, -0.95 -68.55 M-9.17 -44.94 C-6.16 -53.59, -3.15 -62.24, -0.95 -68.55" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(133.47982607949314 242.73228224114627) rotate(0 -45.696789229812225 39.576681861794015)"><path d="M0 0 C-15.23 13.19, -76.16 65.96, -91.39 79.15 M0 0 C-15.23 13.19, -76.16 65.96, -91.39 79.15" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(133.47982607949314 242.73228224114627) rotate(0 -45.696789229812225 39.576681861794015)"><path d="M-79.23 57.31 C-83.35 64.71, -87.47 72.1, -91.39 79.15 M-79.23 57.31 C-84.09 66.03, -88.94 74.75, -91.39 79.15" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(133.47982607949314 242.73228224114627) rotate(0 -45.696789229812225 39.576681861794015)"><path d="M-68.04 70.24 C-75.95 73.26, -83.86 76.28, -91.39 79.15 M-68.04 70.24 C-77.36 73.8, -86.69 77.36, -91.39 79.15" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(144.90403895118413 245.18031896265836) rotate(0 1.2240339249939325 33.864622118662226)"><path d="M0 0 C0.41 11.29, 2.04 56.44, 2.45 67.73 M0 0 C0.41 11.29, 2.04 56.44, 2.45 67.73" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(144.90403895118413 245.18031896265836) rotate(0 1.2240339249939325 33.864622118662226)"><path d="M-6.95 44.56 C-4.33 51.01, -1.72 57.45, 2.45 67.73 M-6.95 44.56 C-3.46 53.16, 0.03 61.75, 2.45 67.73" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(144.90403895118413 245.18031896265836) rotate(0 1.2240339249939325 33.864622118662226)"><path d="M10.14 43.94 C8 50.56, 5.86 57.18, 2.45 67.73 M10.14 43.94 C7.29 52.77, 4.43 61.6, 2.45 67.73" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(94.31123853529914 290.8771393209464) rotate(0 17.952290043406094 14.688251457548517)"><path d="M0 0 C5.98 4.9, 29.92 24.48, 35.9 29.38 M0 0 C5.98 4.9, 29.92 24.48, 35.9 29.38" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(94.31123853529914 290.8771393209464) rotate(0 17.952290043406094 14.688251457548517)"><path d="M14.01 21.71 C22.22 24.59, 30.42 27.46, 35.9 29.38 M14.01 21.71 C21.31 24.27, 28.61 26.82, 35.9 29.38" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(94.31123853529914 290.8771393209464) rotate(0 17.952290043406094 14.688251457548517)"><path d="M24.06 9.43 C28.5 16.91, 32.94 24.38, 35.9 29.38 M24.06 9.43 C28.01 16.08, 31.96 22.73, 35.9 29.38" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(30.66203474817769 238.65221066246744) rotate(0 23.256395547078796 19.584379375405405)"><path d="M0 0 C7.75 6.53, 38.76 32.64, 46.51 39.17 M0 0 C7.75 6.53, 38.76 32.64, 46.51 39.17" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(153.88018397288715 122.77817160229444) rotate(0 47.32885521545467 -0.40801649641062454)"><path d="M0 0 C15.78 -0.14, 78.88 -0.68, 94.66 -0.82 M0 0 C15.78 -0.14, 78.88 -0.68, 94.66 -0.82" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(153.88018397288715 122.77817160229444) rotate(0 47.32885521545467 -0.40801649641062454)"><path d="M71.24 7.94 C79.13 4.99, 87.03 2.04, 94.66 -0.82 M71.24 7.94 C79.03 5.03, 86.81 2.12, 94.66 -0.82" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(153.88018397288715 122.77817160229444) rotate(0 47.32885521545467 -0.40801649641062454)"><path d="M71.09 -9.16 C79.04 -6.35, 86.98 -3.54, 94.66 -0.82 M71.09 -9.16 C78.93 -6.39, 86.76 -3.61, 94.66 -0.82" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(137.55989765817196 105.64186785899591) rotate(0 -0.8160018643454805 -31.824562982966)"><path d="M0 0 C-0.27 -10.61, -1.36 -53.04, -1.63 -63.65 M0 0 C-0.27 -10.61, -1.36 -53.04, -1.63 -63.65" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(137.55989765817196 105.64186785899591) rotate(0 -0.8160018643454805 -31.824562982966)"><path d="M7.52 -40.38 C4.35 -48.43, 1.19 -56.48, -1.63 -63.65 M7.52 -40.38 C5.47 -45.6, 3.42 -50.81, -1.63 -63.65" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(137.55989765817196 105.64186785899591) rotate(0 -0.8160018643454805 -31.824562982966)"><path d="M-9.58 -39.95 C-6.83 -48.14, -4.08 -56.34, -1.63 -63.65 M-9.58 -39.95 C-7.8 -45.26, -6.02 -50.57, -1.63 -63.65" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(24.13395757646265 27.30449043551539) rotate(0 48.96085894414557 0)"><path d="M0 0 C16.32 0, 81.6 0, 97.92 0 M0 0 C16.32 0, 81.6 0, 97.92 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(24.13395757646265 27.30449043551539) rotate(0 48.96085894414557 0)"><path d="M74.43 8.55 C82.62 5.57, 90.81 2.59, 97.92 0 M74.43 8.55 C79.81 6.59, 85.19 4.63, 97.92 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(24.13395757646265 27.30449043551539) rotate(0 48.96085894414557 0)"><path d="M74.43 -8.55 C82.62 -5.57, 90.81 -2.59, 97.92 0 M74.43 -8.55 C79.81 -6.59, 85.19 -4.63, 97.92 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(164.48839498023267 325.9657175434131) rotate(0 46.92082315480616 0)"><path d="M0 0 C15.64 0, 78.2 0, 93.84 0 M0 0 C15.64 0, 78.2 0, 93.84 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(164.48839498023267 325.9657175434131) rotate(0 46.92082315480616 0)"><path d="M70.35 8.55 C76.19 6.42, 82.04 4.3, 93.84 0 M70.35 8.55 C76.02 6.49, 81.69 4.42, 93.84 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(164.48839498023267 325.9657175434131) rotate(0 46.92082315480616 0)"><path d="M70.35 -8.55 C76.19 -6.42, 82.04 -4.3, 93.84 0 M70.35 -8.55 C76.02 -6.49, 81.69 -4.42, 93.84 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(163.6723931158872 229.6760345122886) rotate(0 44.47278643329406 -0.8160174285833364)"><path d="M0 0 C14.82 -0.27, 74.12 -1.36, 88.95 -1.63 M0 0 C14.82 -0.27, 74.12 -1.36, 88.95 -1.63" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(163.6723931158872 229.6760345122886) rotate(0 44.47278643329406 -0.8160174285833364)"><path d="M65.61 7.35 C71.31 5.16, 77 2.97, 88.95 -1.63 M65.61 7.35 C72.57 4.67, 79.52 2, 88.95 -1.63" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(163.6723931158872 229.6760345122886) rotate(0 44.47278643329406 -0.8160174285833364)"><path d="M65.3 -9.75 C71.07 -7.77, 76.84 -5.79, 88.95 -1.63 M65.3 -9.75 C72.35 -7.33, 79.39 -4.91, 88.95 -1.63" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(272.2022597545723 310.4614642215191) rotate(0 -1.224002796518164 -33.048589125841005)"><path d="M0 0 C-0.41 -11.02, -2.04 -55.08, -2.45 -66.1 M0 0 C-0.41 -11.02, -2.04 -55.08, -2.45 -66.1" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(272.2022597545723 310.4614642215191) rotate(0 -1.224002796518164 -33.048589125841005)"><path d="M6.97 -42.94 C4.94 -47.91, 2.92 -52.88, -2.45 -66.1 M6.97 -42.94 C4.15 -49.86, 1.34 -56.78, -2.45 -66.1" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(272.2022597545723 310.4614642215191) rotate(0 -1.224002796518164 -33.048589125841005)"><path d="M-10.12 -42.3 C-8.48 -47.41, -6.83 -52.52, -2.45 -66.1 M-10.12 -42.3 C-7.83 -49.41, -5.54 -56.52, -2.45 -66.1" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(283.6264726262632 226.41199592643108) rotate(0 41.616748779609225 -0.40801649641062454)"><path d="M0 0 C13.87 -0.14, 69.36 -0.68, 83.23 -0.82 M0 0 C13.87 -0.14, 69.36 -0.68, 83.23 -0.82" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(283.6264726262632 226.41199592643108) rotate(0 41.616748779609225 -0.40801649641062454)"><path d="M59.83 7.96 C68.32 4.78, 76.82 1.59, 83.23 -0.82 M59.83 7.96 C68.11 4.86, 76.39 1.75, 83.23 -0.82" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(283.6264726262632 226.41199592643108) rotate(0 41.616748779609225 -0.40801649641062454)"><path d="M59.66 -9.14 C68.22 -6.12, 76.77 -3.1, 83.23 -0.82 M59.66 -9.14 C68 -6.19, 76.35 -3.25, 83.23 -0.82" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(290.97061391927537 318.6216073788768) rotate(0 40.39271485461529 -39.168696493859215)"><path d="M0 0 C13.46 -13.06, 67.32 -65.28, 80.79 -78.34 M0 0 C13.46 -13.06, 67.32 -65.28, 80.79 -78.34" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(290.97061391927537 318.6216073788768) rotate(0 40.39271485461529 -39.168696493859215)"><path d="M69.87 -55.84 C73.5 -63.32, 77.12 -70.79, 80.79 -78.34 M69.87 -55.84 C73.55 -63.42, 77.22 -70.99, 80.79 -78.34" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(290.97061391927537 318.6216073788768) rotate(0 40.39271485461529 -39.168696493859215)"><path d="M57.97 -68.12 C65.55 -71.52, 73.13 -74.91, 80.79 -78.34 M57.97 -68.12 C65.65 -71.56, 73.33 -75, 80.79 -78.34" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(383.9962583645423 245.99632082700379) rotate(0 1.224002796518164 28.968517547162236)"><path d="M0 0 C0.41 9.66, 2.04 48.28, 2.45 57.94 M0 0 C0.41 9.66, 2.04 48.28, 2.45 57.94" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(383.9962583645423 245.99632082700379) rotate(0 1.224002796518164 28.968517547162236)"><path d="M-7.09 34.83 C-3.41 43.74, 0.27 52.66, 2.45 57.94 M-7.09 34.83 C-3.82 42.74, -0.56 50.65, 2.45 57.94" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(383.9962583645423 245.99632082700379) rotate(0 1.224002796518164 28.968517547162236)"><path d="M10 34.1 C7.09 43.3, 4.17 52.49, 2.45 57.94 M10 34.1 C7.41 42.26, 4.83 50.42, 2.45 57.94" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(263.2261147328692 138.28242492418838) rotate(0 1.2240339249939893 35.08862491518039)"><path d="M0 0 C0.41 11.7, 2.04 58.48, 2.45 70.18 M0 0 C0.41 11.7, 2.04 58.48, 2.45 70.18" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(263.2261147328692 138.28242492418838) rotate(0 1.2240339249939893 35.08862491518039)"><path d="M-6.92 47 C-4.57 52.8, -2.23 58.6, 2.45 70.18 M-6.92 47 C-3.83 54.64, -0.74 62.28, 2.45 70.18" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(263.2261147328692 138.28242492418838) rotate(0 1.2240339249939893 35.08862491518039)"><path d="M10.17 46.4 C8.24 52.35, 6.31 58.31, 2.45 70.18 M10.17 46.4 C7.63 54.24, 5.08 62.07, 2.45 70.18" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(151.43217837985082 134.20235334550955) rotate(0 51.816927726306176 18.768354164703112)"><path d="M0 0 C17.27 6.26, 86.36 31.28, 103.63 37.54 M0 0 C17.27 6.26, 86.36 31.28, 103.63 37.54" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(277.914335061942 214.17175006191889) rotate(0 46.104821290460734 -40.39269929037738)"><path d="M0 0 C15.37 -13.46, 76.84 -67.32, 92.21 -80.79 M0 0 C15.37 -13.46, 76.84 -67.32, 92.21 -80.79" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(277.914335061942 214.17175006191889) rotate(0 46.104821290460734 -40.39269929037738)"><path d="M80.17 -58.87 C84.39 -66.55, 88.61 -74.23, 92.21 -80.79 M80.17 -58.87 C83.79 -65.46, 87.41 -72.04, 92.21 -80.79" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(277.914335061942 214.17175006191889) rotate(0 46.104821290460734 -40.39269929037738)"><path d="M68.9 -71.74 C77.07 -74.91, 85.24 -78.08, 92.21 -80.79 M68.9 -71.74 C75.91 -74.45, 82.91 -77.17, 92.21 -80.79" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(317.08304712003905 193.77142329700064) rotate(0 22.84842574338188 8.976145021703047)"><path d="M0 0 C7.62 2.99, 38.08 14.96, 45.7 17.95 M0 0 C7.62 2.99, 38.08 14.96, 45.7 17.95" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(317.08304712003905 193.77142329700064) rotate(0 22.84842574338188 8.976145021703047)"><path d="M21.16 17.33 C27.98 17.5, 34.8 17.68, 45.7 17.95 M21.16 17.33 C28.58 17.52, 36 17.71, 45.7 17.95" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(317.08304712003905 193.77142329700064) rotate(0 22.84842574338188 8.976145021703047)"><path d="M27.3 1.7 C32.41 6.22, 37.52 10.73, 45.7 17.95 M27.3 1.7 C32.86 6.62, 38.42 11.53, 45.7 17.95" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(298.31475521228754 187.24328386833395) rotate(0 -14.280250525375777 -4.89607344302425)"><path d="M0 0 C-4.76 -1.63, -23.8 -8.16, -28.56 -9.79 M0 0 C-4.76 -1.63, -23.8 -8.16, -28.56 -9.79" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(383.9962583645423 209.27567661889464) rotate(0 -0.8160329928212491 -35.90462677952584)"><path d="M0 0 C-0.27 -11.97, -1.36 -59.84, -1.63 -71.81 M0 0 C-0.27 -11.97, -1.36 -59.84, -1.63 -71.81" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(383.9962583645423 209.27567661889464) rotate(0 -0.8160329928212491 -35.90462677952584)"><path d="M7.45 -48.52 C4.18 -56.92, 0.9 -65.31, -1.63 -71.81 M7.45 -48.52 C5.18 -54.34, 2.91 -60.16, -1.63 -71.81" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(383.9962583645423 209.27567661889464) rotate(0 -0.8160329928212491 -35.90462677952584)"><path d="M-9.65 -48.13 C-6.76 -56.67, -3.87 -65.21, -1.63 -71.81 M-9.65 -48.13 C-7.64 -54.05, -5.64 -59.97, -1.63 -71.81" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(126.1357470434325 72.18526223674428) rotate(0 -49.368859876318254 -17.952313389762935)"><path d="M0 0 C-16.46 -5.98, -82.28 -29.92, -98.74 -35.9 M0 0 C-16.46 -5.98, -82.28 -29.92, -98.74 -35.9" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(126.1357470434325 72.18526223674428) rotate(0 -49.368859876318254 -17.952313389762935)"><path d="M-73.74 -35.91 C-82.59 -35.91, -91.44 -35.91, -98.74 -35.9 M-73.74 -35.91 C-82.07 -35.91, -90.41 -35.91, -98.74 -35.9" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(126.1357470434325 72.18526223674428) rotate(0 -49.368859876318254 -17.952313389762935)"><path d="M-79.58 -19.84 C-86.36 -25.53, -93.14 -31.21, -98.74 -35.9 M-79.58 -19.84 C-85.97 -25.2, -92.36 -30.55, -98.74 -35.9" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(145.7200408155294 79.5294190939943) rotate(0 51.40892679413355 17.544281329114398)"><path d="M0 0 C17.14 5.85, 85.68 29.24, 102.82 35.09 M0 0 C17.14 5.85, 85.68 29.24, 102.82 35.09" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(260.77810913983285 104.009864130305) rotate(0 0 -31.82457076508493)"><path d="M0 0 C0 -10.61, 0 -53.04, 0 -63.65 M0 0 C0 -10.61, 0 -53.04, 0 -63.65" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(260.77810913983285 104.009864130305) rotate(0 0 -31.82457076508493)"><path d="M8.55 -40.16 C6.36 -46.16, 4.18 -52.17, 0 -63.65 M8.55 -40.16 C6.35 -46.2, 4.15 -52.24, 0 -63.65" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(260.77810913983285 104.009864130305) rotate(0 0 -31.82457076508493)"><path d="M-8.55 -40.16 C-6.36 -46.16, -4.18 -52.17, 0 -63.65 M-8.55 -40.16 C-6.35 -46.2, -4.15 -52.24, 0 -63.65" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(366.85997018548164 112.16999172342469) rotate(0 -46.104821290460734 -35.90463456164477)"><path d="M0 0 C-15.37 -11.97, -76.84 -59.84, -92.21 -71.81 M0 0 C-15.37 -11.97, -76.84 -59.84, -92.21 -71.81" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(366.85997018548164 112.16999172342469) rotate(0 -46.104821290460734 -35.90463456164477)"><path d="M-68.42 -64.12 C-74.97 -66.24, -81.52 -68.36, -92.21 -71.81 M-68.42 -64.12 C-76.19 -66.63, -83.95 -69.14, -92.21 -71.81" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(366.85997018548164 112.16999172342469) rotate(0 -46.104821290460734 -35.90463456164477)"><path d="M-78.93 -50.63 C-82.59 -56.46, -86.24 -62.29, -92.21 -71.81 M-78.93 -50.63 C-83.26 -57.54, -87.6 -64.46, -92.21 -71.81" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(379.100184921518 99.92979255162624) rotate(0 -0.40803206064850883 -30.192543690037212)"><path d="M0 0 C-0.14 -10.06, -0.68 -50.32, -0.82 -60.39 M0 0 C-0.14 -10.06, -0.68 -50.32, -0.82 -60.39" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(379.100184921518 99.92979255162624) rotate(0 -0.40803206064850883 -30.192543690037212)"><path d="M8.05 -37.01 C5.2 -44.54, 2.34 -52.06, -0.82 -60.39 M8.05 -37.01 C5.45 -43.88, 2.84 -50.75, -0.82 -60.39" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(379.100184921518 99.92979255162624) rotate(0 -0.40803206064850883 -30.192543690037212)"><path d="M-9.05 -36.78 C-6.4 -44.38, -3.75 -51.98, -0.82 -60.39 M-9.05 -36.78 C-6.63 -43.72, -4.21 -50.65, -0.82 -60.39" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(360.33183075681495 20.776382135324468) rotate(0 -43.24875250830013 0)"><path d="M0 0 C-14.42 0, -72.08 0, -86.5 0 M0 0 C-14.42 0, -72.08 0, -86.5 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(360.33183075681495 20.776382135324468) rotate(0 -43.24875250830013 0)"><path d="M-63.01 -8.55 C-68.93 -6.4, -74.85 -4.24, -86.5 0 M-63.01 -8.55 C-69.9 -6.04, -76.79 -3.53, -86.5 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(360.33183075681495 20.776382135324468) rotate(0 -43.24875250830013 0)"><path d="M-63.01 8.55 C-68.93 6.4, -74.85 4.24, -86.5 0 M-63.01 8.55 C-69.9 6.04, -76.79 3.53, -86.5 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>

</div>

<hr>

## Parenthesis property

Consider any two vertices \\(u\\) and \\(v\\): the ranges \\([u_{s}, u_{f}]\\) and \\([v_{s}, v_{f}]\\) will either contain each other or will be completely disjoint, never partially overlapping. An edge \\(u \rightarrow v\\) is then:

1. Tree/forward edge if \\( \underset{u}{\big\[} \; \underset{v}{\big\[} \; \underset{v}{\big\]} \; \underset{u}{\big\]} \\).
2. Back edge if \\( \underset{v}{\big\[} \; \underset{u}{\big\[} \; \underset{u}{\big\]} \; \underset{v}{\big\]} \\).
3. Cross edge if \\( \underset{u}{\big\[} \; \underset{u}{\big\]} \; \underset{v}{\big\[} \; \underset{v}{\big\]} \\) or \\( \underset{v}{\big\[} \; \underset{v}{\big\]} \; \underset{u}{\big\[} \; \underset{u}{\big\]} \\).
