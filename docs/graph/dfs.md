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

## Extras

### #1 DFS tree

If we are to trace the above DFS algorithm running on a graph, it'd lead to us to a tree structure. Let's call it \\(G_{\pi}\\). \\(G_{\pi}\\) will have all the vertices of \\(G\\), meaning it'll be a spanning tree (or forest if there are multiple connected components). However, not all the edges of \\(G\\) will be present in \\(G_{\pi}\\). We classify edges of \\(G\\) in following manner:

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


### #2 *Explore* progress

What about directed graph?