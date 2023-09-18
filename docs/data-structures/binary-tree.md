# Binary Tree

Abstract data type that stores elements hierarchically. Each element, save for the root, have a _parent_ element and zero or more children.

## Definitions

- internal node - has one ore more children
- leaf node - has no children
- full binary / proper tree - all nodes have 0 or 2 children.
- perfect binary tree - a full binary tree where all leaves have same depth.
- complete binary tree - all levels, except possibly the last, are completely filled. Heap is a complete binary tree.
- balanced binary tree - difference in height of left and right subtrees is $\le 1$.

## Properties

```
  ╭---1---╮      height: 2 = log(leaves)
╭-2-╮   ╭-3-╮    nodes: 7, leaves: 4, internal: 3
4   5   6   7
```

- A binary tree with $l$ leaves has minimum height $h \ge log_2(l)$.
- With $n$ nodes, a binary tree has minimum height $h \ge log_2(n+1) - 1$.
- $e = n-1$ where $e$ is total edges.

## Traversal

```
              ╭-8----╮
           ╭-11    ╭-56-╮
    ╭-----19      33    4
 ╭-78-╮          
89    115        
```

=== "BFS / Level-order traversal"

    Traverse the tree one level at a time.

    ```
    ['8', '11', '56', '19', '33', '4', '78', '89', '115']
    ```

    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 694.7372589111328 332.4285125732422" width="694.7372589111328" height="332.4285125732422">
      <g stroke-linecap="round" transform="translate(294.1428527832031 11.928558349609375) rotate(0 25.428573608398438 24.5)"><path d="M25.72 0.41 C30.9 0.17, 37.1 2.85, 41.09 6.09 C45.08 9.34, 48.69 14.9, 49.65 19.89 C50.61 24.89, 49.36 31.31, 46.85 36.06 C44.34 40.81, 39.43 46.38, 34.59 48.39 C29.75 50.41, 22.94 49.93, 17.8 48.16 C12.67 46.38, 6.82 42.27, 3.79 37.74 C0.76 33.22, -1.32 26.26, -0.37 21.01 C0.57 15.76, 4.28 9.52, 9.45 6.24 C14.62 2.96, 26.23 1.97, 30.64 1.33 C35.05 0.7, 35.94 2.11, 35.93 2.42 M15.37 3.1 C19.81 0.52, 27.23 -1.21, 32.57 -0.04 C37.91 1.13, 44.42 5.8, 47.42 10.12 C50.42 14.45, 51.21 20.73, 50.59 25.91 C49.98 31.09, 47.62 37.54, 43.72 41.21 C39.82 44.87, 32.67 47.19, 27.2 47.9 C21.74 48.61, 15.35 48.58, 10.92 45.48 C6.49 42.38, 1.82 34.58, 0.64 29.31 C-0.55 24.05, 1.51 18.52, 3.8 13.91 C6.09 9.31, 12.58 3.67, 14.36 1.69 C16.13 -0.28, 14.07 1.53, 14.46 2.07" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(313.1907156607174 24.104442210538963) rotate(0 6.399993896484375 12.5)"><text x="6.399993896484375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">6</text></g><g stroke-linecap="round" transform="translate(216.14283752441406 102.28569030761719) rotate(0 25.428573608398438 24.5)"><path d="M20.51 0.36 C25.74 -0.75, 33.88 0.99, 38.57 3.67 C43.25 6.34, 46.65 11.46, 48.61 16.42 C50.57 21.38, 51.83 28.56, 50.31 33.45 C48.79 38.33, 44.14 43.08, 39.47 45.74 C34.8 48.4, 27.83 50.24, 22.29 49.42 C16.75 48.61, 9.87 44.99, 6.22 40.86 C2.57 36.74, 0.5 30.11, 0.39 24.66 C0.28 19.2, 1.74 12.09, 5.55 8.12 C9.36 4.14, 19.82 2.1, 23.24 0.81 C26.67 -0.48, 26.12 0.1, 26.09 0.4 M34 0.53 C38.84 2.05, 46.3 7.18, 48.78 12.19 C51.26 17.21, 50.01 25.16, 48.88 30.61 C47.75 36.06, 46.09 41.68, 42.01 44.89 C37.94 48.1, 29.89 50.1, 24.42 49.86 C18.96 49.62, 13.18 47.32, 9.23 43.43 C5.28 39.54, 1.71 31.94, 0.72 26.53 C-0.28 21.12, 0.29 15.38, 3.24 10.97 C6.2 6.55, 13.23 1.32, 18.44 0.02 C23.65 -1.29, 31.54 2.54, 34.5 3.15 C37.46 3.76, 36.31 3.63, 36.22 3.67" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(234.78069673981895 114.46157416854675) rotate(0 6.80999755859375 12.5)"><text x="6.80999755859375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">3</text></g><g stroke-linecap="round" transform="translate(126.28569030761719 189.28575134277344) rotate(0 25.428573608398438 24.5)"><path d="M16.06 2.2 C20.68 -0.08, 28.22 -0.89, 33.55 0.67 C38.89 2.22, 45.22 6.83, 48.09 11.54 C50.95 16.24, 51.77 23.73, 50.76 28.88 C49.74 34.03, 46.04 39.17, 42 42.46 C37.96 45.74, 32.07 48.39, 26.52 48.59 C20.96 48.8, 12.9 46.98, 8.67 43.67 C4.44 40.36, 2.15 33.92, 1.13 28.75 C0.11 23.57, -0.67 17.29, 2.54 12.64 C5.74 7.98, 16.53 2.65, 20.35 0.79 C24.18 -1.07, 25.26 1.09, 25.48 1.46 M18.06 1.91 C23.28 0.22, 31.99 0.15, 36.89 2 C41.78 3.85, 45.04 8.14, 47.43 12.99 C49.82 17.84, 52.22 25.73, 51.24 31.08 C50.26 36.43, 46.42 42.04, 41.57 45.1 C36.72 48.16, 27.91 49.8, 22.14 49.45 C16.38 49.1, 10.82 46.68, 6.96 43 C3.11 39.32, -0.45 32.82, -0.97 27.36 C-1.5 21.9, 0.47 14.39, 3.8 10.22 C7.13 6.05, 16.25 4.05, 18.99 2.36 C21.72 0.67, 20.3 -0.17, 20.21 0.09" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(144.61355196442832 201.461635203703) rotate(0 7.1199951171875 12.5)"><text x="7.1199951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">2</text></g><g stroke-linecap="round" transform="translate(42.96430969238281 272.2499237060547) rotate(0 25.428573608398423 24.5)"><path d="M27.16 0.65 C32.11 1.07, 38.83 4.39, 42.88 8.04 C46.94 11.7, 50.84 17.48, 51.48 22.58 C52.13 27.68, 49.92 34.45, 46.77 38.64 C43.62 42.83, 38.04 46.29, 32.58 47.71 C27.12 49.13, 19.2 49.35, 14.02 47.18 C8.85 45.02, 3.65 39.71, 1.53 34.72 C-0.59 29.72, -0.41 22.25, 1.31 17.2 C3.03 12.14, 6.86 7.07, 11.86 4.38 C16.85 1.7, 27.49 1.39, 31.28 1.07 C35.06 0.76, 34.56 2.24, 34.57 2.51 M37.71 3.32 C42.46 5.31, 46.43 11.32, 48.42 16.23 C50.42 21.15, 51.06 27.99, 49.66 32.82 C48.26 37.66, 44.85 42.7, 40.02 45.27 C35.19 47.84, 26.45 48.77, 20.69 48.25 C14.93 47.73, 8.76 45.75, 5.47 42.17 C2.18 38.58, 0.77 32.33, 0.97 26.72 C1.18 21.11, 3.28 13.05, 6.71 8.5 C10.14 3.95, 16.61 0.58, 21.57 -0.57 C26.52 -1.73, 33.95 0.8, 36.45 1.56 C38.95 2.32, 36.56 3.44, 36.56 3.97" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(65.7021673819088 284.42580756698425) rotate(0 2.7099990844726562 12.5)"><text x="2.7099990844726562" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">1</text></g><g stroke-linecap="round" transform="translate(308.9643096923828 186.82142639160156) rotate(0 25.428573608398438 24.5)"><path d="M18.26 1.58 C23.07 -0.23, 31.27 -0.13, 36.2 2.01 C41.14 4.16, 45.7 9.73, 47.86 14.46 C50.01 19.19, 50.27 25.48, 49.13 30.4 C47.99 35.31, 45.17 40.87, 41.01 43.95 C36.85 47.02, 29.68 49.21, 24.17 48.83 C18.67 48.45, 11.83 45.43, 7.99 41.66 C4.14 37.89, 1.57 31.45, 1.1 26.2 C0.64 20.94, 1.72 14.41, 5.19 10.12 C8.67 5.83, 19.04 1.93, 21.98 0.44 C24.91 -1.04, 22.9 0.87, 22.82 1.22 M14.63 0.34 C19.66 -1.69, 28.67 -1.28, 34.24 0.75 C39.82 2.78, 45.16 7.9, 48.09 12.52 C51.02 17.13, 52.8 23.58, 51.83 28.43 C50.86 33.28, 46.31 38.11, 42.27 41.6 C38.22 45.08, 33.04 49.06, 27.56 49.36 C22.08 49.65, 13.84 46.71, 9.38 43.37 C4.92 40.02, 1.76 34.44, 0.79 29.3 C-0.18 24.17, 1.1 17.2, 3.55 12.56 C6 7.93, 13.46 2.98, 15.51 1.5 C17.57 0.02, 15.42 3.11, 15.87 3.69" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(328.2321737906002 198.99731025253112) rotate(0 6.17999267578125 12.5)"><text x="6.17999267578125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">5</text></g><g stroke-linecap="round" transform="translate(216.6786346435547 273.3928680419922) rotate(0 25.428573608398438 24.5)"><path d="M22.52 0.52 C27.51 -0.36, 34.93 1.19, 39.46 4.05 C43.99 6.92, 48.3 12.79, 49.7 17.73 C51.1 22.68, 49.91 28.99, 47.87 33.75 C45.84 38.5, 42.31 43.83, 37.49 46.26 C32.67 48.69, 24.52 49.56, 18.95 48.33 C13.38 47.1, 7.13 43.21, 4.07 38.88 C1 34.55, -0.1 27.67, 0.56 22.34 C1.23 17, 4.02 10.59, 8.07 6.87 C12.11 3.15, 22 1.07, 24.83 0.03 C27.66 -1.02, 25.27 0.22, 25.03 0.58 M13.89 2.84 C18.45 0.2, 27.38 -1.38, 32.91 0.01 C38.44 1.4, 43.91 6.59, 47.06 11.18 C50.21 15.77, 52.27 22.31, 51.81 27.56 C51.35 32.81, 48.3 38.89, 44.3 42.67 C40.3 46.44, 33.19 50.12, 27.84 50.2 C22.49 50.29, 16.57 46.41, 12.22 43.21 C7.86 40, 3.36 36.01, 1.7 30.96 C0.05 25.91, 0.26 17.57, 2.28 12.92 C4.3 8.26, 11.66 4.69, 13.84 3.03 C16.01 1.37, 14.84 2.66, 15.32 2.98" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(235.72649752106895 285.56875190292175) rotate(0 6.399993896484375 12.5)"><text x="6.399993896484375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">4</text></g><g stroke-linecap="round" transform="translate(408.7855987548828 99.53565979003906) rotate(0 25.428573608398438 24.5)"><path d="M25.03 0.11 C30.17 -0.33, 38.54 1.72, 42.69 5.19 C46.84 8.67, 49.06 15.55, 49.9 20.95 C50.74 26.35, 50.59 33.04, 47.72 37.6 C44.86 42.16, 37.92 46.75, 32.71 48.3 C27.5 49.86, 21.25 49.04, 16.46 46.92 C11.66 44.8, 6.69 39.92, 3.93 35.57 C1.18 31.21, -1 25.66, -0.07 20.79 C0.85 15.91, 4.86 9.81, 9.49 6.32 C14.13 2.83, 24.26 0.68, 27.74 -0.16 C31.21 -0.99, 30.23 0.84, 30.33 1.31 M21.85 0.68 C26.91 -0.23, 32.57 1.04, 37.17 3.73 C41.78 6.43, 47.56 12.17, 49.46 16.86 C51.35 21.55, 50.23 27, 48.56 31.86 C46.9 36.72, 43.7 43.3, 39.44 46.01 C35.19 48.72, 28.57 48.91, 23.02 48.13 C17.47 47.35, 10.03 44.99, 6.13 41.35 C2.23 37.71, -0.41 31.49, -0.38 26.28 C-0.34 21.08, 2.68 14.39, 6.35 10.13 C10.01 5.87, 19.23 2.44, 21.62 0.73 C24 -0.99, 20.75 -0.44, 20.65 -0.15" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(428.8534582754635 111.71154365096862) rotate(0 5.379997253417969 12.5)"><text x="5.379997253417969" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">7</text></g><g stroke-linecap="round"><g transform="translate(127.78570556640625 232.3214569091797) rotate(0 -20.438402514681215 20.911161600574843)"><path d="M0.84 -0.4 C-5.94 6.83, -33.89 36.31, -40.5 43.48 M-0.18 -1.66 C-7.17 5.22, -35.24 34.11, -41.71 41.68" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(218.64326743122024 144.89240713018808) rotate(0 -22.925085763863223 23.407811789071275)"><path d="M-1.01 0.43 C-8.67 8.4, -38.21 39.61, -45.42 47.2 M0.66 -0.38 C-7.22 7.25, -38.97 37.39, -46.51 45.26" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(264.89363418979565 151.16533751772658) rotate(0 23.815110857262624 18.173160937477718)"><path d="M-1.08 0.32 C6.95 6.33, 40.31 29.47, 48.71 35.51 M0.56 -0.56 C8.35 5.68, 39.53 31.04, 47.55 36.91" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(296.9292110944094 59.17787325543753) rotate(0 -17.734248233838457 20.664292096547513)"><path d="M1.01 0.22 C-4.77 7.07, -29.41 34.16, -35.69 41.11 M0.08 -0.7 C-5.74 6.24, -30.16 34.74, -36.48 42.03" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(346.14007160939093 55.532723011287885) rotate(0 30.003236184542743 21.47072968890822)"><path d="M0.59 0.5 C10.77 7.39, 50.73 34.91, 60.57 41.85 M-0.57 -0.29 C9.53 6.74, 49.96 35.94, 59.83 43.23" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(308.3664744815369 229.59965641728013) rotate(0 -22.48392674114001 21.42817460935015)"><path d="M-0.22 -0.53 C-7.59 6.78, -37.64 36.19, -44.74 43.39 M-1.8 1.8 C-8.76 8.85, -35.7 35.43, -42.6 41.89" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(225 10) rotate(0 99.42861938476562 26.57141876220703)"><path d="M13.29 0 M13.29 0 C58.14 -1.21, 100.59 -2.04, 185.57 0 M13.29 0 C62.99 2.47, 113.45 2.34, 185.57 0 M185.57 0 C196.26 1.56, 199.53 5.69, 198.86 13.29 M185.57 0 C195.18 0.94, 201.07 3.06, 198.86 13.29 M198.86 13.29 C197.06 21.02, 198.5 27.88, 198.86 39.86 M198.86 13.29 C198.39 20.19, 198.78 25.53, 198.86 39.86 M198.86 39.86 C200.41 48.88, 193.74 52.74, 185.57 53.14 M198.86 39.86 C197.5 50.02, 195.34 54.26, 185.57 53.14 M185.57 53.14 C137.86 50.79, 88.77 54.29, 13.29 53.14 M185.57 53.14 C124.91 52.66, 62.02 52.85, 13.29 53.14 M13.29 53.14 C5.16 53.17, -0.31 46.79, 0 39.86 M13.29 53.14 C6.09 54.02, 1.52 49.66, 0 39.86 M0 39.86 C-0.49 30.6, 0.91 22.05, 0 13.29 M0 39.86 C0.6 31.12, -0.57 24.04, 0 13.29 M0 13.29 C0.7 5.58, 3.8 -0.63, 13.29 0 M0 13.29 C-1.16 3.7, 6.27 -0.74, 13.29 0" stroke="#2f9e44" stroke-width="1" fill="none"></path></g><g stroke-linecap="round" transform="translate(136.4287109375 98.57148742675781) rotate(0 187.42855834960938 26)"><path d="M13 0 M13 0 C136 1.72, 259.09 2.99, 361.86 0 M13 0 C114.97 1.61, 218.37 1.62, 361.86 0 M361.86 0 C370.45 0.1, 376.53 5.14, 374.86 13 M361.86 0 C370.37 2.06, 375.82 6.41, 374.86 13 M374.86 13 C376.83 19.09, 376.22 25.5, 374.86 39 M374.86 13 C374.57 22.5, 375.55 33.09, 374.86 39 M374.86 39 C375.21 46.3, 369.52 52.1, 361.86 52 M374.86 39 C376.21 46.7, 370.96 52.86, 361.86 52 M361.86 52 C246.77 51.77, 131.82 50.14, 13 52 M361.86 52 C261.99 52.34, 162.51 52.61, 13 52 M13 52 C2.53 51.51, 1.65 48.75, 0 39 M13 52 C3.41 51.85, 0.47 48.88, 0 39 M0 39 C-0.85 34.33, 0.08 26.22, 0 13 M0 39 C-0.36 32.95, -0.18 28.12, 0 13 M0 13 C-1.95 3.25, 6.3 0.8, 13 0 M0 13 C-1.95 2.62, 3.99 1.78, 13 0" stroke="#2f9e44" stroke-width="1" fill="none"></path></g><g stroke-linecap="round" transform="translate(85.57131958007812 183.9999542236328) rotate(0 232.5714111328125 26)"><path d="M13 0 M13 0 C106.82 0.29, 200.23 0.5, 452.14 0 M13 0 C185.15 -1.51, 357.08 -2.08, 452.14 0 M452.14 0 C460.42 1.32, 465.66 6.27, 465.14 13 M452.14 0 C459.53 -0.36, 465.08 3.35, 465.14 13 M465.14 13 C466.03 21.45, 466.87 27.57, 465.14 39 M465.14 13 C465.68 21.94, 466.35 28.86, 465.14 39 M465.14 39 C466.24 45.96, 459.94 53.06, 452.14 52 M465.14 39 C464.4 48.68, 462.71 53.17, 452.14 52 M452.14 52 C342.86 51.87, 234.34 51.41, 13 52 M452.14 52 C339.92 50.63, 227.87 50.39, 13 52 M13 52 C2.6 50.87, -0.12 47.01, 0 39 M13 52 C2.48 52.69, 1.45 46.1, 0 39 M0 39 C0.3 28.38, 1.25 17.24, 0 13 M0 39 C0.03 30.51, -0.59 22.43, 0 13 M0 13 C1.22 4.33, 4.46 -0.93, 13 0 M0 13 C1.02 3.36, 6.11 1.22, 13 0" stroke="#2f9e44" stroke-width="1" fill="none"></path></g><g stroke-linecap="round" transform="translate(10 270.4285125732422) rotate(0 296.85708618164057 26)"><path d="M13 0 M13 0 C224.2 0.04, 435.32 0.87, 580.71 0 M13 0 C165.43 1.54, 318.59 1.28, 580.71 0 M580.71 0 C587.6 -0.65, 594.5 5.35, 593.71 13 M580.71 0 C588.98 -1.79, 595.15 6.21, 593.71 13 M593.71 13 C592.31 21.13, 593.23 27.66, 593.71 39 M593.71 13 C594.56 19.9, 594.05 25.72, 593.71 39 M593.71 39 C592.46 46.81, 591.01 51.75, 580.71 52 M593.71 39 C595.66 46.13, 591.42 53.88, 580.71 52 M580.71 52 C354.1 51.53, 128.2 52.22, 13 52 M580.71 52 C464.75 50.37, 348.4 50.92, 13 52 M13 52 C3.86 51.01, 0.94 49.36, 0 39 M13 52 C3.7 53.05, 0.46 48.91, 0 39 M0 39 C1.52 35.07, -0.47 28.13, 0 13 M0 39 C-0.8 29.59, 0.09 21.15, 0 13 M0 13 C1.39 3.87, 4.96 -0.74, 13 0 M0 13 C0.73 4.01, 5.84 1.05, 13 0" stroke="#2f9e44" stroke-width="1" fill="none"></path></g><g transform="translate(437.6785888671875 23.714309692382812) rotate(0 28.249969482421875 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">level-1</text></g><g transform="translate(524.5714416503906 110.92851257324219) rotate(0 32.65996551513672 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">level-2</text></g><g transform="translate(564.5713806152344 196.6427764892578) rotate(0 32.34996795654297 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">level-3</text></g><g transform="translate(620.8573303222656 284.3571014404297) rotate(0 31.939964294433594 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">level-4</text></g></svg>

    ```javascript
    function bfs(root) {
      let queue = [root], out = [];
      
      while(queue.length > 0) {
        let [node] = queue.splice(0, 1); // dequeue front
        out.push(node);

        if (node.left() != null)
          queue.push(node.left())
        if (node.right() != null)
          queue.push(node.right())
      }

      return out;
    }
    ```

    We can use it to populate a tree in layers:

    ```javascript
    function buildTree(values) {
      let root = null;
      for (let v of values) {
        let newNode = new BinaryTreeNode(v);
        if (root == null) 
          root = newNode;
        else
          populate(root, newNode)
      }	
      return root;
    }

    function populate(root, value) {
      let queue = [root];
      let newNode = new BinaryTreeNode(value);
      
      while(queue.length > 0) {
        let [node] = queue.splice(0, 1); // dequeue front

        if (node.left() != null)
          queue.push(node.left())
        else {
          node.setLeft(newNode);
          break;
        }
        if (node.right() != null)
          queue.push(node.right())
        else {
          node.setRight(newNode);
          break;
        }
      }
    }
    ```

=== "In-order traversal"
    Version of DFS.

    1. recursively traverse left subtree.
    2. visit current node.
    3. recursively traverse right subtree.

    ```
    ['89', '78', '115', '19', '11', '8', '33', '56', '4']
    ```
    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 544.5964068795952 446.6964333870004" width="544.5964068795952" height="446.6964333870004">
      <g stroke-linecap="round" transform="translate(376.5251025583062 99.65525520441746) rotate(0 25.428573608398438 24.5)"><path d="M25.72 0.41 C30.9 0.17, 37.1 2.85, 41.09 6.09 C45.08 9.34, 48.69 14.9, 49.65 19.89 C50.61 24.89, 49.36 31.31, 46.85 36.06 C44.34 40.81, 39.43 46.38, 34.59 48.39 C29.75 50.41, 22.94 49.93, 17.8 48.16 C12.67 46.38, 6.82 42.27, 3.79 37.74 C0.76 33.22, -1.32 26.26, -0.37 21.01 C0.57 15.76, 4.28 9.52, 9.45 6.24 C14.62 2.96, 26.23 1.97, 30.64 1.33 C35.05 0.7, 35.94 2.11, 35.93 2.42 M15.37 3.1 C19.81 0.52, 27.23 -1.21, 32.57 -0.04 C37.91 1.13, 44.42 5.8, 47.42 10.12 C50.42 14.45, 51.21 20.73, 50.59 25.91 C49.98 31.09, 47.62 37.54, 43.72 41.21 C39.82 44.87, 32.67 47.19, 27.2 47.9 C21.74 48.61, 15.35 48.58, 10.92 45.48 C6.49 42.38, 1.82 34.58, 0.64 29.31 C-0.55 24.05, 1.51 18.52, 3.8 13.91 C6.09 9.31, 12.58 3.67, 14.36 1.69 C16.13 -0.28, 14.07 1.53, 14.46 2.07" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(395.57296543582044 111.83113906534705) rotate(0 6.399993896484375 12.5)"><text x="6.399993896484375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">6</text></g><g stroke-linecap="round" transform="translate(298.5250872995171 190.01238716242528) rotate(0 25.428573608398438 24.5)"><path d="M20.51 0.36 C25.74 -0.75, 33.88 0.99, 38.57 3.67 C43.25 6.34, 46.65 11.46, 48.61 16.42 C50.57 21.38, 51.83 28.56, 50.31 33.45 C48.79 38.33, 44.14 43.08, 39.47 45.74 C34.8 48.4, 27.83 50.24, 22.29 49.42 C16.75 48.61, 9.87 44.99, 6.22 40.86 C2.57 36.74, 0.5 30.11, 0.39 24.66 C0.28 19.2, 1.74 12.09, 5.55 8.12 C9.36 4.14, 19.82 2.1, 23.24 0.81 C26.67 -0.48, 26.12 0.1, 26.09 0.4 M34 0.53 C38.84 2.05, 46.3 7.18, 48.78 12.19 C51.26 17.21, 50.01 25.16, 48.88 30.61 C47.75 36.06, 46.09 41.68, 42.01 44.89 C37.94 48.1, 29.89 50.1, 24.42 49.86 C18.96 49.62, 13.18 47.32, 9.23 43.43 C5.28 39.54, 1.71 31.94, 0.72 26.53 C-0.28 21.12, 0.29 15.38, 3.24 10.97 C6.2 6.55, 13.23 1.32, 18.44 0.02 C23.65 -1.29, 31.54 2.54, 34.5 3.15 C37.46 3.76, 36.31 3.63, 36.22 3.67" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(317.162946514922 202.18827102335484) rotate(0 6.80999755859375 12.5)"><text x="6.80999755859375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">3</text></g><g stroke-linecap="round" transform="translate(208.66794008272024 277.01244819758153) rotate(0 25.428573608398438 24.5)"><path d="M16.06 2.2 C20.68 -0.08, 28.22 -0.89, 33.55 0.67 C38.89 2.22, 45.22 6.83, 48.09 11.54 C50.95 16.24, 51.77 23.73, 50.76 28.88 C49.74 34.03, 46.04 39.17, 42 42.46 C37.96 45.74, 32.07 48.39, 26.52 48.59 C20.96 48.8, 12.9 46.98, 8.67 43.67 C4.44 40.36, 2.15 33.92, 1.13 28.75 C0.11 23.57, -0.67 17.29, 2.54 12.64 C5.74 7.98, 16.53 2.65, 20.35 0.79 C24.18 -1.07, 25.26 1.09, 25.48 1.46 M18.06 1.91 C23.28 0.22, 31.99 0.15, 36.89 2 C41.78 3.85, 45.04 8.14, 47.43 12.99 C49.82 17.84, 52.22 25.73, 51.24 31.08 C50.26 36.43, 46.42 42.04, 41.57 45.1 C36.72 48.16, 27.91 49.8, 22.14 49.45 C16.38 49.1, 10.82 46.68, 6.96 43 C3.11 39.32, -0.45 32.82, -0.97 27.36 C-1.5 21.9, 0.47 14.39, 3.8 10.22 C7.13 6.05, 16.25 4.05, 18.99 2.36 C21.72 0.67, 20.3 -0.17, 20.21 0.09" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(226.99580173953137 289.1883320585111) rotate(0 7.1199951171875 12.5)"><text x="7.1199951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">2</text></g><g stroke-linecap="round" transform="translate(125.34655946748586 359.9766205608628) rotate(0 25.428573608398423 24.5)"><path d="M27.16 0.65 C32.11 1.07, 38.83 4.39, 42.88 8.04 C46.94 11.7, 50.84 17.48, 51.48 22.58 C52.13 27.68, 49.92 34.45, 46.77 38.64 C43.62 42.83, 38.04 46.29, 32.58 47.71 C27.12 49.13, 19.2 49.35, 14.02 47.18 C8.85 45.02, 3.65 39.71, 1.53 34.72 C-0.59 29.72, -0.41 22.25, 1.31 17.2 C3.03 12.14, 6.86 7.07, 11.86 4.38 C16.85 1.7, 27.49 1.39, 31.28 1.07 C35.06 0.76, 34.56 2.24, 34.57 2.51 M37.71 3.32 C42.46 5.31, 46.43 11.32, 48.42 16.23 C50.42 21.15, 51.06 27.99, 49.66 32.82 C48.26 37.66, 44.85 42.7, 40.02 45.27 C35.19 47.84, 26.45 48.77, 20.69 48.25 C14.93 47.73, 8.76 45.75, 5.47 42.17 C2.18 38.58, 0.77 32.33, 0.97 26.72 C1.18 21.11, 3.28 13.05, 6.71 8.5 C10.14 3.95, 16.61 0.58, 21.57 -0.57 C26.52 -1.73, 33.95 0.8, 36.45 1.56 C38.95 2.32, 36.56 3.44, 36.56 3.97" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(148.08441715701184 372.15250442179234) rotate(0 2.7099990844726562 12.5)"><text x="2.7099990844726562" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">1</text></g><g stroke-linecap="round" transform="translate(384.48938173311086 260.26235664484716) rotate(0 25.428573608398438 24.5)"><path d="M18.26 1.58 C23.07 -0.23, 31.27 -0.13, 36.2 2.01 C41.14 4.16, 45.7 9.73, 47.86 14.46 C50.01 19.19, 50.27 25.48, 49.13 30.4 C47.99 35.31, 45.17 40.87, 41.01 43.95 C36.85 47.02, 29.68 49.21, 24.17 48.83 C18.67 48.45, 11.83 45.43, 7.99 41.66 C4.14 37.89, 1.57 31.45, 1.1 26.2 C0.64 20.94, 1.72 14.41, 5.19 10.12 C8.67 5.83, 19.04 1.93, 21.98 0.44 C24.91 -1.04, 22.9 0.87, 22.82 1.22 M14.63 0.34 C19.66 -1.69, 28.67 -1.28, 34.24 0.75 C39.82 2.78, 45.16 7.9, 48.09 12.52 C51.02 17.13, 52.8 23.58, 51.83 28.43 C50.86 33.28, 46.31 38.11, 42.27 41.6 C38.22 45.08, 33.04 49.06, 27.56 49.36 C22.08 49.65, 13.84 46.71, 9.38 43.37 C4.92 40.02, 1.76 34.44, 0.79 29.3 C-0.18 24.17, 1.1 17.2, 3.55 12.56 C6 7.93, 13.46 2.98, 15.51 1.5 C17.57 0.02, 15.42 3.11, 15.87 3.69" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(403.75724583132825 272.4382405057767) rotate(0 6.17999267578125 12.5)"><text x="6.17999267578125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">5</text></g><g stroke-linecap="round" transform="translate(299.06088441865774 361.1195648968003) rotate(0 25.428573608398438 24.5)"><path d="M22.52 0.52 C27.51 -0.36, 34.93 1.19, 39.46 4.05 C43.99 6.92, 48.3 12.79, 49.7 17.73 C51.1 22.68, 49.91 28.99, 47.87 33.75 C45.84 38.5, 42.31 43.83, 37.49 46.26 C32.67 48.69, 24.52 49.56, 18.95 48.33 C13.38 47.1, 7.13 43.21, 4.07 38.88 C1 34.55, -0.1 27.67, 0.56 22.34 C1.23 17, 4.02 10.59, 8.07 6.87 C12.11 3.15, 22 1.07, 24.83 0.03 C27.66 -1.02, 25.27 0.22, 25.03 0.58 M13.89 2.84 C18.45 0.2, 27.38 -1.38, 32.91 0.01 C38.44 1.4, 43.91 6.59, 47.06 11.18 C50.21 15.77, 52.27 22.31, 51.81 27.56 C51.35 32.81, 48.3 38.89, 44.3 42.67 C40.3 46.44, 33.19 50.12, 27.84 50.2 C22.49 50.29, 16.57 46.41, 12.22 43.21 C7.86 40, 3.36 36.01, 1.7 30.96 C0.05 25.91, 0.26 17.57, 2.28 12.92 C4.3 8.26, 11.66 4.69, 13.84 3.03 C16.01 1.37, 14.84 2.66, 15.32 2.98" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(318.108747296172 373.29544875772984) rotate(0 6.399993896484375 12.5)"><text x="6.399993896484375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">4</text></g><g stroke-linecap="round" transform="translate(483.73925966279836 173.5480622112534) rotate(0 25.428573608398438 24.5)"><path d="M25.03 0.11 C30.17 -0.33, 38.54 1.72, 42.69 5.19 C46.84 8.67, 49.06 15.55, 49.9 20.95 C50.74 26.35, 50.59 33.04, 47.72 37.6 C44.86 42.16, 37.92 46.75, 32.71 48.3 C27.5 49.86, 21.25 49.04, 16.46 46.92 C11.66 44.8, 6.69 39.92, 3.93 35.57 C1.18 31.21, -1 25.66, -0.07 20.79 C0.85 15.91, 4.86 9.81, 9.49 6.32 C14.13 2.83, 24.26 0.68, 27.74 -0.16 C31.21 -0.99, 30.23 0.84, 30.33 1.31 M21.85 0.68 C26.91 -0.23, 32.57 1.04, 37.17 3.73 C41.78 6.43, 47.56 12.17, 49.46 16.86 C51.35 21.55, 50.23 27, 48.56 31.86 C46.9 36.72, 43.7 43.3, 39.44 46.01 C35.19 48.72, 28.57 48.91, 23.02 48.13 C17.47 47.35, 10.03 44.99, 6.13 41.35 C2.23 37.71, -0.41 31.49, -0.38 26.28 C-0.34 21.08, 2.68 14.39, 6.35 10.13 C10.01 5.87, 19.23 2.44, 21.62 0.73 C24 -0.99, 20.75 -0.44, 20.65 -0.15" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(503.80711918337903 185.72394607218297) rotate(0 5.379997253417969 12.5)"><text x="5.379997253417969" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">7</text></g><g stroke-linecap="round"><g transform="translate(210.1679553415093 320.0481537639878) rotate(0 -20.438402514681215 20.911161600574843)"><path d="M0.84 -0.4 C-5.94 6.83, -33.89 36.31, -40.5 43.48 M-0.18 -1.66 C-7.17 5.22, -35.24 34.11, -41.71 41.68" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(210.1679553415093 320.0481537639878) rotate(0 -20.438402514681215 20.911161600574843)"><path d="M-31.09 13.79 C-32.89 25.05, -37.9 31.6, -41.57 42.09 M-31.09 15.52 C-34.42 22.76, -36.86 29.38, -42.17 41.97" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(210.1679553415093 320.0481537639878) rotate(0 -20.438402514681215 20.911161600574843)"><path d="M-16.34 27.38 C-22.76 34.5, -32.37 36.81, -41.57 42.09 M-16.34 29.11 C-23.77 32.57, -30.38 35.35, -42.17 41.97" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(301.0255172063233 232.61910398499617) rotate(0 -22.925085763863223 23.407811789071275)"><path d="M-1.01 0.43 C-8.67 8.4, -38.21 39.61, -45.42 47.2 M0.66 -0.38 C-7.22 7.25, -38.97 37.39, -46.51 45.26" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(301.0255172063233 232.61910398499617) rotate(0 -22.925085763863223 23.407811789071275)"><path d="M-32.95 17.68 C-37.65 28.79, -44.11 38.25, -45.66 45.93 M-34.36 17.34 C-38.01 26.5, -41.73 36.05, -45.84 44.53" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(301.0255172063233 232.61910398499617) rotate(0 -22.925085763863223 23.407811789071275)"><path d="M-18.53 32.28 C-28.11 38.25, -39.53 42.69, -45.66 45.93 M-19.94 31.93 C-28.42 36.2, -37.05 40.78, -45.84 44.53" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(349.0241356173714 237.19039509899005) rotate(0 18.698094848325866 12.569307612418044)"><path d="M-1.08 0.32 C5.25 4.46, 31.78 20.13, 38.47 24.3 M0.56 -0.56 C6.65 3.81, 31.01 21.7, 37.32 25.7" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(349.0241356173714 237.19039509899005) rotate(0 18.698094848325866 12.569307612418044)"><path d="M15.61 19.25 C22.26 22.48, 31.7 23.88, 36.4 26.72 M15.63 19.08 C21.81 22.04, 29.32 24.1, 37.08 24.74" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(349.0241356173714 237.19039509899005) rotate(0 18.698094848325866 12.569307612418044)"><path d="M24.54 6.31 C28.06 13.92, 34.42 19.77, 36.4 26.72 M24.57 6.14 C27.9 13.33, 32.5 19.62, 37.08 24.74" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(379.3114608695125 146.90457011024563) rotate(0 -17.734248233838457 20.664292096547513)"><path d="M1.01 0.22 C-4.77 7.07, -29.41 34.16, -35.69 41.11 M0.08 -0.7 C-5.74 6.24, -30.16 34.74, -36.48 42.03" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(379.3114608695125 146.90457011024563) rotate(0 -17.734248233838457 20.664292096547513)"><path d="M-26.28 16.57 C-30.72 20.59, -31.47 26.69, -34.83 41.94 M-25.89 15.96 C-30.63 25.6, -33.22 34.76, -36.71 41.86" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(379.3114608695125 146.90457011024563) rotate(0 -17.734248233838457 20.664292096547513)"><path d="M-11.88 28.96 C-19.42 30.43, -23.26 33.87, -34.83 41.94 M-11.49 28.35 C-21.47 33.52, -29.3 38.17, -36.71 41.86" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(429.59660524385305 141.76238716242528) rotate(0 25.054591685160972 16.10286210782826)"><path d="M0.59 0.5 C9.12 5.6, 42.48 25.97, 50.68 31.12 M-0.57 -0.29 C7.88 4.95, 41.72 26.99, 49.93 32.49" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(429.59660524385305 141.76238716242528) rotate(0 25.054591685160972 16.10286210782826)"><path d="M21.92 26.29 C28.02 26.41, 35.92 29.07, 50.75 34.46 M20.73 24.97 C27.38 26.63, 34.39 28.49, 49.74 32.09" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(429.59660524385305 141.76238716242528) rotate(0 25.054591685160972 16.10286210782826)"><path d="M33.07 9.35 C36.38 13.89, 41.4 20.91, 50.75 34.46 M31.89 8.03 C36.04 13.65, 40.46 19.44, 49.74 32.09" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(386.1685360188683 305.76174196797604) rotate(0 -21.793763308458693 26.042837430581187)"><path d="M-0.22 -0.53 C-7.36 8.32, -36.49 43.88, -43.36 52.62 M-1.8 1.8 C-8.53 10.39, -34.55 43.12, -41.22 51.12" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(386.1685360188683 305.76174196797604) rotate(0 -21.793763308458693 26.042837430581187)"><path d="M-32.32 20.97 C-32.04 31.25, -35.69 35.45, -42.97 51.12 M-31.41 22.44 C-34.22 32.29, -37.75 42.3, -40.39 51.56" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(386.1685360188683 305.76174196797604) rotate(0 -21.793763308458693 26.042837430581187)"><path d="M-16.38 33.89 C-20.08 40.88, -27.76 41.81, -42.97 51.12 M-15.47 35.37 C-23.87 40.68, -33.06 46.1, -40.39 51.56" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g mask="url(#mask-8PVGpU8R4O50xhaMEhwJ5)" stroke-linecap="round"><g transform="translate(102.73938173311086 358.90527046320653) rotate(0 87.46092417053879 -89.01552826620639)"><path d="M-0.51 -0.42 C28.65 -29.65, 145.93 -146.44, 175.44 -176.06 M1.42 -1.69 C30.38 -31.17, 145.33 -148.34, 174.49 -177.61" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(102.73938173311086 358.90527046320653) rotate(0 87.46092417053879 -89.01552826620639)"><path d="M161.28 -150.33 C168.18 -157.67, 168.99 -167.06, 173.91 -176.03 M161.44 -150.05 C164.25 -156.71, 167.49 -161.74, 174.2 -176.88" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(102.73938173311086 358.90527046320653) rotate(0 87.46092417053879 -89.01552826620639)"><path d="M146.68 -164.75 C158.46 -167.14, 164.22 -171.64, 173.91 -176.03 M146.84 -164.47 C152.91 -167.85, 159.37 -169.71, 174.2 -176.88" stroke="#f08c00" stroke-width="1" fill="none"></path></g></g><mask id="mask-8PVGpU8R4O50xhaMEhwJ5"><rect x="0" y="0" fill="#fff" width="378.1679553415093" height="636.0481537639878"></rect><rect x="168.02369874971242" y="257.8338288128159" fill="#000" width="44.85993957519531" height="25" opacity="1"></rect></mask><g transform="translate(168.02369874971242 257.8338288128159) rotate(0 22.176607153937226 12.055913384184237)"><text x="22.429969787597656" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">first</text></g><g mask="url(#mask-eF7I26_VjX6tgSUPcb876)" stroke-linecap="round"><g transform="translate(370.7394885446343 420.61953437922216) rotate(0 44.735523189241064 -58.0128964267019)"><path d="M-1.17 1.17 C13.57 -17.93, 73.32 -95.99, 88.54 -115.59 M0.42 0.73 C15.5 -18.6, 75.77 -97.9, 90.64 -117.19" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(370.7394885446343 420.61953437922216) rotate(0 44.735523189241064 -58.0128964267019)"><path d="M83.61 -90.52 C86.31 -96.53, 87.69 -106.27, 90.68 -116.63 M81.31 -87.9 C85.26 -98.8, 87.24 -108.1, 90.55 -117.99" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(370.7394885446343 420.61953437922216) rotate(0 44.735523189241064 -58.0128964267019)"><path d="M67.31 -102.99 C74.93 -105, 81.33 -110.89, 90.68 -116.63 M65.01 -100.37 C74.75 -107, 82.52 -111.88, 90.55 -117.99" stroke="#f08c00" stroke-width="1" fill="none"></path></g></g><mask id="mask-eF7I26_VjX6tgSUPcb876"><rect x="0" y="0" fill="#fff" width="560.4536609079155" height="637.1909149944565"></rect><rect x="383.7766055490288" y="349.833844071605" fill="#000" width="63.63993835449219" height="25" opacity="1"></rect></mask><g transform="translate(383.7766055490288 349.833844071605) rotate(0 31.698406184846533 12.772793880915287)"><text x="31.819969177246094" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">second</text></g><g mask="url(#mask-0XpAGwZ36ygu29qzCZugI)" stroke-linecap="round"><g transform="translate(295.88224977510305 166.3338288128159) rotate(0 39.156560890004044 -38.90875870697201)"><path d="M0.4 1.15 C13.07 -11.74, 63.93 -64.18, 76.88 -77.34 M-0.84 0.71 C12.13 -12.5, 66.1 -65.53, 79.16 -78.97" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(295.88224977510305 166.3338288128159) rotate(0 39.156560890004044 -38.90875870697201)"><path d="M68.44 -53.15 C72.77 -61.28, 76.65 -70.42, 78.99 -80.73 M66.59 -50.81 C70.77 -61.02, 75.35 -69.4, 78.6 -79.9" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(295.88224977510305 166.3338288128159) rotate(0 39.156560890004044 -38.90875870697201)"><path d="M53.91 -67.64 C63.63 -70.44, 72.9 -74.21, 78.99 -80.73 M52.06 -65.3 C60.77 -71.06, 69.9 -74.91, 78.6 -79.9" stroke="#f08c00" stroke-width="1" fill="none"></path></g></g><mask id="mask-0XpAGwZ36ygu29qzCZugI"><rect x="0" y="0" fill="#fff" width="473.59660524385305" height="344.6195191204331"></rect><rect x="311.9694537545952" y="114.69098365900732" fill="#000" width="45.539947509765625" height="25" opacity="1"></rect></mask><g transform="translate(311.9694537545952 114.69098365900732) rotate(0 23.069356910511857 12.734086446836585)"><text x="22.769973754882812" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">third</text></g><g stroke-linecap="round"><g transform="translate(414.45378297822805 95.01238716242527) rotate(0 -37.64751468411649 -42.5658883819248)"><path d="M-0.14 -0.12 C-7.7 -13.77, -33.4 -69.25, -45.8 -81.19 C-58.2 -93.13, -69.74 -73.46, -74.55 -71.76 M-1.68 -1.23 C-8.79 -14.73, -31.19 -68.16, -43.43 -79.67 C-55.68 -91.19, -70.01 -71.43, -75.15 -70.31" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(338.45378297822805 25.29809272883152) rotate(0 -148.9581967393309 153.24128645665942)"><path d="M1 0.18 C-48.61 51.21, -248.18 255.18, -297.68 306.3 M0.06 -0.77 C-49.75 50.36, -249.54 255.8, -298.91 307.25" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(40.1679553415093 331.58385933039403) rotate(0 35.28640514447759 36.760116018727444)"><path d="M0.36 -0.71 C-0.81 4.33, -20.91 17.12, -7.4 29.61 C6.12 42.1, 66.65 66.77, 81.44 74.23 M-0.91 1.53 C-2.2 6.31, -22.46 16.26, -8.33 28.03 C5.8 39.8, 68.99 64.81, 83.89 72.16" stroke="#2f9e44" stroke-width="1" fill="none"></path></g><g transform="translate(40.1679553415093 331.58385933039403) rotate(0 35.28640514447759 36.760116018727444)"><path d="M52.77 70.18 C63.69 69.17, 70.84 69.52, 84.97 73.55 M53.93 69.56 C62.29 70.93, 70.13 71.92, 83.95 71.42" stroke="#2f9e44" stroke-width="1" fill="none"></path></g><g transform="translate(40.1679553415093 331.58385933039403) rotate(0 35.28640514447759 36.760116018727444)"><path d="M61.08 51.41 C69.68 55.45, 74.6 60.83, 84.97 73.55 M62.24 50.8 C68.44 57.4, 73.97 63.62, 83.95 71.42" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(-12.974897441693827 124.15530098078465) rotate(313.84893918552393 162.79986572265625 37.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">use a stack to jump </text><text x="0" y="25" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">at the very end of this spine</text><text x="0" y="50" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">and traverse in reverse direction</text></g><g transform="translate(420.20378297822805 377.8695954143784) rotate(308.12477741797153 49.0799560546875 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">same here</text></g></svg>

    === "Recursive"
        ```javascript
        function inorder(root) {
          function traverse(node, out) {
            if (node.left() != null)
              traverse(node.left(), out)
            
            out.push(node)
            
            if (node.right() != null)
              traverse(node.right(), out)
          }

          let out = [];
          traverse(root, out);
          return out;
        }
        ```

    === "Iterative"
        ```javascript
        function inorder(root) {
          let stack = [], out = [];
          let traverseLeftSpine = (node) => {
            while(node != null) {
              stack.push(node);
              node = node.left();
            }
          };

          traverseLeftSpine(root);
          while(stack.length > 0) {
            let node = stack.pop();
            out.push(node);
            
            if (node.right() != null)
              traverseLeftSpine(node.right())
          }
          return out;
        }
        ```


<script>   
class BinaryTreeNode {
  #value;
  #left = null;
  #right = null;

  constructor(value, left = null, right = null) {
    this.#value = value;
    this.#left = left;
    this.#right = right;
  }

  left() {
    return this.#left;
  }

  setLeft(node) {
    this.#left = node;
  }

  right() {
    return this.#right;
  }

  setRight(node) {
    this.#right = node;
  }

  isLeaf() {
    return this.#left == null && this.#right == null;
  }

  layerWiseInsert(value) {
    let queue = [this];
    while(queue.length > 0) {
      let [node] = queue.splice(0, 1);
      if (node.left() == null) {
        node.setLeft(new BinaryTreeNode(value));
        return;
      } else {
        queue.push(node.#left);
      }
      if (node.right() == null) {
        node.setRight(new BinaryTreeNode(value));
        return;
      } else {
        queue.push(node.#right);
      }
    }
  }

  valueAsText() {
    return `${this.#value}`;
  }
}

class BinaryTree {
  #root = null;

  layerWiseInsert(value) {
    if (this.#root == null) {
      this.#root = new BinaryTreeNode(value);
      return;
    }
    this.#root.layerWiseInsert(value);
  }

  layerWiseInserts(values = []) {
    for (let v of values)
      this.layerWiseInsert(v);
  }

  toString() {
    return BinaryTreePrint.print(this.#root);
  }
}

class Line {
  #line
  #valueStartIndex;
  #valueLength;

  constructor() {
    this.#line = "";
    this.#valueStartIndex = -1;
    this.#valueLength = -1;
  }

  setValueText(content) {
    this.#valueStartIndex = this.#line.length;
    this.#valueLength = content.length;
    this.#line += content;
  }

  append(content) {
    this.#line += content;
    return this;
  }

  length() {
    return this.#line.length;
  }

  valueStartIndex() {
    return this.#valueStartIndex;
  }

  valueLength() {
    return this.#valueLength;
  }

  line() {
    return this.#line;
  }
}

class BinaryTreePrint {

  static print(root) {
    let lines = BinaryTreePrint.printLines(root);
    return lines.map(line => line.line()).join('\n');
  }

  static printLines(root) {
    let rootLine = new Line();
    let outLines = [rootLine];

    if (root == null) {
      rootLine.setValueText('null');
      return outLines;
    }
    if (root.isLeaf()) {
      rootLine.setValueText(root.valueAsText());
      return outLines;
    }

    if (root.left() != null) {
      let leftLines = BinaryTreePrint.printLines(root.left());
      BinaryTreePrint.processLeftLines(leftLines, outLines, rootLine);
    }

    rootLine.setValueText(root.valueAsText());

    if (root.right() != null) {
      let rightLines = BinaryTreePrint.printLines(root.right());
      BinaryTreePrint.processRightLines(rightLines, outLines, rootLine);
    }

    return outLines;
  }

  static processLeftLines(leftLines, outLines, rootLine) {
    let endIndexOfLeftRoot = leftLines[0].valueStartIndex() + leftLines[0].valueLength() - 1;
    rootLine.append(' '.repeat(endIndexOfLeftRoot) + '╭-');

    let lineLengths = leftLines.map(l => l.length());
    let longestLeftLineLength = Math.max(...lineLengths);
    rootLine.append('-'.repeat(longestLeftLineLength - (endIndexOfLeftRoot + 1)));

    outLines.push(...leftLines);
  }

  static processRightLines(rightLines, outLines, rootLine) {
    let lineLengths = outLines.map(line => line.length());
    let longestOutLineLength = Math.max(...lineLengths);
    outLines
        .filter(l => l.length() < longestOutLineLength)
        .forEach(l => l.append(' '.repeat(longestOutLineLength - l.length())));

    let startIndexOfRightRoot = rightLines[0].valueStartIndex();
    rootLine.append('-'.repeat(startIndexOfRightRoot) + '-╮');

    while (outLines.length < rightLines.length + 1)
      outLines.add(new Line().append(' '.repeat(longestOutLineLength)));

    for (let i = 0; i < rightLines.length; i++) {
      outLines[i + 1].append(' ').append(rightLines[i].line());
    }
  }
}

let root = new BinaryTreeNode(
	8, 
	new BinaryTreeNode(
		11, 
		new BinaryTreeNode(
			19, 
			new BinaryTreeNode(78, new BinaryTreeNode(89), new BinaryTreeNode(115)), 
			null
		), 
		null
	), 
	new BinaryTreeNode(56, new BinaryTreeNode(33), new BinaryTreeNode(4))
)  
</script>