# Disjoint-set

Store a collection of disjoint (non-overlapping) sets.

## Perspective

Think of Disjoint-set as a tree of arbitrary arity. Unlike a traditional binary tree, where nodes maintain links to their children, nodes in disjoint-set instead maintain link to their parents. 

## Optimizations

With the help of two key optimizations, all operations on it end up with near constant $O(1)$ time complexity.

1. Compression: we don't care for _"is parent of"_ relation. Only the representative node (aka _root_) is what interests us.
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640.1785888671875 323.92857360839844" width="640.1785888671875" height="323.92857360839844">
  <g stroke-linecap="round" transform="translate(106.07147216796875 67.85722351074219) rotate(0 24.5 24.5)"><path d="M19.59 0.13 C24.23 -1.38, 30.6 -0.64, 35.24 1.86 C39.87 4.36, 45.26 10, 47.41 15.12 C49.56 20.24, 49.64 27.55, 48.13 32.6 C46.63 37.65, 42.79 42.8, 38.38 45.42 C33.98 48.05, 26.86 49.21, 21.72 48.35 C16.57 47.49, 10.99 43.89, 7.5 40.27 C4.01 36.65, 1.29 31.8, 0.78 26.63 C0.28 21.46, 0.73 13.69, 4.45 9.26 C8.16 4.83, 19.28 1.64, 23.08 0.05 C26.89 -1.54, 27.24 -0.55, 27.29 -0.27 M33.43 2.85 C38.49 4.23, 44.74 7.58, 47.1 11.96 C49.46 16.35, 48.59 23.76, 47.59 29.15 C46.6 34.54, 44.82 41.07, 41.14 44.3 C37.45 47.53, 30.95 48.84, 25.49 48.54 C20.02 48.24, 12.55 45.97, 8.35 42.51 C4.16 39.05, 0.92 33.09, 0.29 27.76 C-0.33 22.44, 1.67 15.05, 4.61 10.58 C7.55 6.1, 13.16 2.35, 17.93 0.92 C22.7 -0.52, 30.85 1.71, 33.23 1.98 C35.61 2.25, 32.2 2.28, 32.22 2.53" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(125.81736335311709 80.03310737167175) rotate(0 4.92999267578125 12.5)"><text x="4.92999267578125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">p</text></g><g stroke-linecap="round" transform="translate(10 176.3571014404297) rotate(0 24.5 24.5)"><path d="M25.88 0.43 C30.76 0.29, 36.17 3.51, 39.99 6.77 C43.82 10.02, 47.76 14.97, 48.82 19.96 C49.87 24.94, 49.06 32.03, 46.33 36.65 C43.59 41.27, 37.53 45.91, 32.39 47.66 C27.25 49.4, 20.34 49.01, 15.47 47.12 C10.59 45.22, 5.74 40.97, 3.16 36.31 C0.59 31.65, -1.15 24.33, 0.02 19.17 C1.19 14.02, 5.69 8.48, 10.19 5.38 C14.7 2.27, 23.64 1.33, 27.05 0.52 C30.47 -0.29, 30.47 0.17, 30.67 0.51 M17.14 2.37 C21.58 0.33, 28 -0.09, 32.98 1.53 C37.96 3.15, 44.19 7.36, 47.01 12.1 C49.84 16.85, 51.27 24.76, 49.91 30.01 C48.56 35.25, 43.26 40.53, 38.89 43.57 C34.52 46.61, 28.66 48.35, 23.7 48.25 C18.73 48.16, 13.08 46.44, 9.09 43 C5.1 39.57, 0.91 32.68, -0.24 27.66 C-1.38 22.63, -0.54 17.3, 2.22 12.84 C4.97 8.39, 14.07 2.57, 16.3 0.95 C18.52 -0.67, 15.66 2.56, 15.55 3.13" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(28.005885691984272 188.53298530135925) rotate(0 6.6699981689453125 12.5)"><text x="6.6699981689453125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">a</text></g><g stroke-linecap="round" transform="translate(105.571533203125 174.6428680419922) rotate(0 24.5 24.5)"><path d="M16.23 0.88 C21.03 -0.93, 29.01 -0.1, 34.07 1.91 C39.14 3.93, 44.31 8.6, 46.6 12.98 C48.89 17.36, 48.89 23.14, 47.83 28.18 C46.77 33.22, 44.06 39.84, 40.23 43.21 C36.4 46.59, 30.05 48.4, 24.86 48.43 C19.67 48.46, 13.11 46.87, 9.06 43.4 C5.01 39.92, 1.47 32.74, 0.56 27.59 C-0.36 22.43, 0.6 16.87, 3.57 12.48 C6.53 8.09, 15.67 3.23, 18.32 1.26 C20.98 -0.7, 19.44 0.41, 19.51 0.66 M17.76 -0.33 C22.28 -2.1, 30.03 -1.43, 35.05 1.11 C40.08 3.65, 45.77 9.98, 47.93 14.9 C50.09 19.82, 49.48 25.75, 48.02 30.63 C46.56 35.51, 43.53 41.16, 39.19 44.18 C34.84 47.2, 27.57 49.42, 21.95 48.75 C16.33 48.08, 9.1 43.94, 5.45 40.15 C1.8 36.35, 0.25 30.78, 0.04 26 C-0.18 21.22, 0.83 15.59, 4.15 11.47 C7.48 7.34, 17.5 3.16, 20 1.24 C22.51 -0.68, 19.53 -0.14, 19.2 -0.04" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(125.16742286239443 186.81875190292175) rotate(0 5.079994201660156 12.5)"><text x="5.079994201660156" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">b</text></g><g stroke-linecap="round" transform="translate(111.28573608398438 264.92857360839844) rotate(0 24.5 24.5)"><path d="M27.53 -0.57 C32.4 -0.27, 38.32 4.1, 41.91 7.81 C45.5 11.52, 48.76 16.65, 49.07 21.71 C49.38 26.77, 46.64 33.86, 43.76 38.17 C40.87 42.48, 36.65 46.14, 31.75 47.58 C26.86 49.02, 19.19 48.93, 14.4 46.8 C9.6 44.68, 5.29 39.62, 2.98 34.83 C0.68 30.03, -0.74 22.97, 0.56 18.01 C1.86 13.05, 5.82 7.83, 10.79 5.07 C15.75 2.32, 26.64 1.95, 30.36 1.5 C34.07 1.05, 33.35 2.21, 33.06 2.37 M13.81 2.86 C18.45 0.77, 25.52 0.99, 30.87 2.12 C36.23 3.26, 42.88 5.83, 45.93 9.68 C48.98 13.53, 49.94 19.83, 49.17 25.22 C48.4 30.61, 44.85 37.94, 41.33 42.03 C37.81 46.11, 32.99 49.11, 28.05 49.74 C23.12 50.37, 16.48 49.05, 11.71 45.79 C6.95 42.54, 1.08 35.21, -0.56 30.2 C-2.2 25.18, -0.28 20.24, 1.89 15.73 C4.07 11.22, 10.38 5.31, 12.5 3.14 C14.61 0.96, 14.13 2.25, 14.6 2.68" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(130.94162330184756 277.104457469328) rotate(0 5.019996643066406 12.5)"><text x="5.019996643066406" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">c</text></g><g stroke-linecap="round"><g transform="translate(135.07150268554688 265.42860412597656) rotate(0 -1.9323695070529396 -19.70988608506974)"><path d="M-0.81 -0.7 C-1.44 -7.65, -4.1 -34.32, -4.83 -40.97 M0.96 1.55 C0.8 -5.25, -1.9 -31.98, -2.55 -39.34" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(135.07150268554688 265.42860412597656) rotate(0 -1.9323695070529396 -19.70988608506974)"><path d="M5.14 -22.04 C4.58 -26.68, 3.31 -29.96, -0.64 -39.57 M5.97 -20.56 C3.94 -26.65, -0.85 -34.93, -1.77 -39.2" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(135.07150268554688 265.42860412597656) rotate(0 -1.9323695070529396 -19.70988608506974)"><path d="M-8.94 -20.72 C-6.5 -25.55, -4.76 -29.11, -0.64 -39.57 M-8.11 -19.24 C-5.02 -25.85, -4.69 -34.61, -1.77 -39.2" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(131.07150268554688 172.85716247558594) rotate(0 -0.11512628611642839 -27.30731224641204)"><path d="M0.68 -0.37 C0.42 -9.26, -0.27 -45.37, -0.56 -54.25 M-0.43 -1.61 C-0.83 -10.26, -0.72 -44.55, -0.91 -52.99" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(131.07150268554688 172.85716247558594) rotate(0 -0.11512628611642839 -27.30731224641204)"><path d="M7.88 -25.9 C4.2 -36.36, 1.67 -48.4, 0.09 -52.11 M8.32 -28.57 C6.57 -35.03, 4.34 -39.67, -0.91 -52.91" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(131.07150268554688 172.85716247558594) rotate(0 -0.11512628611642839 -27.30731224641204)"><path d="M-10.5 -25.74 C-7.15 -36.37, -2.65 -48.47, 0.09 -52.11 M-10.06 -28.42 C-7.18 -35.09, -4.78 -39.77, -0.91 -52.91" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(48.21435546875 180.28578186035156) rotate(0 31.914860696396794 -33.41991992963011)"><path d="M0.86 0.84 C11.46 -10.05, 53.63 -54.77, 63.97 -65.81 M-0.14 0.24 C10.31 -10.98, 52.97 -56.43, 63.31 -67.68" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(48.21435546875 180.28578186035156) rotate(0 31.914860696396794 -33.41991992963011)"><path d="M53.02 -39.15 C56.41 -50.17, 61.03 -57.27, 63.97 -67.38 M51.65 -40.24 C54.22 -46.94, 56.78 -55.52, 63.83 -68.01" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(48.21435546875 180.28578186035156) rotate(0 31.914860696396794 -33.41991992963011)"><path d="M38 -53.13 C46.35 -59.59, 55.98 -62.03, 63.97 -67.38 M36.62 -54.22 C43.17 -57.33, 49.67 -62.24, 63.83 -68.01" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(439.03578186035156 58.10719299316406) rotate(0 24.5 24.5)"><path d="M27.35 0.69 C32.51 1.1, 38.79 4.21, 42.27 7.95 C45.75 11.69, 47.95 17.97, 48.24 23.14 C48.54 28.3, 46.96 34.86, 44.03 38.94 C41.1 43.01, 35.66 46.43, 30.68 47.6 C25.7 48.76, 18.95 48.06, 14.14 45.92 C9.33 43.79, 4.1 39.4, 1.82 34.79 C-0.47 30.17, -1.1 23.31, 0.45 18.25 C2 13.18, 6.36 7.19, 11.12 4.38 C15.87 1.58, 25.48 2.04, 28.98 1.43 C32.48 0.82, 32.08 0.34, 32.13 0.72 M30.24 0.68 C35.2 1.64, 40.21 6.54, 43.58 10.87 C46.95 15.21, 50.59 21.85, 50.45 26.71 C50.3 31.57, 46.51 36.12, 42.72 40.03 C38.93 43.94, 33.01 49.22, 27.7 50.16 C22.39 51.09, 15.36 48.62, 10.86 45.63 C6.36 42.64, 2.29 37.07, 0.72 32.22 C-0.85 27.37, -0.57 21.5, 1.44 16.51 C3.44 11.52, 8.11 4.83, 12.74 2.29 C17.38 -0.26, 26.22 1.61, 29.24 1.24 C32.26 0.86, 31.06 -0.31, 30.86 0.04" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(458.7816730454999 70.28307685409368) rotate(0 4.92999267578125 12.5)"><text x="4.92999267578125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">p</text></g><g stroke-linecap="round" transform="translate(317.24998474121094 163.7499237060547) rotate(0 24.5 24.5)"><path d="M31 1.76 C35.71 2.85, 41.6 7.28, 44.56 11.47 C47.52 15.66, 49.29 21.87, 48.74 26.9 C48.19 31.94, 45.18 38, 41.28 41.68 C37.38 45.36, 30.66 48.55, 25.34 48.98 C20.01 49.4, 13.36 47.4, 9.34 44.24 C5.32 41.08, 2.37 34.99, 1.23 30.01 C0.08 25.03, 0.06 19.16, 2.44 14.35 C4.83 9.53, 10.1 3.02, 15.56 1.14 C21.02 -0.75, 31.52 2.6, 35.2 3.04 C38.87 3.48, 37.85 3.48, 37.61 3.75 M26.74 1.11 C31.83 0.57, 37.34 1.64, 41.01 5.18 C44.69 8.72, 48.15 16.91, 48.8 22.36 C49.44 27.82, 47.72 33.59, 44.88 37.89 C42.04 42.19, 36.74 46.37, 31.75 48.17 C26.76 49.96, 19.85 50.77, 14.96 48.67 C10.07 46.58, 4.93 40.37, 2.43 35.62 C-0.08 30.86, -1.42 25.37, -0.08 20.14 C1.26 14.91, 6.45 7.51, 10.47 4.22 C14.49 0.92, 21.78 0.88, 24.02 0.38 C26.26 -0.13, 23.6 0.82, 23.91 1.18" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(335.2558704331952 175.92580756698425) rotate(0 6.6699981689453125 12.5)"><text x="6.6699981689453125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">a</text></g><g stroke-linecap="round" transform="translate(403.6786651611328 163.74998474121094) rotate(0 24.5 24.5)"><path d="M32.65 0.83 C37.55 2.04, 43.12 6.74, 45.71 11.37 C48.31 16, 49.17 23.28, 48.21 28.61 C47.26 33.94, 43.79 39.94, 39.96 43.34 C36.14 46.74, 30.48 48.84, 25.26 49 C20.04 49.17, 12.69 47.83, 8.65 44.34 C4.61 40.86, 1.84 33.29, 1.03 28.1 C0.21 22.92, 1.2 17.72, 3.76 13.24 C6.33 8.75, 11.25 2.98, 16.41 1.18 C21.57 -0.62, 31.41 2.09, 34.7 2.43 C38 2.78, 36.24 2.75, 36.19 3.24 M33.32 2.99 C37.99 4.74, 43.01 8.67, 45.49 13.1 C47.96 17.53, 49.15 24.25, 48.15 29.56 C47.15 34.87, 43.57 41.8, 39.48 44.96 C35.39 48.12, 28.87 48.76, 23.59 48.54 C18.32 48.32, 11.53 47.18, 7.83 43.64 C4.14 40.1, 2.36 32.54, 1.43 27.31 C0.5 22.08, -0.04 16.47, 2.25 12.25 C4.54 8.04, 9.89 3.77, 15.18 2.02 C20.46 0.27, 30.92 1.81, 33.96 1.74 C36.99 1.66, 33.69 1.27, 33.38 1.59" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(423.2745548204022 175.9258686021405) rotate(0 5.079994201660156 12.5)"><text x="5.079994201660156" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">b</text></g><g stroke-linecap="round" transform="translate(491.10728454589844 158.60707092285156) rotate(0 24.5 24.5)"><path d="M16.95 1.06 C21.56 -0.53, 28.72 0.08, 33.72 2.15 C38.72 4.21, 44.55 8.62, 46.96 13.44 C49.36 18.25, 49.32 26.07, 48.13 31.04 C46.94 36.02, 43.89 40.17, 39.82 43.29 C35.75 46.42, 28.99 50.02, 23.72 49.81 C18.45 49.6, 12.09 45.71, 8.19 42.02 C4.28 38.34, 0.99 32.88, 0.3 27.69 C-0.39 22.49, 0.48 15.26, 4.05 10.85 C7.62 6.44, 18.21 2.95, 21.74 1.25 C25.26 -0.46, 25.41 0.37, 25.21 0.61 M34.83 2.87 C39.45 4.93, 44.31 11.3, 46.43 15.95 C48.56 20.61, 49.04 25.87, 47.57 30.78 C46.1 35.7, 41.69 42.61, 37.61 45.46 C33.53 48.3, 28.4 48.43, 23.07 47.84 C17.74 47.24, 9.69 45.38, 5.63 41.89 C1.58 38.4, -1.23 32.18, -1.28 26.9 C-1.33 21.62, 2 14.66, 5.36 10.22 C8.71 5.77, 13.92 1.57, 18.85 0.24 C23.78 -1.09, 32.05 1.6, 34.92 2.23 C37.8 2.86, 36.27 3.69, 36.1 4.01" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(510.76317176376165 170.78295478378112) rotate(0 5.019996643066406 12.5)"><text x="5.019996643066406" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">c</text></g><g stroke-linecap="round"><g transform="translate(437.3497584456563 163.59579028963446) rotate(0 7.684799724382543 -28.73363054936422)"><path d="M0.01 -0.49 C2.96 -9.61, 14.04 -45.94, 16.81 -55.23 M-1.44 -1.8 C1.45 -11.21, 13.09 -48.1, 15.97 -56.98" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(437.3497584456563 163.59579028963446) rotate(0 7.684799724382543 -28.73363054936422)"><path d="M16.32 -27.47 C18.2 -34.39, 16.28 -39.03, 17.22 -58.6 M16.79 -27.7 C16.74 -38.14, 15.8 -47.75, 16.95 -56.24" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(437.3497584456563 163.59579028963446) rotate(0 7.684799724382543 -28.73363054936422)"><path d="M-2.69 -33.54 C3.45 -39.09, 5.82 -42.36, 17.22 -58.6 M-2.22 -33.76 C4.55 -42.13, 10.39 -49.58, 16.95 -56.24" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(358.59372040238736 169.1047266849631) rotate(0 41.13870441458943 -33.497256791050745)"><path d="M0.21 0.72 C14.11 -10.49, 69.36 -56.48, 83.42 -67.71 M-1.14 0.05 C12.6 -10.93, 68.21 -54.87, 82.47 -66.32" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(358.59372040238736 169.1047266849631) rotate(0 41.13870441458943 -33.497256791050745)"><path d="M68 -40.73 C71.17 -46.52, 77.6 -57.79, 83.6 -64.63 M67.07 -40.67 C72.03 -48.72, 78.65 -57.62, 82.6 -67.02" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(358.59372040238736 169.1047266849631) rotate(0 41.13870441458943 -33.497256791050745)"><path d="M55.22 -56.79 C62.18 -57.77, 72.45 -64.2, 83.6 -64.63 M54.29 -56.73 C63.59 -59.27, 74.61 -62.65, 82.6 -67.02" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(507.6011186264194 158.49851587832592) rotate(0 -15.692003645765482 -25.50512246247885)"><path d="M1.02 0.36 C-4.31 -7.93, -27.12 -41.08, -32.41 -49.62 M0.1 -0.49 C-4.82 -9.14, -24.93 -43.15, -30.1 -51.37" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(507.6011186264194 158.49851587832592) rotate(0 -15.692003645765482 -25.50512246247885)"><path d="M-6.33 -34.07 C-11.97 -35.95, -20.22 -44.48, -29 -52.17 M-6.46 -33.68 C-11.03 -37.17, -16.05 -40.13, -29.82 -50.97" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(507.6011186264194 158.49851587832592) rotate(0 -15.692003645765482 -25.50512246247885)"><path d="M-23.7 -23.53 C-24.72 -28.37, -28.34 -39.71, -29 -52.17 M-23.84 -23.14 C-24.59 -29, -25.86 -34.25, -29.82 -50.97" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(208.89291381835938 264.78578186035156) rotate(0 24.5 24.5)"><path d="M31.77 0.86 C36.59 2.42, 42.06 8.17, 44.97 12.82 C47.87 17.47, 49.89 23.67, 49.2 28.75 C48.52 33.82, 44.97 39.9, 40.83 43.27 C36.7 46.64, 29.8 49.01, 24.39 48.96 C18.97 48.91, 12.2 46.17, 8.34 42.98 C4.48 39.79, 1.99 35.07, 1.24 29.82 C0.48 24.58, 1.24 16.17, 3.8 11.51 C6.37 6.85, 11.69 3.65, 16.62 1.87 C21.56 0.09, 30.38 0.8, 33.43 0.82 C36.48 0.83, 35.15 1.38, 34.91 1.95 M29.33 1.54 C34.57 2.74, 42.19 6.55, 45.5 10.65 C48.8 14.75, 49.78 21.06, 49.16 26.14 C48.54 31.21, 45.51 37.11, 41.8 41.11 C38.09 45.12, 32.09 49.35, 26.91 50.17 C21.72 50.99, 15.02 48.96, 10.7 46.04 C6.37 43.12, 2.3 37.9, 0.96 32.65 C-0.37 27.4, 0.35 19.6, 2.68 14.55 C5.01 9.51, 10.34 4.9, 14.96 2.39 C19.58 -0.11, 28.13 -0.41, 30.42 -0.46 C32.72 -0.52, 28.7 1.42, 28.74 2.06" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(227.87880286727724 276.9616657212811) rotate(0 5.689994812011719 12.5)"><text x="5.689994812011719" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">d</text></g><g stroke-linecap="round"><g transform="translate(221.82150268554688 263.71437072753906) rotate(0 -34.08813530579209 -23.66368732079863)"><path d="M1.17 0.93 C-10.29 -7.21, -57.74 -40.32, -69.35 -48.26 M0.33 0.37 C-10.7 -7.69, -55.46 -38.99, -67.05 -47.15" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(221.82150268554688 263.71437072753906) rotate(0 -34.08813530579209 -23.66368732079863)"><path d="M-36.53 -40.65 C-46.85 -40.9, -51.57 -41.47, -65.88 -45.71 M-37.83 -39.78 C-47.06 -41.79, -54.78 -43.25, -67.5 -46.48" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(221.82150268554688 263.71437072753906) rotate(0 -34.08813530579209 -23.66368732079863)"><path d="M-48.32 -23.85 C-55.73 -28.48, -57.45 -33.32, -65.88 -45.71 M-49.63 -22.98 C-55.45 -29.89, -59.72 -36.26, -67.5 -46.48" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(581.1785888671875 157.21424865722656) rotate(0 24.5 24.5)"><path d="M28.48 0.39 C33.33 1.06, 40.05 5.56, 43.59 9.72 C47.13 13.89, 49.77 20.12, 49.72 25.38 C49.68 30.63, 46.81 37.42, 43.32 41.26 C39.83 45.1, 33.92 47.63, 28.78 48.4 C23.64 49.17, 17.11 48.59, 12.5 45.89 C7.89 43.2, 2.98 37.2, 1.12 32.23 C-0.74 27.27, -0.65 20.96, 1.36 16.11 C3.37 11.25, 8.07 5.73, 13.17 3.09 C18.26 0.45, 28.48 0.3, 31.92 0.24 C35.36 0.19, 33.78 2.19, 33.81 2.75 M22.76 -0.52 C27.87 -1.5, 34.06 0.22, 38.07 3.26 C42.08 6.29, 45.37 12.69, 46.83 17.67 C48.29 22.65, 48.99 28.47, 46.84 33.14 C44.7 37.8, 38.57 43.23, 33.96 45.65 C29.35 48.06, 24.1 48.78, 19.17 47.6 C14.24 46.43, 7.72 42.88, 4.38 38.61 C1.04 34.34, -1.46 27.1, -0.87 21.98 C-0.29 16.86, 4 11.55, 7.87 7.87 C11.74 4.19, 20.13 1.32, 22.34 -0.1 C24.55 -1.52, 21.27 -1.08, 21.16 -0.66" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(600.1644779161054 169.39013251815612) rotate(0 5.689994812011719 12.5)"><text x="5.689994812011719" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">d</text></g><g stroke-linecap="round"><g transform="translate(590.96435546875 156.85716247558594) rotate(0 -49.92935813749676 -30.039892283827072)"><path d="M0.68 1.03 C-16.06 -9.17, -82.79 -50.93, -99.34 -61.11 M-0.42 0.53 C-17.46 -9.57, -84.08 -50.28, -100.54 -60.16" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(590.96435546875 156.85716247558594) rotate(0 -49.92935813749676 -30.039892283827072)"><path d="M-69.39 -55.12 C-84.52 -55.99, -94.3 -58.01, -100.42 -61.79 M-71.86 -54.23 C-82.51 -56.17, -91.87 -59.21, -100.64 -60.57" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(590.96435546875 156.85716247558594) rotate(0 -49.92935813749676 -30.039892283827072)"><path d="M-80.03 -37.58 C-91 -45.39, -96.59 -54.3, -100.42 -61.79 M-82.5 -36.68 C-89.44 -45.04, -94.97 -54.4, -100.64 -60.57" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(196.96432495117188 10) rotate(0 113.639892578125 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">Example of compression</text></g></svg>

2. Union by size: always union smaller set into larger sets. This eases out the future `find` calls by keep the height of the tree short.

=== "Implementation"

    ```java
    import java.util.ArrayList;
    import java.util.Collection;
    import java.util.HashMap;
    import java.util.HashSet;
    import java.util.List;
    import java.util.Map;
    import java.util.Objects;
    import java.util.Set;
    import java.util.stream.Collectors;
    import java.util.stream.Stream;

    public class DisjointSet<T> {
      private Map<T, T> parent;
      private Map<T, Integer> size;
      private int connectedComponents;

      public DisjointSet() {
        this.parent = new HashMap<>();
        this.size = new HashMap<>();
        this.connectedComponents = 0;
      }

      public void makeSet(T node) { // lone node
        parent.put(node, node);     // not connected
        size.put(node, 1);          // to anyone else.
        connectedComponents++;
      }

      public T find(T node) {
        T parent = this.parent.get(node);
        if (parent == null || Objects.equals(parent, node)) // makeSet not called.
          return parent;                                    // or node is root.

        T root = find(parent);                              // compression
        this.parent.put(node, root);
        return root;
      }

      public boolean union(T a, T b) {
        T rootA = find(a), rootB = find(b);
        if (Objects.equals(rootA, rootB))
          return false;

        int sizeA = size.get(rootA), sizeB = size.get(rootB);
        if (sizeA >= sizeB) {                              // "=" so we don't get
          parent.put(rootB, rootA);                        // stuck in infinite
          size.put(rootA, sizeA + sizeB);                  // loop.
          connectedComponents--;
          return true;
        }
        return union(rootB, rootA);
      }

      public int countConnectedComponents() {
        return connectedComponents;
      }

      public Set<Set<T>> connectedComponents() {           // Order doesn't matter.
        Map<T, Set<T>> connectedComponents = new HashMap<>();
        parent.forEach((key, value) -> {
          connectedComponents.putIfAbsent(find(value), new HashSet<>());
          connectedComponents.get(find(value)).add(key);
        });
        return new HashSet<>(connectedComponents.values());
      }
    }
    ```

=== "Unit tests"

    ```java
    import static org.junit.jupiter.api.Assertions.*;
    import static org.assertj.core.api.Assertions.*;

    import java.util.List;
    import java.util.Set;
    import org.junit.jupiter.api.BeforeEach;
    import org.junit.jupiter.api.Test;

    class DisjointSetTest {

      private DisjointSet<Integer> set;

      @BeforeEach
      public void setup() {
        set = new DisjointSet<>();
        for (int i = 1; i <= 5; i++)
          set.makeSet(i);
      }

      @Test
      public void testMakeSet() {
        DisjointSet<Integer> set = new DisjointSet<>();

        assertEquals(0, set.countConnectedComponents());
        assertThat(set.connectedComponents()).isEmpty();

        set.makeSet(1);
        assertThat(set.countConnectedComponents()).isEqualTo(1);
        assertThat(set.connectedComponents()).isEqualTo(Set.of(Set.of(1)));

        set.makeSet(2);
        assertThat(set.countConnectedComponents()).isEqualTo(2);
        assertThat(set.connectedComponents()).isEqualTo(Set.of(Set.of(1), Set.of(2)));

        set.makeSet(3);
        assertThat(set.countConnectedComponents()).isEqualTo(3);
        assertThat(set.connectedComponents()).isEqualTo(Set.of(Set.of(1), Set.of(2), Set.of(3)));
      }

      @Test
      public void testUnion() {
        assertThat(set.countConnectedComponents()).isEqualTo(5);
        assertThat(set.connectedComponents()).isEqualTo(Set.of(Set.of(1), Set.of(2), Set.of(3), Set.of(4), Set.of(5)));

        assertTrue(set.union(1, 2));
        assertThat(set.countConnectedComponents()).isEqualTo(4);
        assertThat(set.connectedComponents()).isEqualTo(Set.of(Set.of(1, 2), Set.of(3), Set.of(4), Set.of(5)));

        assertTrue(set.union(2, 3));
        assertThat(set.countConnectedComponents()).isEqualTo(3);
        assertThat(set.connectedComponents()).isEqualTo(Set.of(Set.of(1, 2, 3), Set.of(4), Set.of(5)));

        assertTrue(set.union(5, 4));
        assertThat(set.countConnectedComponents()).isEqualTo(2);
        assertThat(set.connectedComponents()).isEqualTo(Set.of(Set.of(1, 2, 3), Set.of(4, 5)));

        assertTrue(set.union(4, 2));
        assertThat(set.countConnectedComponents()).isEqualTo(1);
        assertThat(set.connectedComponents()).isEqualTo(Set.of(Set.of(1, 2, 3, 4, 5)));

        assertFalse(set.union(1, 5));
      }

    }
    ```
