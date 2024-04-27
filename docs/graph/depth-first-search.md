# Depth-first Search

## About
DFS is a linear time search and traversal algorithm, i.e. the runtime is \\(O(V+E)\\). In worst case it takes \\(O(V)\\) space to store the stack of vertices.

## Pseudocode

<div class="grid" markdown>

```ruby title="DFS(u) recursive"
mark u as visited
for each edge (u, v):
  if v is not visited:
    DFS(v)
```

```ruby title="DFS(u) iterative"
S = stack.push(u)
while S is not empty:
  v = S.pop()
  if v is not visited:
    mark v as visted
    for each edge (v, w):
      S.push(w)
```

</div>

Notice that in iterative approach, we push vertices on stack regardless of whether they are already visited. Rather, discovered status is checked post `pop`. 

If \\(a, b, c\\) are adjacent to \\(u\\), and the recursive DFS visits them in said order, then iterative implementation will visit them in reverse order of \\(c, b, a\\).

## Enhancements

We now consider the following enhancements on this simple version of DFS:

1. Expand the concept of `visited`. 
    - Consider a vertex `undiscovered` (_WHITE_) when it is not yet visited.
    - `discovered` (_GRAY_) when it is visted.
    - `explored` (_BLACK_) when its adjacency list has been examined.
2. Mark the time when a vertex is discovered as `pre` and when it's explored as `post`.
3. If a vertex \\(v\\) is discovered following the edge \\((u, v)\\), mark \\(u\\) as \\(v\\)'s predecessor: \\(v_\pi=u\\).

<div class="grid" markdown>

```ruby title="DFS(G)"
for u in G:
  u.color = WHITE
  u.π = nil

time = 0
for u in G:
  if u.color == WHITE:
    DFS(G, u)
```

```ruby title="DFS(G, u)"
u.pre = time++
u.color = GRAY

for each (u, v) in G:
  if v.color == WHITE:
    v.π = u
    DFS(G, v)

u.post = time++
u.color = BLACK
```

</div>

Each `DFS(G, u)` call yields a depth-first tree \\(G_\pi\\), a structural description of the traversal. \\(G_\pi\\) is a subgraph of the original graph \\(G\\).

- In an undirected graph \\(G\\), an edge is called ==tree edge== if it's present in \\(G_\pi\\) too. Otherwise, it's a nontree edge. 
- In a directed graph, you can also have:
    - _Forward edge_ leading a vertex to its nonchild descendant in \\(G_\pi\\).
    - _Back edge_ leading a vertex to its ancestor in \\(G_\pi\\).
    - _Cross edge_ lead to neither descendant nor ancestor. Rather it's a node that's already explored (_BLACK_).

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 315.01573181152344 342.2142639160156" height="200">
  <g stroke-linecap="round" transform="translate(139.14279174804688 10) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(158.64758336067615 22.675883860929588) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">a</text></g><g stroke-linecap="round" transform="translate(138.57144165039062 159.4285888671875) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(158.0762332630199 172.10447272811706) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">b</text></g><g stroke-linecap="round" transform="translate(10 279.4285583496094) rotate(0 25.142837524414062 24)"><path d="M50.29 24 C50.29 25.39, 50.16 26.8, 49.9 28.17 C49.65 29.54, 49.27 30.9, 48.77 32.21 C48.27 33.51, 47.64 34.8, 46.92 36 C46.19 37.2, 45.34 38.36, 44.4 39.43 C43.47 40.49, 42.42 41.49, 41.3 42.39 C40.19 43.28, 38.97 44.09, 37.71 44.78 C36.45 45.48, 35.11 46.08, 33.74 46.55 C32.37 47.03, 30.94 47.39, 29.51 47.64 C28.08 47.88, 26.6 48, 25.14 48 C23.69 48, 22.21 47.88, 20.78 47.64 C19.34 47.39, 17.91 47.03, 16.54 46.55 C15.18 46.08, 13.83 45.48, 12.57 44.78 C11.31 44.09, 10.1 43.28, 8.98 42.39 C7.87 41.49, 6.82 40.49, 5.88 39.43 C4.95 38.36, 4.1 37.2, 3.37 36 C2.64 34.8, 2.01 33.51, 1.52 32.21 C1.02 30.9, 0.63 29.54, 0.38 28.17 C0.13 26.8, 0 25.39, 0 24 C0 22.61, 0.13 21.2, 0.38 19.83 C0.63 18.46, 1.02 17.1, 1.52 15.79 C2.01 14.49, 2.64 13.2, 3.37 12 C4.1 10.8, 4.95 9.64, 5.88 8.57 C6.82 7.51, 7.87 6.51, 8.98 5.61 C10.1 4.72, 11.31 3.91, 12.57 3.22 C13.83 2.52, 15.18 1.92, 16.54 1.45 C17.91 0.97, 19.34 0.61, 20.78 0.36 C22.21 0.12, 23.69 0, 25.14 0 C26.6 0, 28.08 0.12, 29.51 0.36 C30.94 0.61, 32.37 0.97, 33.74 1.45 C35.11 1.92, 36.45 2.52, 37.71 3.22 C38.97 3.91, 40.19 4.72, 41.3 5.61 C42.42 6.51, 43.47 7.51, 44.4 8.57 C45.34 9.64, 46.19 10.8, 46.92 12 C47.64 13.2, 48.27 14.49, 48.77 15.79 C49.27 17.1, 49.65 18.46, 49.9 19.83 C50.16 21.2, 50.22 23.31, 50.29 24 C50.35 24.69, 50.35 23.31, 50.29 24" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(29.504791612629276 291.4579956011322) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">c</text></g><g stroke-linecap="round" transform="translate(254.00009155273438 284.2142639160156) rotate(0 25.142837524414062 24)"><path d="M50.29 24 C50.29 25.39, 50.16 26.8, 49.9 28.17 C49.65 29.54, 49.27 30.9, 48.77 32.21 C48.27 33.51, 47.64 34.8, 46.92 36 C46.19 37.2, 45.34 38.36, 44.4 39.43 C43.47 40.49, 42.42 41.49, 41.3 42.39 C40.19 43.28, 38.97 44.09, 37.71 44.78 C36.45 45.48, 35.11 46.08, 33.74 46.55 C32.37 47.03, 30.94 47.39, 29.51 47.64 C28.08 47.88, 26.6 48, 25.14 48 C23.69 48, 22.21 47.88, 20.78 47.64 C19.34 47.39, 17.91 47.03, 16.54 46.55 C15.18 46.08, 13.83 45.48, 12.57 44.78 C11.31 44.09, 10.1 43.28, 8.98 42.39 C7.87 41.49, 6.82 40.49, 5.88 39.43 C4.95 38.36, 4.1 37.2, 3.37 36 C2.64 34.8, 2.01 33.51, 1.52 32.21 C1.02 30.9, 0.63 29.54, 0.38 28.17 C0.13 26.8, 0 25.39, 0 24 C0 22.61, 0.13 21.2, 0.38 19.83 C0.63 18.46, 1.02 17.1, 1.52 15.79 C2.01 14.49, 2.64 13.2, 3.37 12 C4.1 10.8, 4.95 9.64, 5.88 8.57 C6.82 7.51, 7.87 6.51, 8.98 5.61 C10.1 4.72, 11.31 3.91, 12.57 3.22 C13.83 2.52, 15.18 1.92, 16.54 1.45 C17.91 0.97, 19.34 0.61, 20.78 0.36 C22.21 0.12, 23.69 0, 25.14 0 C26.6 0, 28.08 0.12, 29.51 0.36 C30.94 0.61, 32.37 0.97, 33.74 1.45 C35.11 1.92, 36.45 2.52, 37.71 3.22 C38.97 3.91, 40.19 4.72, 41.3 5.61 C42.42 6.51, 43.47 7.51, 44.4 8.57 C45.34 9.64, 46.19 10.8, 46.92 12 C47.64 13.2, 48.27 14.49, 48.77 15.79 C49.27 17.1, 49.65 18.46, 49.9 19.83 C50.16 21.2, 50.22 23.31, 50.29 24 C50.35 24.69, 50.35 23.31, 50.29 24" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(273.5048831653637 296.24370116753846) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">d</text></g><g stroke-linecap="round"><g transform="translate(163.37071464165092 59.984379356472886) rotate(0 -0.13666379447749932 47.941288216385786)"><path d="M0 0 C-0.05 15.98, -0.23 79.9, -0.27 95.88 M0 0 C-0.05 15.98, -0.23 79.9, -0.27 95.88" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(163.37071464165092 59.984379356472886) rotate(0 -0.13666379447749932 47.941288216385786)"><path d="M-8.76 72.37 C-5.73 80.76, -2.7 89.16, -0.27 95.88 M-8.76 72.37 C-6.15 79.59, -3.55 86.81, -0.27 95.88" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(163.37071464165092 59.984379356472886) rotate(0 -0.13666379447749932 47.941288216385786)"><path d="M8.34 72.41 C5.27 80.79, 2.19 89.17, -0.27 95.88 M8.34 72.41 C5.7 79.62, 3.05 86.83, -0.27 95.88" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(142.43286812998065 201.69921865240815) rotate(0 -42.858337594699776 41.58812131581146)"><path d="M0 0 C-14.29 13.86, -71.43 69.31, -85.72 83.18 M0 0 C-14.29 13.86, -71.43 69.31, -85.72 83.18" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(142.43286812998065 201.69921865240815) rotate(0 -42.858337594699776 41.58812131581146)"><path d="M-74.81 60.68 C-77.5 66.22, -80.19 71.77, -85.72 83.18 M-74.81 60.68 C-79.16 69.64, -83.5 78.61, -85.72 83.18" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(142.43286812998065 201.69921865240815) rotate(0 -42.858337594699776 41.58812131581146)"><path d="M-62.9 72.95 C-68.52 75.47, -74.15 77.99, -85.72 83.18 M-62.9 72.95 C-71.99 77.03, -81.08 81.1, -85.72 83.18" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(182.66024711389116 201.7212732325748) rotate(0 39.974543860644815 43.434498384511045)"><path d="M0 0 C13.32 14.48, 66.62 72.39, 79.95 86.87 M0 0 C13.32 14.48, 66.62 72.39, 79.95 86.87" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(182.66024711389116 201.7212732325748) rotate(0 39.974543860644815 43.434498384511045)"><path d="M57.75 75.37 C63.34 78.27, 68.94 81.17, 79.95 86.87 M57.75 75.37 C63.44 78.32, 69.14 81.27, 79.95 86.87" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(182.66024711389116 201.7212732325748) rotate(0 39.974543860644815 43.434498384511045)"><path d="M70.33 63.79 C72.75 69.61, 75.18 75.42, 79.95 86.87 M70.33 63.79 C72.8 69.71, 75.27 75.63, 79.95 86.87" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g mask="url(#mask-2vU4HhOY8hmDa-73jEjy8)" stroke-linecap="round"><g transform="translate(191.82155710459756 53.412274979865686) rotate(0 41.70801384776439 113.25145475098907)"><path d="M0 0 C12.03 16.99, 58.28 64.19, 72.18 101.94 C86.08 139.7, 81.54 205.74, 83.42 226.5" stroke="#1971c2" stroke-width="2.5" fill="none" stroke-dasharray="1.5 8"></path></g><g transform="translate(191.82155710459756 53.412274979865686) rotate(0 41.70801384776439 113.25145475098907)"><path d="M74.36 203.2 C77.26 210.66, 80.16 218.11, 83.42 226.5" stroke="#1971c2" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g><g transform="translate(191.82155710459756 53.412274979865686) rotate(0 41.70801384776439 113.25145475098907)"><path d="M91.46 202.83 C88.88 210.41, 86.31 217.98, 83.42 226.5" stroke="#1971c2" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g></g><mask id="mask-2vU4HhOY8hmDa-73jEjy8"><rect x="0" y="0" fill="#fff" width="375.23758480012634" height="379.9151844818438"></rect><rect x="222.98448181152344" y="143.357177734375" fill="#000" width="82.03125" height="24" opacity="1"></rect></mask><g transform="translate(222.98448181152344 143.357177734375) rotate(0 10.545089140838513 23.306551996479755)"><text x="41.015625" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">forward</text></g><g mask="url(#mask-ImAv3F1wjLEC67P8k7aq8)" stroke-linecap="round"><g transform="translate(40.00001525878906 271.3571472167969) rotate(0 50.285736083984375 -109.7142562866211)"><path d="M0 0 C2.1 -22.1, -4.19 -96, 12.57 -132.57 C29.33 -169.14, 85.9 -204.95, 100.57 -219.43" stroke="#e03131" stroke-width="2.5" fill="none" stroke-dasharray="1.5 8"></path></g><g transform="translate(40.00001525878906 271.3571472167969) rotate(0 50.285736083984375 -109.7142562866211)"><path d="M87.79 -197.94 C91.01 -203.36, 94.24 -208.78, 100.57 -219.43" stroke="#e03131" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g><g transform="translate(40.00001525878906 271.3571472167969) rotate(0 50.285736083984375 -109.7142562866211)"><path d="M76.97 -211.18 C82.92 -213.26, 88.87 -215.34, 100.57 -219.43" stroke="#e03131" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g></g><mask id="mask-ImAv3F1wjLEC67P8k7aq8"><rect x="0" y="0" fill="#fff" width="240.5714874267578" height="590.7856597900391"></rect><rect x="29.133926391601562" y="126.7857666015625" fill="#000" width="46.875" height="24" opacity="1"></rect></mask><g transform="translate(29.133926391601562 126.7857666015625) rotate(0 61.151824951171875 34.85712432861328)"><text x="23.4375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">back</text></g><g mask="url(#mask-gubVuGPImeTlov9qURLAg)" stroke-linecap="round"><g transform="translate(246.8572235107422 310.7857971191406) rotate(0 -91.71432495117188 -2)"><path d="M0 0 C-30.57 -0.67, -152.86 -3.33, -183.43 -4" stroke="#f08c00" stroke-width="2.5" fill="none" stroke-dasharray="1.5 8"></path></g><g transform="translate(246.8572235107422 310.7857971191406) rotate(0 -91.71432495117188 -2)"><path d="M-159.76 -12.04 C-166.13 -9.87, -172.5 -7.71, -183.43 -4" stroke="#f08c00" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g><g transform="translate(246.8572235107422 310.7857971191406) rotate(0 -91.71432495117188 -2)"><path d="M-160.13 5.06 C-166.4 2.62, -172.67 0.18, -183.43 -4" stroke="#f08c00" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g></g><mask id="mask-gubVuGPImeTlov9qURLAg"><rect x="0" y="0" fill="#fff" width="530.2858734130859" height="414.7857971191406"></rect><rect x="125.84602355957031" y="296.7857971191406" fill="#000" width="58.59375" height="24" opacity="1"></rect></mask><g transform="translate(125.84602355957031 296.7857971191406) rotate(0 29.296875 12)"><text x="29.296875" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">cross</text></g></svg>

## Properties

For any given vertices \\(u\\) and \\(v\\), the ranges \\([u_{pre}, u_{post}]\\) and \\([v_{pre}, v_{post}]\\) either contain each other or are disjoint, but never interweaving. An edge \\((u, v)\\) is: 

- Tree/Forward edge if \\( \underset{u}{\big\[} \; \underset{v}{\big\[} \; \underset{v}{\big\]} \; \underset{u}{\big\]} \\).
- Back edge if \\( \underset{v}{\big\[} \; \underset{u}{\big\[} \; \underset{u}{\big\]} \; \underset{v}{\big\]} \\).
- Cross edge if \\( \underset{v}{\big\[} \; \underset{v}{\big\[} \; \underset{u}{\big\]} \; \underset{u}{\big\]} \\).

Similarly, when a vertex \\(v\\) is first discovered following the edge \\((u, v)\\), then the edge can be distinguished based on \\(v\\)'s color:

- Tree edge if `v.color = WHITE`.
- Back edge if `v.color = GRAY`.
- Forward/Cross edge if `v.color = BLACK`.


## Recursive implementation

```kotlin linenums="1"
fun recursive(
  graph: Graph, source: Int, 
  colorMap: MutableMap<Int, Color> = HashMap(),
  indent: Int = 0
) {
  colorMap[source] = Color.GRAY // vertex discovered

  for (dst in graph.neighbours(source)) {
    val dstColor = colorMap[dst] ?: Color.WHITE
    val childIndent = report(source, dst, dstColor, indent) // verbose only
    if (dstColor == Color.WHITE)
      recursive(graph, dst, colorMap, childIndent)
  }

  colorMap[source] = Color.BLACK // vertex explored
}

private fun report(src: Int, dst: Int, dstColor: Color, indent: Int): Int {
  val type = when (dstColor) {
    Color.WHITE -> "tree"
    Color.GRAY -> "back"
    else -> "forward/cross"
  }
  val row = " ".repeat(indent) + "$src-$dst"
  println("$row $type")
  return row.length - 1
}

enum class Color { WHITE, GRAY, BLACK }
```

<div class="grid" markdown>

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 333.71435546875 355.57130432128906" width="100%">
  <g stroke-linecap="round" transform="translate(10 10) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(29.504791612629276 22.67588386092956) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g stroke-linecap="round" transform="translate(141.00009155273438 10.571395874023438) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(160.50488316536365 23.247279734952997) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g stroke-linecap="round" transform="translate(273.4286804199219 125.57148742675781) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(292.9334720325512 138.24737128768737) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">6</text></g><g stroke-linecap="round" transform="translate(70.21440124511719 130.42858123779297) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(89.71919285774646 143.10446509872253) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g stroke-linecap="round" transform="translate(170.3573455810547 126.42850494384766) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(189.86213719368402 139.10438880477722) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">7</text></g><g stroke-linecap="round"><g transform="translate(123.40764814400228 153.8585892113216) rotate(0 21.474215110283893 -0.005780430953961968)"><path d="M0 0 C7.16 0, 35.79 -0.01, 42.95 -0.01 M0 0 C7.16 0, 35.79 -0.01, 42.95 -0.01" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(62.28578186035156 33.07148742675781) rotate(0 38.000030517578125 -0.5714569091796875)"><path d="M0 0 C12.67 -0.19, 63.33 -0.95, 76 -1.14 M0 0 C12.67 -0.19, 63.33 -0.95, 76 -1.14" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(195.4286346435547 43.35716247558594) rotate(0 42.2857666015625 41.71427917480469)"><path d="M0 0 C14.1 13.9, 70.48 69.52, 84.57 83.43 M0 0 C14.1 13.9, 70.48 69.52, 84.57 83.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(60.00007629394531 51.35716247558594) rotate(0 56.57142639160156 39.142852783203125)"><path d="M0 0 C18.86 13.05, 94.29 65.24, 113.14 78.29 M0 0 C18.86 13.05, 94.29 65.24, 113.14 78.29" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(124.42864990234375 210.8571014404297) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(143.93344151497303 223.53298530135925) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round" transform="translate(192.28579711914062 293.57142639160156) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(211.79058873176996 306.2473102525312) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round" transform="translate(50.285797119140625 296.57130432128906) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(69.7905887317699 309.2471881822187) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">5</text></g><g stroke-linecap="round"><g transform="translate(37.14295959472656 67.35710144042969) rotate(0 15.714248657226562 113.14292907714844)"><path d="M0 0 C5.24 37.71, 26.19 188.57, 31.43 226.29 M0 0 C5.24 37.71, 26.19 188.57, 31.43 226.29" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(90.28575134277344 298.2143096923828) rotate(0 19.714324951171875 -21.71429443359375)"><path d="M0 0 C6.57 -7.24, 32.86 -36.19, 39.43 -43.43 M0 0 C6.57 -7.24, 32.86 -36.19, 39.43 -43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(105.14292907714844 323.3572540283203) rotate(0 41.714324951171875 -0.2857666015625)"><path d="M0 0 C13.9 -0.1, 69.52 -0.48, 83.43 -0.57 M0 0 C13.9 -0.1, 69.52 -0.48, 83.43 -0.57" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(165.7144012451172 259.3572235107422) rotate(0 16.28570556640625 17.714248657226562)"><path d="M0 0 C5.43 5.9, 27.14 29.52, 32.57 35.43 M0 0 C5.43 5.9, 27.14 29.52, 32.57 35.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(233.71446228027344 298.7857208251953) rotate(0 28.571380615234375 -60.5714111328125)"><path d="M0 0 C9.52 -20.19, 47.62 -100.95, 57.14 -121.14 M0 0 C9.52 -20.19, 47.62 -100.95, 57.14 -121.14" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(204.00010681152344 176.50001525878906) rotate(0 6.5714111328125 54.857177734375)"><path d="M0 0 C2.19 18.29, 10.95 91.43, 13.14 109.71 M0 0 C2.19 18.29, 10.95 91.43, 13.14 109.71" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask></svg>

```
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
      4-7 tree
        7-0 back
        7-1 tree
          1-7 back
        7-4 back
      4-3 forward/cross
0-5 forward/cross
0-7 forward/cross
```

</div>

## Iterative implementation

Things are harder in iterative implementation.

<div class="grid" markdown>

```ruby title="incorrect implementation"
...
v.color = GRAY # no-op


if v is not visited:
  mark v as visted
  for each edge (v, w):
    S.push(w)




v.color = BLACK # overwrites GRAY
```

```ruby title="correct implementation" hl_lines="4 9 10 12 13"
...
v.color = GRAY

explored = true
if v is not visited:
  mark v as visted
  for each edge (v, w):
    S.push(w)
    if w is WHITE:
      explored = false

if explored:
  v.color = BLACK
```

</div>

In recursive implementation, vertices adjacent to \\(v\\) will see \\(v\\) as `GRAY` and thus see \\((v, u)\\) as back edge. But in iterative impelementation, they'd only ever encounter \\(v\\) as `BLACK` and mistake \\((v, u)\\) as forward/cross edge.

To solve this, we mark a vertex `BLACK` only if the loop prior did not find any undiscovered neighbours.

```kotlin linenums="1"
fun iterative(graph: Graph, source: Int) {
  val color = HashMap<Int, Color>()
  val stack = ArrayDeque(listOf(Edge(source, source, 0)))

  while (stack.isNotEmpty()) {
    val (p: Int, u: Int, i: Int) = stack.removeFirst()
    val c = color[u] ?: Color.WHITE
    val ci = report(p, u, c, i)

    if (c == Color.WHITE) {
      color[u] = Color.GRAY

      var explored = true
      for (v in graph.neighbours(u)) {
        val vc = color[v] ?: Color.WHITE
        stack.addFirst(Edge(u, v, ci))
        if (vc == Color.WHITE) 
          explored = false
      }

      if (explored)
        color[u] = Color.BLACK
    }
  }
}

data class Edge(var pred: Int, var vertex: Int, var indent: Int)

private fun report(
  src: Int, dst: Int, dstColor: Color, indent: Int
): Int {
  val type = when (dstColor) {
    Color.WHITE -> "tree"
    Color.GRAY -> "back"
    else -> "forward/cross"
  }
  val row = " ".repeat(indent) + "$src-$dst"
  println("$row $type")
  return row.length - 1
}

enum class Color { WHITE, GRAY, BLACK }
```

<div class="grid" markdown>

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 333.71435546875 355.57130432128906" width="100%">
  <g stroke-linecap="round" transform="translate(10 10) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(29.504791612629276 22.67588386092956) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g stroke-linecap="round" transform="translate(141.00009155273438 10.571395874023438) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(160.50488316536365 23.247279734952997) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g stroke-linecap="round" transform="translate(273.4286804199219 125.57148742675781) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(292.9334720325512 138.24737128768737) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">6</text></g><g stroke-linecap="round" transform="translate(70.21440124511719 130.42858123779297) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(89.71919285774646 143.10446509872253) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g stroke-linecap="round" transform="translate(170.3573455810547 126.42850494384766) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(189.86213719368402 139.10438880477722) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">7</text></g><g stroke-linecap="round"><g transform="translate(123.40764814400228 153.8585892113216) rotate(0 21.474215110283893 -0.005780430953961968)"><path d="M0 0 C7.16 0, 35.79 -0.01, 42.95 -0.01 M0 0 C7.16 0, 35.79 -0.01, 42.95 -0.01" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(62.28578186035156 33.07148742675781) rotate(0 38.000030517578125 -0.5714569091796875)"><path d="M0 0 C12.67 -0.19, 63.33 -0.95, 76 -1.14 M0 0 C12.67 -0.19, 63.33 -0.95, 76 -1.14" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(195.4286346435547 43.35716247558594) rotate(0 42.2857666015625 41.71427917480469)"><path d="M0 0 C14.1 13.9, 70.48 69.52, 84.57 83.43 M0 0 C14.1 13.9, 70.48 69.52, 84.57 83.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(60.00007629394531 51.35716247558594) rotate(0 56.57142639160156 39.142852783203125)"><path d="M0 0 C18.86 13.05, 94.29 65.24, 113.14 78.29 M0 0 C18.86 13.05, 94.29 65.24, 113.14 78.29" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(124.42864990234375 210.8571014404297) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(143.93344151497303 223.53298530135925) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round" transform="translate(192.28579711914062 293.57142639160156) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(211.79058873176996 306.2473102525312) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round" transform="translate(50.285797119140625 296.57130432128906) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(69.7905887317699 309.2471881822187) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">5</text></g><g stroke-linecap="round"><g transform="translate(37.14295959472656 67.35710144042969) rotate(0 15.714248657226562 113.14292907714844)"><path d="M0 0 C5.24 37.71, 26.19 188.57, 31.43 226.29 M0 0 C5.24 37.71, 26.19 188.57, 31.43 226.29" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(90.28575134277344 298.2143096923828) rotate(0 19.714324951171875 -21.71429443359375)"><path d="M0 0 C6.57 -7.24, 32.86 -36.19, 39.43 -43.43 M0 0 C6.57 -7.24, 32.86 -36.19, 39.43 -43.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(105.14292907714844 323.3572540283203) rotate(0 41.714324951171875 -0.2857666015625)"><path d="M0 0 C13.9 -0.1, 69.52 -0.48, 83.43 -0.57 M0 0 C13.9 -0.1, 69.52 -0.48, 83.43 -0.57" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(165.7144012451172 259.3572235107422) rotate(0 16.28570556640625 17.714248657226562)"><path d="M0 0 C5.43 5.9, 27.14 29.52, 32.57 35.43 M0 0 C5.43 5.9, 27.14 29.52, 32.57 35.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(233.71446228027344 298.7857208251953) rotate(0 28.571380615234375 -60.5714111328125)"><path d="M0 0 C9.52 -20.19, 47.62 -100.95, 57.14 -121.14 M0 0 C9.52 -20.19, 47.62 -100.95, 57.14 -121.14" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(204.00010681152344 176.50001525878906) rotate(0 6.5714111328125 54.857177734375)"><path d="M0 0 C2.19 18.29, 10.95 91.43, 13.14 109.71 M0 0 C2.19 18.29, 10.95 91.43, 13.14 109.71" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask></svg>

```
0-0 tree
  0-7 tree
    7-4 tree
      4-3 tree
        3-5 tree
          5-3 back
          5-0 back
          5-4 back
        3-4 back
      4-7 back
      4-5 forward/cross
      4-6 tree
        6-4 back
        6-2 tree
          2-6 back
          2-0 back
    7-1 tree
      1-7 back
    7-0 back
  0-5 forward/cross
  0-2 forward/cross
```

</div>

## Comparison to BFS

<div class="grid" markdown>

```ruby title="BFS(u) iterative" hl_lines="2 8 9"
Q = stack.push(u)
mark u as visited
while Q is not empty:
  v = Q.poll()


  for each edge (v, w):
    if w is not visted:
      mark w as visited
      Q.push(w)
```

```ruby title="DFS(u) iterative" hl_lines="5 6"
S = stack.push(u)

while S is not empty:
  v = S.pop()
  if v is not visited:
    mark v as visted
    for each edge (v, w):
      S.push(w)
```

</div>

Why the iterative DFS postpone checking the `visited` status of a vertex? Why not check it before pushing it on stack? 

See in generalized search algorithm, we can end up "bagging" same vertex multiple times from different routes \\(\[...p_1 \rightarrow u ...... p_2 \rightarrow u ...\]\\) . In DFS, we want to explore the vertex from the last encountered route.


Consider the following graph as an example:

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 237.85702514648438 292.4285430908203" height="200" style="margin: auto;">
  <g stroke-linecap="round" transform="translate(79.57135009765625 10) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(99.07614171028558 22.675883860929588) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g stroke-linecap="round" transform="translate(79.714111328125 127.14283752441406) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(99.21890294075433 139.81872138534362) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g stroke-linecap="round" transform="translate(10 233.4285430908203) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(29.504791612629333 246.10442695174987) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g stroke-linecap="round" transform="translate(177.57135009765625 226.14283752441406) rotate(0 25.142837524414062 24.5)"><path d="M50.29 24.5 C50.29 25.92, 50.16 27.36, 49.9 28.75 C49.65 30.15, 49.27 31.55, 48.77 32.88 C48.27 34.21, 47.64 35.52, 46.92 36.75 C46.19 37.98, 45.34 39.16, 44.4 40.25 C43.47 41.33, 42.42 42.36, 41.3 43.27 C40.19 44.18, 38.97 45.01, 37.71 45.72 C36.45 46.43, 35.11 47.04, 33.74 47.52 C32.37 48.01, 30.94 48.38, 29.51 48.63 C28.08 48.87, 26.6 49, 25.14 49 C23.69 49, 22.21 48.87, 20.78 48.63 C19.34 48.38, 17.91 48.01, 16.54 47.52 C15.18 47.04, 13.83 46.43, 12.57 45.72 C11.31 45.01, 10.1 44.18, 8.98 43.27 C7.87 42.36, 6.82 41.33, 5.88 40.25 C4.95 39.16, 4.1 37.98, 3.37 36.75 C2.64 35.52, 2.01 34.21, 1.52 32.88 C1.02 31.55, 0.63 30.15, 0.38 28.75 C0.13 27.36, 0 25.92, 0 24.5 C0 23.08, 0.13 21.64, 0.38 20.25 C0.63 18.85, 1.02 17.45, 1.52 16.12 C2.01 14.79, 2.64 13.48, 3.37 12.25 C4.1 11.02, 4.95 9.84, 5.88 8.75 C6.82 7.67, 7.87 6.64, 8.98 5.73 C10.1 4.82, 11.31 3.99, 12.57 3.28 C13.83 2.57, 15.18 1.96, 16.54 1.48 C17.91 0.99, 19.34 0.62, 20.78 0.37 C22.21 0.13, 23.69 0, 25.14 0 C26.6 0, 28.08 0.13, 29.51 0.37 C30.94 0.62, 32.37 0.99, 33.74 1.48 C35.11 1.96, 36.45 2.57, 37.71 3.28 C38.97 3.99, 40.19 4.82, 41.3 5.73 C42.42 6.64, 43.47 7.67, 44.4 8.75 C45.34 9.84, 46.19 11.02, 46.92 12.25 C47.64 13.48, 48.27 14.79, 48.77 16.12 C49.27 17.45, 49.65 18.85, 49.9 20.25 C50.16 21.64, 50.22 23.79, 50.29 24.5 C50.35 25.21, 50.35 23.79, 50.29 24.5" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(197.07614171028558 238.81872138534362) rotate(0 5.859375 12)"><text x="5.859375" y="19.3125" font-family="Cascadia, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round"><g transform="translate(102.75256529457295 62.18311059955735) rotate(0 1.2337606269204002 29.729481063219353)"><path d="M0 0 C0.41 9.91, 2.06 49.55, 2.47 59.46 M0 0 C0.41 9.91, 2.06 49.55, 2.47 59.46" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(93.57136535644531 178.2143096923828) rotate(0 -21.42852783203125 26.857131958007812)"><path d="M0 0 C-7.14 8.95, -35.71 44.76, -42.86 53.71 M0 0 C-7.14 8.95, -35.71 44.76, -42.86 53.71" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(126.71418762207031 173.64283752441406) rotate(0 28.857177734375 25.714309692382812)"><path d="M0 0 C9.62 8.57, 48.1 42.86, 57.71 51.43 M0 0 C9.62 8.57, 48.1 42.86, 57.71 51.43" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(64.42860412597656 259.92857360839844) rotate(0 52.571380615234375 -4)"><path d="M0 0 C17.52 -1.33, 87.62 -6.67, 105.14 -8 M0 0 C17.52 -1.33, 87.62 -6.67, 105.14 -8" stroke="var(--md-code-fg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask></svg>

<div class="grid" markdown>

``` title="BFS like check"

push 1       stack = [1    ] # 1 visited

pop 1        stack = [     ]
push 2 0 3   stack = [2 0 3] # 2 0 3 visited

pop 3        stack = [2 0  ]
pop 0        stack = [2    ]
pop 2        stack = [     ]


Traversal: 1 3 0 2
```

``` title="postpone visited check"
push 1       stack = [1      ]

pop 1        stack = [       ] # 1 visited
push 2 0 3   stack = [2 0 3  ]

pop 3        stack = [2 0    ] # 3 visited
push 2 1     stack = [2 0 2 1] 

pop 1        stack = [2 0 2  ]
pop 2        stack = [2 0    ] # 2 visited
push 3 1     stack = [2 0 3 1]

pop 1        stack = [2 0 3  ]
pop 3        stack = [2 0    ]
pop 0        stack = [2      ] # 0 visited
push 1       stack = [2 1    ]

pop 1        stack = [2      ]
pop 2        stack = [       ]


Traversal: 1 3 2 0
```

</div>

{==

If we check the `visited` status before pushing vertices on stack, the algorithm will still work; in the sense that you'd not stuck in loops still. But, it wouldn't be a "depth first" search anymore.

==}
