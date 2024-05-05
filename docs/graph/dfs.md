# Depth-first Search

## Intro

<div class="grid" markdown>

It's helpful to consider DFS in contrast to its sibling BFS. Where BFS is the cautious approach, clearing up the graph layer-by-layer, DFS is the head-first adventure in the maze. <br> <br> BFS is akin to a group of people exploring a maze, splitting off into subgroups at each intersection. Whereas DFS is like a lone explorer uncovering a maze.

![](/assets/dfs.gif){ loading=lazy }

</div>

## Pseudo-code

<div class="grid" markdown>

### Basic version

<span>

```ruby title="recursive DFS(G, s)" linenums="1"
mark s visited
print u
for (s, u) in G:
  if u is not visited:
    DFS(G, u)
```

```ruby title="iterative DFS(G, s)" linenums="1"
S.push(s)
while S is not empty:
  u = S.pop()
  if u is not visited:
    mark u visited
    print u
    for (u, v) in G:
      S.push(v)
```

Recursive version is DFS at its simplest. Notice that it's not a one-to-one conversion to the iterative version.

Iterative DFS is quite like BFS, except: <br>
a) stack instead of queue. <br>
b) vertex is checked for being *visited* after taking them out of the *bag*, instead of before being "bagged". <br><br>

</div>

### Explanation

<div class="grid" markdown>

If we just replace queue with stack in BFS, that'd not be enough for it to be DFS. `DFS(G, 2)` would spit out `2, 3, 1, 4`. The strategy of "carry on" exploring a path gets disrupted when the next vertex on said path is already marked visited. 

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 244.9398193359375 242.1428985595703" height="200">
  <g transform="translate(90.00009155273438 10) rotate(0 2.7099990844726562 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(87.71862030029297 85.642822265625) rotate(0 7.1199951171875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(48.147178649902344 149.2142791748047) rotate(0 6.80999755859375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(135.04721069335938 147.78565979003906) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round"><g transform="translate(70.00006103515625 161.29702530418444) rotate(0 28.571456909179688 -0.6864076853945562)"><path d="M0 0 C9.52 -0.23, 47.62 -1.14, 57.14 -1.37 M0 0 C9.52 -0.23, 47.62 -1.14, 57.14 -1.37" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(86.57144165039062 105.2138667785772) rotate(0 -13.32079926665432 18.393089498894994)"><path d="M0 0 C-4.44 6.13, -22.2 30.66, -26.64 36.79 M0 0 C-4.44 6.13, -22.2 30.66, -26.64 36.79" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(104.28573608398438 105.67627072040335) rotate(0 15.850694695968343 19.018988968411605)"><path d="M0 0 C5.28 6.34, 26.42 31.7, 31.7 38.04 M0 0 C5.28 6.34, 26.42 31.7, 31.7 38.04" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(93.18247074756766 38.571441650390625) rotate(0 -0.3302059878339776 20.285690307617188)"><path d="M0 0 C-0.11 6.76, -0.55 33.81, -0.66 40.57 M0 0 C-0.11 6.76, -0.55 33.81, -0.66 40.57" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(73.42868041992188 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M0 0 C-6.76 8.95, -33.81 44.76, -40.57 53.71 M0 0 C-6.76 8.95, -33.81 44.76, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(73.42868041992188 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M-33.24 29.81 C-36.11 39.18, -38.99 48.55, -40.57 53.71 M-33.24 29.81 C-34.9 35.23, -36.56 40.64, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(73.42868041992188 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M-19.59 40.12 C-27.81 45.45, -36.04 50.78, -40.57 53.71 M-19.59 40.12 C-24.34 43.2, -29.09 46.28, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g mask="url(#mask-zK9cLogAqVV9WaNBeScmd)" stroke-linecap="round"><g transform="translate(55.142913818359375 184.85719299316406) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M0 0 C15.05 -0.1, 75.24 -0.48, 90.29 -0.57" stroke="#e03131" stroke-width="2.5" fill="none" stroke-dasharray="1.5 8"></path></g><g transform="translate(55.142913818359375 184.85719299316406) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M66.85 8.13 C71.84 6.27, 76.84 4.42, 90.29 -0.57" stroke="#e03131" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g><g transform="translate(55.142913818359375 184.85719299316406) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M66.74 -8.97 C71.76 -7.18, 76.77 -5.39, 90.29 -0.57" stroke="#e03131" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g></g><mask id="mask-zK9cLogAqVV9WaNBeScmd"><rect x="0" y="0" fill="#fff" width="245.42868041992188" height="285.4286346435547"></rect><rect x="94.66580200195312" y="172.07147216796875" fill="#000" width="11.239990234375" height="25" opacity="1"></rect></mask><g transform="translate(94.66580200195312 172.07147216796875) rotate(0 5.6199951171875 12.5)"><text x="5.6199951171875" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">x</text></g><g transform="translate(10 207.1428985595703) rotate(0 112.46990966796875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Did not "push onwards"</text></g></svg>

The right approach then is to postpone marking vertices visited. This gives us the right result `2, 3, 4, 1`. Let vertices be pushed to the stack multiple times; *visit* them from the most recently traversed edge.

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 140.2090110596016 194.8088534473485" height="160">
  <g transform="translate(67.1429443359375 10) rotate(0 2.7099990844726562 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(64.8614730834961 85.642822265625) rotate(0 7.1199951171875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(25.29003143310547 149.2142791748047) rotate(0 6.80999755859375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(112.1900634765625 147.78565979003906) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round"><g transform="translate(47.14291381835943 161.29454441711863) rotate(0 28.57145690917966 -0.6854106107120685)"><path d="M0 0 C9.52 -0.23, 47.62 -1.14, 57.14 -1.37 M0 0 C9.52 -0.23, 47.62 -1.14, 57.14 -1.37" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(63.71429443359375 105.19053641329424) rotate(0 -13.322925765192053 18.404754681536474)"><path d="M0 0 C-4.44 6.13, -22.2 30.67, -26.65 36.81 M0 0 C-4.44 6.13, -22.2 30.67, -26.65 36.81" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(81.4285888671875 105.65413369214286) rotate(0 15.852669093809425 19.03005748254185)"><path d="M0 0 C5.28 6.34, 26.42 31.72, 31.71 38.06 M0 0 C5.28 6.34, 26.42 31.72, 31.71 38.06" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(70.35662956109286 38.571441650390625) rotate(0 -0.34173385564980663 20.285690307617188)"><path d="M0 0 C-0.11 6.76, -0.57 33.81, -0.68 40.57 M0 0 C-0.11 6.76, -0.57 33.81, -0.68 40.57" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(50.571533203125 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M0 0 C-6.76 8.95, -33.81 44.76, -40.57 53.71 M0 0 C-6.76 8.95, -33.81 44.76, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(50.571533203125 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M-33.24 29.81 C-36.11 39.18, -38.99 48.55, -40.57 53.71 M-33.24 29.81 C-34.9 35.23, -36.56 40.64, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(50.571533203125 90.00003051757812) rotate(0 -20.2857666015625 26.85712432861328)"><path d="M-19.59 40.12 C-27.81 45.45, -36.04 50.78, -40.57 53.71 M-19.59 40.12 C-24.34 43.2, -29.09 46.28, -40.57 53.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(39.92324445803911 184.8088534473485) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M0 0 C15.05 -0.1, 75.24 -0.48, 90.29 -0.57 M0 0 C15.05 -0.1, 75.24 -0.48, 90.29 -0.57" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(39.92324445803911 184.8088534473485) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M66.85 8.13 C71.84 6.27, 76.84 4.42, 90.29 -0.57 M66.85 8.13 C76.12 4.69, 85.4 1.24, 90.29 -0.57" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(39.92324445803911 184.8088534473485) rotate(0 45.14288330078125 -0.2857208251953125)"><path d="M66.74 -8.97 C71.76 -7.18, 76.77 -5.39, 90.29 -0.57 M66.74 -8.97 C76.06 -5.65, 85.37 -2.32, 90.29 -0.57" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(90.00009155273438 89.4285888671875) rotate(0 -0.5714263916015625 -32.857154846191406)"><path d="M0 0 C-0.19 -10.95, -0.95 -54.76, -1.14 -65.71 M0 0 C-0.19 -10.95, -0.95 -54.76, -1.14 -65.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(90.00009155273438 89.4285888671875) rotate(0 -0.5714263916015625 -32.857154846191406)"><path d="M7.81 -42.37 C5.57 -48.22, 3.32 -54.07, -1.14 -65.71 M7.81 -42.37 C5.69 -47.92, 3.56 -53.46, -1.14 -65.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(90.00009155273438 89.4285888671875) rotate(0 -0.5714263916015625 -32.857154846191406)"><path d="M-9.28 -42.08 C-7.24 -48, -5.2 -53.93, -1.14 -65.71 M-9.28 -42.08 C-7.35 -47.69, -5.42 -53.3, -1.14 -65.71" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>

</div>

i.e. Give multiple edges: \\(a \rightarrow t, b \rightarrow t, c \rightarrow t\\) leading to the same destination vertex \\(t\\); the incomplete version of DFS (i.e. just BFS with stack) takes the first encountered edge \\(a \rightarrow t\\) to \\(t\\). The complete solution is to pick the last encountered edge \\(c \rightarrow t\\).

## DFS tree

If we are to trace the above DFS algorithm running on a graph, it'd lead us to a tree structure. Let's call it \\(G_{\pi}\\). \\(G_{\pi}\\) will have all the vertices of \\(G\\), meaning it'll be a spanning tree (or forest if there are multiple connected components). However, not all the edges of \\(G\\) will be present in \\(G_{\pi}\\). We classify edges of \\(G\\) in following manner:

1. *Tree edge:* an edge of \\(G\\) that is also present in \\(G_{\pi}\\). This is an edge DFS actually traversed.
2. *Back edge:* an edge of \\(G\\) leading a vertex back to its ancestor (proper or parent) in \\(G_{\pi}\\).
3. *Forward edge:* an edge of \\(G\\) leading a vertex to its proper descendant in \\(G_{\pi}\\). 
4. *Cross edge:* all other edges.

An undirected graph can only have #1 and #2, as there are no *one-way* edges. DFS will traverse would-be forward/cross edges, turning them into tree edges or back edges. 

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

Introduce a third state after *visited*, called *explored* to mark vertices whose neighbours are all visited. When an edge \\(u \rightarrow v\\) is first traversed, the color of \\(v\\) determines the type of this edge:

1. `WHITE` indicates it's a tree edge.
2. `GRAY` indicates it's a back edge.
3. `BLACK` indicates it's a forward or cross edge.

<div class="grid" markdown>


<div markdown>
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
          WHITE -> DFS(G, v)
          GRAY  -> # u → v is back edge
          BLACK -> # u → v is forward/cross edge
      u.color = BLACK
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
      S.push(<s, s>) # tuple
      while S is not empty:
        p, u = S.pop()
        print "$p-$u $u.color"
        if u.color == WHITE:
          u.color = GRAY

          explored = true
          for (u, v) in G:
            S.push(<u, v>)
            if v.color == WHITE:
              explored = false
        
          if explored:
            u.color = BLACK
    ```
</div>

<div markdown>
=== "recursive"

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

    ```kotlin linenums="1"
    fun Graph.dfs() {
      val color = HashMap<Int, Color>()
      for (u in vertices)
        if ((color[u] ?: Color.WHITE) == Color.WHITE)
          dfs(u, color)
    }

    fun Graph.dfs(
      source: Int,
      color: HashMap<Int, Color> = HashMap()
    ) {
      val stack = ArrayDeque<Record>().apply { this.add(Record(source, source, 0)) }
      while (stack.isNotEmpty()) {
        val (p, u, i) = stack.removeFirst()
        val childIndent = i + "$p-".length
        val c = color[u] ?: Color.WHITE
        println(" ".repeat(i) + "$p-$u ${c.type}")

        if (c == Color.WHITE) {
          color[u] = Color.GRAY
          
          var explored = true
          for (v in neighbours(u)) {
            stack.addFirst(Record(u, v, childIndent))
            if ((color[v] ?: Color.WHITE) == Color.WHITE) 
              explored = false
          }
          
          if (explored) 
            color[u] = Color.BLACK
        }
      }
    }

    private data class Record(val src: Int, val dst: Int, val indent: Int)

    enum class Color(val type: String) {
      WHITE("tree"),
      GRAY("back"),
      BLACK("forward/cross")
    }
    ```
</div>

### Example run

<span>

=== "output from recursive"

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

=== "output from iterative"

    ```ruby linenums="1"
    1-1 tree
      1-4 tree
        4-3 tree
          3-4 back
          3-1 back
          3-2 tree
            2-4 back
            2-3 back
            2-1 back
        4-1 back
        4-2 forward/cross
      1-3 back
      1-2 forward/cross
    ```

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 141.51434326171875 149.64280700683594" height="120" style="margin-top: 30px">
  <g transform="translate(65.56714630126953 10) rotate(0 2.7099990844726562 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(62.71437072753906 74.92847442626953) rotate(0 7.1199951171875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(10 112.64277648925781) rotate(0 6.80999755859375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(118.71435546875 114.64280700683594) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round"><g transform="translate(59.85295867919922 88.45775341974183) rotate(0 -16.562538052309662 12.655519062760078)"><path d="M0 0 C-5.52 4.22, -27.6 21.09, -33.13 25.31 M0 0 C-5.52 4.22, -27.6 21.09, -33.13 25.31" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(80.42436981201172 90.3067120074881) rotate(0 17.787845611572266 15.08297932621204)"><path d="M0 0 C5.93 5.03, 29.65 25.14, 35.58 30.17 M0 0 C5.93 5.03, 29.65 25.14, 35.58 30.17" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(67.91935867542236 36) rotate(0 -0.07211355440611555 18.964237213134766)"><path d="M0 0 C-0.02 6.32, -0.12 31.61, -0.14 37.93 M0 0 C-0.02 6.32, -0.12 31.61, -0.14 37.93" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(29.567237854003963 124.88887204649251) rotate(0 41.42855834960935 -0.034995567774018355)"><path d="M0 0 C13.81 -0.01, 69.05 -0.06, 82.86 -0.07 M0 0 C13.81 -0.01, 69.05 -0.06, 82.86 -0.07" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(15.52679134263741 111.14274597167969) rotate(0 21.877370472480123 -40.71464349171035)"><path d="M0 0 C7.29 -13.57, 36.46 -67.86, 43.75 -81.43 M0 0 C7.29 -13.57, 36.46 -67.86, 43.75 -81.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(78.13867950439453 29.95840096158105) rotate(0 23.775752241648377 41.44933498063526)"><path d="M0 0 C7.93 13.82, 39.63 69.08, 47.55 82.9 M0 0 C7.93 13.82, 39.63 69.08, 47.55 82.9" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>

=== "output from recursive"

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

=== "output from iterative"

    ```ruby linenums="1"
    0-0 tree
      0-7 tree
        7-0 back
        7-1 tree
          1-7 back
        7-4 tree
          4-7 back
          4-3 tree
            3-5 tree
              5-3 back
              5-0 back
              5-4 back
            3-4 back
          4-5 forward/cross
          4-6 tree
            6-4 back
            6-2 tree
              2-6 back
              2-0 back
      0-5 forward/cross
      0-2 forward/cross
    ```

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 180.49137115478516 211.7143096923828" height="160" style="margin-top: 30px">
  <g transform="translate(10 10.500015258789062) rotate(0 6.879997253417969 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(93.83417510986328 10) rotate(0 7.1199951171875 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(16.83423614501953 176.7143096923828) rotate(0 6.17999267578125 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">5</text></g><g transform="translate(100.4056167602539 176.14280700683594) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g transform="translate(55.54853057861328 130.8571319580078) rotate(0 6.80999755859375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round"><g transform="translate(33.999969482421875 188.7857208251953) rotate(0 29.714309692382812 0)"><path d="M0 0 C9.9 0, 49.52 0, 59.43 0 M0 0 C9.9 0, 49.52 0, 59.43 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(31.71429443359375 173.35716247558594) rotate(0 9.714263916015625 -13.142868041992188)"><path d="M0 0 C3.24 -4.38, 16.19 -21.9, 19.43 -26.29 M0 0 C3.24 -4.38, 16.19 -21.9, 19.43 -26.29" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(75.142822265625 146.5000457763672) rotate(0 12 13.714279174804688)"><path d="M0 0 C4 4.57, 20 22.86, 24 27.43 M0 0 C4 4.57, 20 22.86, 24 27.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(100.11991119384766 79.99998474121094) rotate(0 5.379997253417969 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">7</text></g><g transform="translate(55.977088928222656 76.42860412597656) rotate(0 2.7099990844726562 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g stroke-linecap="round"><g transform="translate(67.71432495117188 90.38973310592377) rotate(0 12.85711669921875 0.028216028677121585)"><path d="M0 0 C4.29 0.01, 21.43 0.05, 25.71 0.06 M0 0 C4.29 0.01, 21.43 0.05, 25.71 0.06" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(105.1629345563212 105.999984741211) rotate(0 0.9548937491055938 32.2500305175781)"><path d="M0 0 C0.32 10.75, 1.59 53.75, 1.91 64.5 M0 0 C0.32 10.75, 1.59 53.75, 1.91 64.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(15.71429443359375 32.78572082519531) rotate(0 2.85711669921875 69.71430969238281)"><path d="M0 0 C0.95 23.24, 4.76 116.19, 5.71 139.43 M0 0 C0.95 23.24, 4.76 116.19, 5.71 139.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(27.142822265625 20.51993882605143) rotate(0 31.142852783203125 0.22967394617921855)"><path d="M0 0 C10.38 0.08, 51.9 0.38, 62.29 0.46 M0 0 C10.38 0.08, 51.9 0.38, 62.29 0.46" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(22.571441650390625 28.214279174804688) rotate(0 37.714263916015625 24.857147216796875)"><path d="M0 0 C12.57 8.29, 62.86 41.43, 75.43 49.71 M0 0 C12.57 8.29, 62.86 41.43, 75.43 49.71" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(157.6913833618164 76.85713195800781) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">6</text></g><g stroke-linecap="round"><g transform="translate(111.71429443359375 29.928573608398438) rotate(0 23.428573608398438 23.428573608398438)"><path d="M0 0 C7.81 7.81, 39.05 39.05, 46.86 46.86 M0 0 C7.81 7.81, 39.05 39.05, 46.86 46.86" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(162.57144165039062 100.21434020996094) rotate(0 -23.14288330078125 40.85713195800781)"><path d="M0 0 C-7.71 13.62, -38.57 68.1, -46.29 81.71 M0 0 C-7.71 13.62, -38.57 68.1, -46.29 81.71" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>

</div>

<hr>

## Parenthesis property

Consider any two vertices \\(u\\) and \\(v\\): the ranges \\([u_{s}, u_{f}]\\) and \\([v_{s}, v_{f}]\\) will either contain each other or will be completely disjoint, never partially overlapping. An edge \\(u \rightarrow v\\) is then: 

1. Tree/forward edge if \\( \underset{u}{\big\[} \; \underset{v}{\big\[} \; \underset{v}{\big\]} \; \underset{u}{\big\]} \\).
2. Back edge if \\( \underset{v}{\big\[} \; \underset{u}{\big\[} \; \underset{u}{\big\]} \; \underset{v}{\big\]} \\).
3. Cross edge if \\( \underset{u}{\big\[} \; \underset{u}{\big\]} \; \underset{v}{\big\[} \; \underset{v}{\big\]} \\) or \\( \underset{v}{\big\[} \; \underset{v}{\big\]} \; \underset{u}{\big\[} \; \underset{u}{\big\]} \\).
