# Doubly Linked List

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

<link rel="stylesheet" type="text/css" href="http://tikzjax.com/v1/fonts.css">
<script src="https://tikzjax.com/v1/tikzjax.js"></script>

We previously saw the [singly-linked implementation of a linked list](singly-linked-list.md), and one major shortcoming is immediately apparent: almost every operation has check for boundary conditions.

## Sentinel

We can make two changes to vastly simplify our linked list implementation.

1. Maintain reference to \\(predecessor\\) in each linked list node.
2. Turn linked list circular with a \\(sentinel\\) node.

<div style="text-align:center;">
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 338.94293570518494 296.67578125" width="300">
  <g stroke-linecap="round" transform="translate(139.23748898506165 10) rotate(0 25.240234375 24.5)"><path d="M14.6 2.94 C19.32 0.5, 26.95 -0.67, 32.24 0.68 C37.53 2.03, 43.36 6.63, 46.34 11.04 C49.31 15.46, 50.64 22.16, 50.09 27.17 C49.54 32.18, 46.74 37.54, 43.03 41.09 C39.32 44.65, 33.24 47.8, 27.82 48.48 C22.39 49.15, 14.98 47.92, 10.5 45.14 C6.03 42.37, 2.21 36.94, 0.95 31.83 C-0.32 26.72, 0.32 19.56, 2.94 14.48 C5.55 9.4, 13.91 3.72, 16.63 1.34 C19.36 -1.03, 18.94 -0.25, 19.28 0.25 M22.14 1.43 C27.23 0.62, 33.63 1.39, 38.24 4.05 C42.85 6.71, 48.34 12.16, 49.79 17.39 C51.24 22.62, 49.18 30.57, 46.94 35.43 C44.7 40.29, 41.06 44.31, 36.36 46.56 C31.66 48.81, 23.81 50.39, 18.72 48.93 C13.62 47.46, 8.82 42.02, 5.76 37.79 C2.71 33.55, 0.13 28.44, 0.37 23.52 C0.61 18.59, 3.17 12.16, 7.19 8.23 C11.21 4.31, 22.04 1.47, 24.48 -0.03 C26.91 -1.53, 22.04 -1.4, 21.82 -0.76" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(157.68018254628691 22.17588386092956) rotate(0 6.949999928474426 12.5)"><text x="6.949999928474426" y="17.619999999999997" font-family="Virgil, Xiaolai, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Φ</text></g><g stroke-linecap="round" transform="translate(261.07928586006165 103.4453125) rotate(0 25.240234375 24.5)"><path d="M21.63 0.94 C26.84 0.25, 34.71 1.44, 39.24 4.24 C43.77 7.03, 47.46 12.82, 48.83 17.71 C50.19 22.59, 49.45 28.87, 47.45 33.55 C45.45 38.22, 41.69 43.41, 36.83 45.76 C31.96 48.11, 23.52 48.9, 18.24 47.66 C12.95 46.41, 8.08 42.46, 5.13 38.3 C2.18 34.14, 0.21 27.82, 0.54 22.71 C0.87 17.61, 3.1 11.48, 7.11 7.66 C11.12 3.85, 21.49 0.91, 24.61 -0.17 C27.73 -1.25, 26.01 0.62, 25.82 1.16 M24.08 -0.6 C29.59 -0.97, 37.63 3.25, 42.02 6.75 C46.41 10.26, 49.65 15.27, 50.43 20.42 C51.2 25.57, 49.26 32.95, 46.66 37.64 C44.06 42.33, 39.96 46.89, 34.84 48.55 C29.72 50.21, 21.3 49.4, 15.96 47.6 C10.61 45.8, 5.3 42.3, 2.75 37.77 C0.2 33.23, -0.14 25.57, 0.66 20.37 C1.47 15.18, 3.55 9.89, 7.59 6.6 C11.62 3.31, 22.05 1.85, 24.88 0.64 C27.71 -0.57, 24.72 -1.05, 24.57 -0.64" stroke="none" stroke-width="0" fill="#ffec99"></path><path d="M13.32 3.7 C17.63 1.15, 25.59 -0.35, 30.83 0.59 C36.07 1.52, 41.43 5.23, 44.76 9.32 C48.1 13.41, 51.09 19.92, 50.83 25.12 C50.58 30.33, 46.88 36.62, 43.23 40.57 C39.59 44.52, 34.24 48.11, 28.96 48.85 C23.67 49.58, 16.21 47.9, 11.51 44.99 C6.81 42.08, 2.28 36.42, 0.76 31.36 C-0.76 26.3, 0.14 19.52, 2.39 14.64 C4.64 9.77, 11.87 4.17, 14.24 2.11 C16.6 0.06, 16.41 2.08, 16.58 2.33 M35.61 1.06 C39.94 3.02, 44.74 9.87, 46.83 14.82 C48.93 19.77, 49.42 25.94, 48.18 30.76 C46.94 35.58, 43.63 40.84, 39.4 43.75 C35.16 46.65, 28.23 48.34, 22.76 48.17 C17.29 47.99, 10.16 46.23, 6.58 42.7 C2.99 39.17, 1.74 32.29, 1.23 26.98 C0.71 21.66, 0.58 15.2, 3.5 10.8 C6.43 6.4, 13.07 1.78, 18.76 0.57 C24.45 -0.64, 34.83 2.97, 37.64 3.54 C40.46 4.1, 36 3.63, 35.66 3.96" stroke="#1e1e1e" stroke-width="2" fill="none"></path></g><g transform="translate(282.20198270669493 115.62119636092956) rotate(0 4.269996643066406 12.5)"><text x="4.269996643066406" y="17.619999999999997" font-family="Virgil, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g stroke-linecap="round" transform="translate(212.57147336006165 235.328125) rotate(0 25.240234375 24.5)"><path d="M15.35 0.94 C20.21 -1.28, 28.43 -0.22, 33.78 1.52 C39.14 3.26, 44.68 6.88, 47.5 11.39 C50.31 15.9, 51.47 23.37, 50.65 28.56 C49.84 33.74, 46.63 39.1, 42.61 42.5 C38.58 45.89, 32.04 48.64, 26.49 48.94 C20.94 49.25, 13.68 47.42, 9.29 44.32 C4.9 41.21, 1.26 35.38, 0.13 30.31 C-0.99 25.25, -0.46 18.83, 2.52 13.93 C5.5 9.04, 15.14 3.15, 18.03 0.92 C20.91 -1.3, 19.73 0.04, 19.8 0.59 M31.23 2 C36.25 2.95, 43.25 7.08, 46.37 11.32 C49.49 15.57, 50.56 22.57, 49.97 27.46 C49.38 32.35, 46.51 37.32, 42.83 40.66 C39.15 44.01, 33.3 46.79, 27.9 47.53 C22.49 48.28, 14.68 48.19, 10.39 45.11 C6.1 42.02, 3.59 34.34, 2.15 29.02 C0.71 23.7, -0.42 17.61, 1.76 13.21 C3.93 8.82, 10.32 4.62, 15.22 2.63 C20.12 0.63, 28.32 1.2, 31.15 1.25 C33.97 1.3, 32.17 2.8, 32.18 2.91" stroke="none" stroke-width="0" fill="#ffec99"></path><path d="M16.84 1.72 C21.55 -0.06, 29.91 0.86, 34.94 2.54 C39.98 4.22, 44.65 7.25, 47.06 11.78 C49.47 16.32, 50.44 24.5, 49.39 29.74 C48.34 34.98, 44.82 40.11, 40.74 43.21 C36.66 46.3, 30.28 48.38, 24.9 48.33 C19.53 48.28, 12.45 46.17, 8.49 42.9 C4.54 39.64, 1.93 33.97, 1.18 28.74 C0.43 23.51, 0.72 16.33, 3.99 11.52 C7.26 6.7, 17.25 1.75, 20.8 -0.15 C24.34 -2.05, 25.21 -0.34, 25.24 0.09 M25.56 0.39 C30.64 0.65, 37.23 3.61, 41.53 7.09 C45.84 10.57, 50.68 16.01, 51.41 21.24 C52.14 26.48, 49.31 34.27, 45.92 38.49 C42.54 42.71, 36.4 45.22, 31.1 46.56 C25.81 47.91, 18.97 48.18, 14.15 46.56 C9.33 44.95, 4.5 41.52, 2.19 36.86 C-0.13 32.21, -1.1 23.94, 0.28 18.61 C1.66 13.29, 6 8.2, 10.47 4.93 C14.93 1.66, 24.2 -0.11, 27.09 -1.02 C29.99 -1.94, 28.06 -1.04, 27.83 -0.56" stroke="#1e1e1e" stroke-width="2" fill="none"></path></g><g transform="translate(230.96416684976134 247.50400886092956) rotate(0 7 12.5)"><text x="7" y="17.619999999999997" font-family="Virgil, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g stroke-linecap="round" transform="translate(75.96991086006165 237.67578125) rotate(0 25.240234375 24.5)"><path d="M36.05 1.82 C40.78 3.81, 45.82 10.08, 48.17 14.96 C50.52 19.83, 51.44 26.24, 50.16 31.07 C48.89 35.9, 44.93 40.95, 40.51 43.95 C36.1 46.94, 29.14 49.43, 23.67 49.03 C18.19 48.62, 11.56 45.26, 7.67 41.53 C3.78 37.8, 1.01 31.71, 0.34 26.62 C-0.34 21.53, 0.7 15.31, 3.62 11.01 C6.53 6.71, 11.92 1.89, 17.84 0.83 C23.76 -0.24, 35.47 3.91, 39.12 4.64 C42.78 5.37, 40.14 5, 39.78 5.21 M29.69 1.85 C34.93 2.13, 40.5 3.79, 44.2 7.37 C47.89 10.95, 51.66 17.77, 51.86 23.33 C52.07 28.9, 49.31 36.71, 45.45 40.77 C41.59 44.83, 33.96 47.12, 28.7 47.72 C23.44 48.32, 18.29 46.89, 13.88 44.39 C9.47 41.9, 4.53 37.55, 2.23 32.73 C-0.07 27.92, -1.58 20.59, 0.06 15.49 C1.7 10.39, 7.4 4.9, 12.09 2.13 C16.78 -0.63, 25.12 -0.88, 28.22 -1.09 C31.32 -1.3, 30.48 0.24, 30.71 0.86" stroke="none" stroke-width="0" fill="#ffec99"></path><path d="M23.57 -0.29 C28.6 -1.08, 34.87 0.89, 39.22 3.83 C43.56 6.77, 48.26 12.37, 49.63 17.35 C51.01 22.33, 49.64 28.96, 47.45 33.71 C45.26 38.46, 41.18 43.29, 36.5 45.83 C31.81 48.38, 24.68 50.19, 19.35 48.99 C14.01 47.79, 7.65 43.13, 4.49 38.61 C1.33 34.09, 0.11 27.17, 0.39 21.86 C0.67 16.55, 1.63 10.42, 6.17 6.75 C10.71 3.07, 23.03 0.71, 27.64 -0.18 C32.26 -1.07, 33.88 0.91, 33.86 1.4 M27.25 -1.07 C32.19 -1.13, 37.43 2.14, 41.24 5.71 C45.05 9.27, 49.4 15.13, 50.11 20.3 C50.82 25.48, 48.16 32.27, 45.47 36.76 C42.79 41.25, 39.17 45.31, 34.01 47.25 C28.84 49.19, 19.55 50.07, 14.46 48.42 C9.37 46.76, 5.78 42.05, 3.45 37.31 C1.11 32.57, -0.77 25.25, 0.45 20 C1.67 14.75, 6.55 9.07, 10.79 5.82 C15.03 2.56, 23.35 1.47, 25.9 0.47 C28.44 -0.53, 25.92 -0.41, 26.07 -0.19" stroke="#1e1e1e" stroke-width="2" fill="none"></path></g><g transform="translate(95.28261014810118 249.85166511092962) rotate(0 6.079994201660156 12.5)"><text x="6.079994201660156" y="17.619999999999997" font-family="Virgil, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round" transform="translate(28.591004610061646 106.49609375) rotate(0 25.240234375 24.5)"><path d="M22.95 -0.79 C28.01 -1.86, 35.32 0.18, 39.77 3.37 C44.22 6.56, 48.28 13.17, 49.66 18.33 C51.03 23.49, 50.26 29.68, 48.03 34.33 C45.79 38.98, 41.05 43.88, 36.23 46.23 C31.42 48.58, 24.45 49.69, 19.15 48.42 C13.84 47.16, 7.52 42.78, 4.4 38.65 C1.29 34.52, -0.01 28.7, 0.47 23.65 C0.95 18.6, 2.7 12.39, 7.27 8.37 C11.84 4.34, 23.8 0.68, 27.91 -0.5 C32.02 -1.68, 32.03 0.88, 31.92 1.29 M33.92 2.06 C38.94 3.57, 44.7 7.75, 47.42 12.17 C50.14 16.59, 51.28 23.34, 50.24 28.58 C49.2 33.83, 45.57 40.42, 41.19 43.62 C36.81 46.81, 29.69 48.11, 23.95 47.76 C18.22 47.41, 10.66 44.94, 6.8 41.51 C2.94 38.07, 1.42 32.39, 0.8 27.15 C0.17 21.92, 0.22 14.4, 3.07 10.1 C5.91 5.79, 12.51 2.75, 17.86 1.31 C23.21 -0.12, 32.38 1.27, 35.17 1.48 C37.96 1.68, 34.87 2.04, 34.6 2.55" stroke="none" stroke-width="0" fill="#ffec99"></path><path d="M35.05 0.8 C39.73 2.5, 43.99 8.38, 46.57 13.18 C49.16 17.98, 51.63 24.64, 50.57 29.6 C49.52 34.57, 44.66 39.88, 40.25 42.98 C35.85 46.09, 29.52 48.3, 24.13 48.21 C18.75 48.13, 11.82 45.9, 7.92 42.49 C4.02 39.07, 1.49 32.72, 0.74 27.7 C-0.01 22.67, 0.81 16.71, 3.44 12.33 C6.07 7.96, 10.3 2.59, 16.53 1.44 C22.75 0.3, 35.99 3.99, 40.77 5.45 C45.54 6.9, 45.59 9.8, 45.18 10.18 M33.03 0.83 C37.89 1.76, 42.78 6.05, 45.87 10.52 C48.95 14.99, 52.22 22.52, 51.55 27.64 C50.89 32.75, 46.01 37.7, 41.86 41.22 C37.72 44.74, 31.97 48.26, 26.66 48.76 C21.36 49.26, 14.38 47.15, 10.03 44.23 C5.68 41.32, 1.65 36.5, 0.58 31.28 C-0.49 26.06, 1.24 17.59, 3.6 12.91 C5.96 8.23, 10.14 4.96, 14.75 3.18 C19.35 1.41, 28.15 2.43, 31.23 2.27 C34.31 2.11, 33.09 1.99, 33.23 2.23" stroke="#1e1e1e" stroke-width="2" fill="none"></path></g><g transform="translate(48.13369962564025 118.67197761092962) rotate(0 5.849998474121094 12.5)"><text x="5.849998474121094" y="17.619999999999997" font-family="Virgil, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round"><g transform="translate(206.40545773506165 248.82421875) rotate(0 -37.22460565284405 -1.2806890825683013)"><path d="M0 0 C-12.41 -0.43, -62.04 -2.13, -74.45 -2.56 M0 0 C-12.41 -0.43, -62.04 -2.13, -74.45 -2.56" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(206.40545773506165 248.82421875) rotate(0 -37.22460565284405 -1.2806890825683013)"><path d="M-50.68 -10.3 C-56.05 -8.55, -61.42 -6.8, -74.45 -2.56 M-50.68 -10.3 C-55.65 -8.68, -60.61 -7.06, -74.45 -2.56" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(206.40545773506165 248.82421875) rotate(0 -37.22460565284405 -1.2806890825683013)"><path d="M-51.26 6.79 C-56.5 4.68, -61.74 2.56, -74.45 -2.56 M-51.26 6.79 C-56.11 4.84, -60.96 2.88, -74.45 -2.56" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(102.76777850765018 229.3618098407823) rotate(0 -12.552254136294266 -37.61645179539116)"><path d="M0 0 C-4.18 -12.54, -20.92 -62.69, -25.1 -75.23 M0 0 C-4.18 -12.54, -20.92 -62.69, -25.1 -75.23" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(102.76777850765018 229.3618098407823) rotate(0 -12.552254136294266 -37.61645179539116)"><path d="M-9.56 -55.66 C-15.76 -63.47, -21.97 -71.29, -25.1 -75.23 M-9.56 -55.66 C-14.96 -62.45, -20.36 -69.25, -25.1 -75.23" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(102.76777850765018 229.3618098407823) rotate(0 -12.552254136294266 -37.61645179539116)"><path d="M-25.78 -50.24 C-25.51 -60.22, -25.24 -70.2, -25.1 -75.23 M-25.78 -50.24 C-25.54 -58.92, -25.31 -67.6, -25.1 -75.23" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(86.56561398506165 118.296875) rotate(0 32.525390625 -25.94140625)"><path d="M0 0 C10.84 -8.65, 54.21 -43.24, 65.05 -51.88 M0 0 C10.84 -8.65, 54.21 -43.24, 65.05 -51.88" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(86.56561398506165 118.296875) rotate(0 32.525390625 -25.94140625)"><path d="M52.02 -30.55 C56.4 -37.72, 60.78 -44.9, 65.05 -51.88 M52.02 -30.55 C55.06 -35.54, 58.11 -40.53, 65.05 -51.88" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(86.56561398506165 118.296875) rotate(0 32.525390625 -25.94140625)"><path d="M41.35 -43.92 C49.32 -46.6, 57.29 -49.28, 65.05 -51.88 M41.35 -43.92 C46.9 -45.78, 52.44 -47.64, 65.05 -51.88" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(179.04998898506165 66.18359375) rotate(0 36.40420863551384 30.305309173687505)"><path d="M0 0 C12.13 10.1, 60.67 50.51, 72.81 60.61 M0 0 C12.13 10.1, 60.67 50.51, 72.81 60.61" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(179.04998898506165 66.18359375) rotate(0 36.40420863551384 30.305309173687505)"><path d="M49.28 52.15 C58.22 55.37, 67.17 58.58, 72.81 60.61 M49.28 52.15 C58.25 55.37, 67.21 58.6, 72.81 60.61" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(179.04998898506165 66.18359375) rotate(0 36.40420863551384 30.305309173687505)"><path d="M60.22 39.01 C65.01 47.22, 69.79 55.43, 72.81 60.61 M60.22 39.01 C65.02 47.24, 69.81 55.47, 72.81 60.61" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(261.47121447825396 151.94724790446048) rotate(0 -15.589518996596155 37.47950104776976)"><path d="M0 0 C-5.2 12.49, -25.98 62.47, -31.18 74.96 M0 0 C-5.2 12.49, -25.98 62.47, -31.18 74.96" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(261.47121447825396 151.94724790446048) rotate(0 -15.589518996596155 37.47950104776976)"><path d="M-30.05 49.98 C-30.5 59.94, -30.95 69.91, -31.18 74.96 M-30.05 49.98 C-30.41 57.84, -30.76 65.7, -31.18 74.96" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(261.47121447825396 151.94724790446048) rotate(0 -15.589518996596155 37.47950104776976)"><path d="M-14.26 56.55 C-21.01 63.89, -27.76 71.23, -31.18 74.96 M-14.26 56.55 C-19.59 62.35, -24.91 68.14, -31.18 74.96" stroke="#2f9e44" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(129.23358273506165 39.4921875) rotate(0 -35.525390625 29.255859375)"><path d="M0 0 C-14.72 12.12, -29.44 24.24, -71.05 58.51 M0 0 C-23.51 19.36, -47.01 38.71, -71.05 58.51" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(129.23358273506165 39.4921875) rotate(0 -35.525390625 29.255859375)"><path d="M-58.35 36.98 C-60.98 41.44, -63.61 45.9, -71.05 58.51 M-58.35 36.98 C-62.55 44.1, -66.75 51.23, -71.05 58.51" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(129.23358273506165 39.4921875) rotate(0 -35.525390625 29.255859375)"><path d="M-47.48 50.18 C-52.36 51.9, -57.25 53.63, -71.05 58.51 M-47.48 50.18 C-55.28 52.94, -63.08 55.69, -71.05 58.51" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(269.0826056468384 98.13486532417619) rotate(0 -35.305370830888364 -31.563526412088095)"><path d="M0 0 C-22.74 -20.33, -45.47 -40.65, -70.61 -63.13 M0 0 C-23.82 -21.29, -47.64 -42.59, -70.61 -63.13" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(269.0826056468384 98.13486532417619) rotate(0 -35.305370830888364 -31.563526412088095)"><path d="M-47.4 -53.84 C-54.87 -56.83, -62.35 -59.82, -70.61 -63.13 M-47.4 -53.84 C-55.23 -56.98, -63.06 -60.11, -70.61 -63.13" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(269.0826056468384 98.13486532417619) rotate(0 -35.305370830888364 -31.563526412088095)"><path d="M-58.8 -41.1 C-62.6 -48.19, -66.4 -55.28, -70.61 -63.13 M-58.8 -41.1 C-62.78 -48.53, -66.77 -55.96, -70.61 -63.13" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(268.19061398506165 239.8046875) rotate(0 16.675656079043847 -40.08520159908403)"><path d="M0 0 C11.75 -28.24, 23.49 -56.47, 33.35 -80.17 M0 0 C8.53 -20.5, 17.05 -41, 33.35 -80.17" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(268.19061398506165 239.8046875) rotate(0 16.675656079043847 -40.08520159908403)"><path d="M32.22 -55.2 C32.62 -63.99, 33.02 -72.79, 33.35 -80.17 M32.22 -55.2 C32.51 -61.58, 32.8 -67.97, 33.35 -80.17" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(268.19061398506165 239.8046875) rotate(0 16.675656079043847 -40.08520159908403)"><path d="M16.43 -61.76 C22.39 -68.25, 28.35 -74.73, 33.35 -80.17 M16.43 -61.76 C20.76 -66.47, 25.08 -71.18, 33.35 -80.17" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(131.04863482871986 281.00474222490243) rotate(0 40.752630203170895 1.1597382625487853)"><path d="M0 0 C32.16 0.92, 64.33 1.83, 81.51 2.32 M0 0 C17.11 0.49, 34.21 0.97, 81.51 2.32" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(131.04863482871986 281.00474222490243) rotate(0 40.752630203170895 1.1597382625487853)"><path d="M57.78 10.2 C67.14 7.09, 76.51 3.98, 81.51 2.32 M57.78 10.2 C62.76 8.54, 67.74 6.89, 81.51 2.32" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(131.04863482871986 281.00474222490243) rotate(0 40.752630203170895 1.1597382625487853)"><path d="M58.27 -6.9 C67.44 -3.26, 76.61 0.38, 81.51 2.32 M58.27 -6.9 C63.14 -4.96, 68.02 -3.03, 81.51 2.32" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(51.612488985061646 162.42578125) rotate(0 13.388304966365581 37.268758849010055)"><path d="M0 0 C5.7 15.86, 11.39 31.71, 26.78 74.54 M0 0 C7.18 20, 14.37 40, 26.78 74.54" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(51.612488985061646 162.42578125) rotate(0 13.388304966365581 37.268758849010055)"><path d="M10.79 55.32 C14.19 59.41, 17.59 63.5, 26.78 74.54 M10.79 55.32 C15.08 60.48, 19.37 65.63, 26.78 74.54" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(51.612488985061646 162.42578125) rotate(0 13.388304966365581 37.268758849010055)"><path d="M26.88 49.54 C26.86 54.86, 26.84 60.17, 26.78 74.54 M26.88 49.54 C26.85 56.25, 26.83 62.95, 26.78 74.54" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(282.84295773506165 71.171875) rotate(0 23.049988985061646 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">head</text></g><g transform="translate(10 68.6953125) rotate(0 15.979988098144531 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">tail</text></g><g stroke-linecap="round" transform="translate(130.79998898506165 137.92578125) rotate(0 5.8125 5.853515625)"><path d="M2.91 0 C4.5 0, 6.1 0, 8.72 0 C10.66 0, 11.63 0.97, 11.63 2.91 C11.63 5.05, 11.63 7.19, 11.63 8.8 C11.63 10.74, 10.66 11.71, 8.72 11.71 C7.2 11.71, 5.69 11.71, 2.91 11.71 C0.97 11.71, 0 10.74, 0 8.8 C0 6.68, 0 4.55, 0 2.91 C0 0.97, 0.97 0, 2.91 0" stroke="none" stroke-width="0" fill="#ffec99"></path><path d="M2.91 0 C4.74 0, 6.57 0, 8.72 0 M2.91 0 C4.91 0, 6.9 0, 8.72 0 M8.72 0 C10.66 0, 11.63 0.97, 11.63 2.91 M8.72 0 C10.66 0, 11.63 0.97, 11.63 2.91 M11.63 2.91 C11.63 4.21, 11.63 5.51, 11.63 8.8 M11.63 2.91 C11.63 5.15, 11.63 7.39, 11.63 8.8 M11.63 8.8 C11.63 10.74, 10.66 11.71, 8.72 11.71 M11.63 8.8 C11.63 10.74, 10.66 11.71, 8.72 11.71 M8.72 11.71 C6.75 11.71, 4.78 11.71, 2.91 11.71 M8.72 11.71 C7.06 11.71, 5.39 11.71, 2.91 11.71 M2.91 11.71 C0.97 11.71, 0 10.74, 0 8.8 M2.91 11.71 C0.97 11.71, 0 10.74, 0 8.8 M0 8.8 C0 7.44, 0 6.07, 0 2.91 M0 8.8 C0 7.61, 0 6.43, 0 2.91 M0 2.91 C0 0.97, 0.97 0, 2.91 0 M0 2.91 C0 0.97, 0.97 0, 2.91 0" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(155.15155148506165 129.1015625) rotate(0 20.43998795747757 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">prev</text></g><g stroke-linecap="round" transform="translate(130.63343852758408 173.203125) rotate(0 5.8125 5.853515625)"><path d="M2.91 0 C4.5 0, 6.1 0, 8.72 0 C10.66 0, 11.63 0.97, 11.63 2.91 C11.63 4.54, 11.63 6.18, 11.63 8.8 C11.63 10.74, 10.66 11.71, 8.72 11.71 C7.33 11.71, 5.93 11.71, 2.91 11.71 C0.97 11.71, 0 10.74, 0 8.8 C0 7.26, 0 5.72, 0 2.91 C0 0.97, 0.97 0, 2.91 0" stroke="none" stroke-width="0" fill="#b2f2bb"></path><path d="M2.91 0 C4.34 0, 5.78 0, 8.72 0 M2.91 0 C4.64 0, 6.37 0, 8.72 0 M8.72 0 C10.66 0, 11.63 0.97, 11.63 2.91 M8.72 0 C10.66 0, 11.63 0.97, 11.63 2.91 M11.63 2.91 C11.63 4.47, 11.63 6.03, 11.63 8.8 M11.63 2.91 C11.63 4.75, 11.63 6.59, 11.63 8.8 M11.63 8.8 C11.63 10.74, 10.66 11.71, 8.72 11.71 M11.63 8.8 C11.63 10.74, 10.66 11.71, 8.72 11.71 M8.72 11.71 C7.31 11.71, 5.9 11.71, 2.91 11.71 M8.72 11.71 C7.25 11.71, 5.77 11.71, 2.91 11.71 M2.91 11.71 C0.97 11.71, 0 10.74, 0 8.8 M2.91 11.71 C0.97 11.71, 0 10.74, 0 8.8 M0 8.8 C0 7.52, 0 6.24, 0 2.91 M0 8.8 C0 7.07, 0 5.33, 0 2.91 M0 2.91 C0 0.97, 0.97 0, 2.91 0 M0 2.91 C0 0.97, 0.97 0, 2.91 0" stroke="#2f9e44" stroke-width="2" fill="none"></path></g><g transform="translate(154.98500102758408 164.37890625) rotate(0 22.129986107349396 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">next</text></g></svg>
</div>

## Node

We started with this implementation of the linked list `Node`:

```kotlin linenums="1"
class Node(var value: Int, var next: Node? = null) {
  override fun toString(): String = "$value"
}
```

and make the following adjustments:

- we move both \\(prev\\) and \\(next\\) to backing fields `_prev` and `_next`.
- both `prev` and `next` are now synthetic properties which simplify the bookkeeping of references.
- we provide a new secondary constructor to trigger our synthetic field setters.
- \\(next\\) and \\(prev\\) can now be non-nulls, since our list now is circular.

```diff linenums="1"
private class Node(var value: Int) {

+ private lateinit var _prev: Node
  private lateinit var _next: Node

+ constructor(value: Int, prev: Node, next: Node) : this(value) {
+   this.prev = prev // triggers the custom setter
+   this.next = next // triggers the custom setter
+ }

+ var prev: Node
+   get() = _prev
+   set(value) {
+     _prev = value
+     value._next = this // .next will cause an ∞-loop
+   }

+ var next: Node
+   get() = _next
+   set(value) {
+     _next = value
+     value._prev = this // .prev will cause an ∞-loop
+   }

  override fun toString(): String = "$value"
}
```

## Linked List

We maintain references to the head and the tail of the list, allowing \\(O(1)\\) insertion on both ends.

<div markdown class="grid">

```diff linenums="1"
class LinkedList {

  private var _size = 0
- private var _head: Node? = null
- private var _tail: Node? = null
+ private var sentinel: Node = Node(0)

  val size: Int
    get() = _size

  fun isEmpty() = size == 0

- val head: Int?
-   get() = _head?.value

+ val head: Int?
+   get() = if (isEmpty()) null else sentinel.next.value

- val tail: Int?
-   get() = _tail?.value

+ val tail: Int?
+   get() = if (isEmpty()) null else sentinel.prev.value

  // Rest of the implementation goes here. //
}
```

<div markdown>
Drop separate references to \\(head\\) and \\(tail\\) for a single reference \\(sentinel\\).

the \\(next\\) of \\(sentinel\\) is our \\(head\\) and \\(prev\\) is \\(tail\\).

</div>

</div>

## Traversal

<div markdown class="grid">

all the `null` checks are replaced with comparison against `sentinel`. Notice the comparison by reference as opposed to comparison by value. Our \\(sentinel\\) is like any other node in the list, and its special status is its identity, not its value.

```diff linenums="1"
override fun toString(): String {
  val sb = StringBuilder().append('[')
  var cursor = sentinel.next
- while (cursor != null) {
+ while (cursor !== sentinel) {
    sb.append(cursor.value)
    cursor = cursor.next
-   if (cursor != null) sb.append(", ")
+   if (cursor !== sentinel) sb.append(", ")
  }
  return sb.append(']').toString()
}
```

</div>

## Getter

<div markdown class="grid">

```diff linenums="1"
operator fun get(index: Int): Int? {
  // saves time
  if (index < 0 || index >= size) return null
  if (index == size - 1) return tail

- var cursor = _head
- for (i in 0..<index) cursor = cursor.next
+ var cursor = sentinel
+ for (i in 0..index) cursor = cursor.next
  return cursor.value
}
```

<div markdown>
Previously we had to start traversal at \\(head\\) and that made our loop bounds a confusing \\([0, index)\\).

Now we can start at \\(sentinel\\) (effectively \\(null\\) in singly-linked list terms).

</div>

</div>

## Setter

<div markdown class="grid">

```diff linenums="1"
operator fun set(index: Int, value: Int) {
  if (index < 0 || index >= size)
    throw IndexOutOfBoundsException("Index $index out of bounds for length $size")

  if (index == size - 1) {
-   _tail!!.value = value
+   sentinel.prev.value = value
    return
  }

- var cursor = _head
- for (i in 0..<index) cursor = cursor.next
+ var cursor = sentinel
+ for (i in 0..index) cursor = cursor.next
  cursor.value = value
}
```

<div></div>

</div>

## Insertion

<div markdown class="grid">

<div markdown>

As promised, insertions with sentinels are a lot more straighforward.

<br>

\\[
node .next .next .next ... .next
\\]

that's because the circular list ensures that no matter how many \\(next\\) or \\(prev\\) we chain, we can't ever hit a dead end.

<br>

\\[
\bcancel{null.prev} \implies sentinel.prev
\\]

and we've substituted checks against \\(sentinel\\) for \\(null\\) checks, which will never throw NPE.

</div>

<div markdown>

```diff linenums="1"
fun addFirst(value: Int) {
    _size++
-   _head = Node(value, _head)
-   _tail = _tail ?: _head
+   sentinel.next = Node(value, sentinel, sentinel.next)
}
```

```diff linenums="1"
fun addLast(value: Int) {
  _size++

- val node = Node(value)
- if (_head == null) _head = node
- else _tail!!.next = node
- _tail = node

+   sentinel.prev = Node(value, sentinel.prev, sentinel)
}
```

```diff linenums="1"
fun add(index: Int, value: Int) {
  if (index < 0 || index > size) throw IndexOutOfBoundsException("Index $index out of bounds for length $size")
  when(index) {
    0 -> addFirst(value)
    size -> addLast(value)
    else -> {
      _size++
-     var pred = _head
+     var pred = sentinel
-     for (i in 0..<(index-1))
+     for (i in 0..<index)
        pred = pred.next
-     pred!!.next = Node(value, pred.next)
+     pred.next = Node(value, pred, pred.next)
    }
  }
}
```

</div>

</div>

## Deletion

<div markdown class="grid">

There is no longer need for a special case of size one list. The rest of the method is exactly as before, which just few renames.

```diff linenums="1"
fun removeFirst(): Int? {
- if (head == null) return null
+ if (isEmpty()) return null

  _size--
- if (head == tail) {
-   val value = head!!.value
-   head = null
-   tail = null
-   return value
- }
+ val head = sentinel.next
  val value = head.value
- head = head!!.next
+ sentinel.next = head.next // basically same as deleted line above
  return value
}
```

```diff linenums="1"
fun removeLast(): Int? {
- if (head == null) return null
+ if (isEmpty()) return null

  _size--
- if (head == tail) {
-   val value = head!!.value
-   head = null
-   tail = null
-   return value
- }

- var pred = head
- while (pred!!.next != tail) pred = cursor.next

+ val tail = sentinel.prev
  val value = tail.value
- pred.next = null
- tail = pred
+ sentinel.prev = tail.prev
  return value
}
```

Since we are using a doubly-linked list, it's possible to find the predecessor of \\(tail\\) in \\(O(1)\\) without requiring a full traversal. <br> <br> The rest of the deletion is same as before.

```diff linenums="1"
fun remove(index: Int): Int? {
  if (index < 0 || index >= size)
    throw IndexOutOfBoundsException("Index $index out of bounds for length $size")

  return when(index) {
    0 -> removeFirst()
    size - 1 -> removeLast()
    else -> {
      _size--
-     var pred = _head
+     var pred = sentinel
-     for (i in 0..<(index-1))
+     for (i in 0..<index)
        pred = pred.next

      val value = pred.next.value
      pred.next = pred.next.next
      return value
    }
  }
}
```

</div>

## Full Implementation

=== "Kotlin"

    ```kotlin linenums="1" title="LinkedList.kt"
    package com.example.linkedlist

    private class Node(var value: Int) {

      private lateinit var _prev: Node
      private lateinit var _next: Node

      constructor(value: Int, prev: Node, next: Node) : this(value) {
        this.prev = prev // triggers the custom setter
        this.next = next // triggers the custom setter
      }

      var prev: Node
        get() = _prev
        set(value) {
          _prev = value
          value._next = this // .next will cause infinite-loop
        }

      var next: Node
        get() = _next
        set(value) {
          _next = value
          value._prev = this // .prev will cause infinite-loop
        }

      override fun toString(): String = "$value"
    }

    class LinkedList {

      private var sentinel: Node = Node(0) // value doesn't matter
      private var _size = 0

      init {
        sentinel.next = sentinel
      }

      val size: Int
        get() = _size

      fun isEmpty() = size == 0

      val head: Int?
        get() = if (isEmpty()) null else sentinel.next.value

      val tail: Int?
        get() = if (isEmpty()) null else sentinel.prev.value

      fun addFirst(vararg values: Int) {
        values.forEach {
          _size++
          sentinel.next = Node(it, sentinel, sentinel.next)
        }
      }

      fun addLast(vararg values: Int) {
        values.forEach {
          _size++
          sentinel.prev = Node(it, sentinel.prev, sentinel)
        }
      }

      fun add(index: Int, value: Int) {
        if (index < 0 || index > size) throw IndexOutOfBoundsException("Index $index out of bounds for length $size")
        when (index) {
          0 -> addFirst(value)
          size -> addLast(value)
          else -> {
            _size++
            var pred = sentinel
            for (i in 0..<index) pred = pred.next
            pred.next = Node(value, pred, pred.next)
          }
        }
      }

      fun removeFirst(): Int? {
        if (isEmpty()) return null

        _size--
        val head = sentinel.next
        sentinel.next = head.next
        return head.value
      }

      fun removeLast(): Int? {
        if (isEmpty()) return null

        _size--
        val tail = sentinel.prev
        sentinel.prev = tail.prev
        return tail.value
      }

      fun remove(index: Int): Int? {
        if (index < 0 || index >= size)
          throw IndexOutOfBoundsException("Index $index out of bounds for length $size")

        return when (index) {
          0 -> removeFirst()
          size - 1 -> removeLast()
          else -> {
            _size--
            var pred = sentinel
            for (i in 0..<index) pred = pred.next

            val target = pred.next
            pred.next = target.next
            return target.value
          }
        }
      }

      operator fun get(index: Int): Int? {
        if (index >= size) return null // saves time
        if (index == size - 1) return tail

        var cursor = sentinel
        for (i in 0..index) cursor = cursor.next
        return cursor.value
      }

      operator fun set(index: Int, value: Int) {
        if (index >= size) throw IndexOutOfBoundsException("Index $index out of bounds for length $size")
        if (index == size - 1) {
          sentinel.prev.value = value
          return
        }

        var cursor = sentinel
        for (i in 0..index) cursor = cursor.next
        cursor.value = value
      }

      override fun toString(): String {
        val sb = StringBuilder().append('[')
        var cursor = sentinel.next
        while (cursor !== sentinel) {
          sb.append(cursor.value)
          cursor = cursor.next
          if (cursor !== sentinel) sb.append(", ")
        }
        return sb.append(']').toString()
      }
    }
    ```

=== "Unit Tests"

    ```kotlin linenums="1" title="LinkedListTest.kt"
    package com.example.linkedlist

    import org.assertj.core.api.Assertions.assertThat
    import org.junit.jupiter.api.BeforeEach
    import org.junit.jupiter.api.Test
    import org.junit.jupiter.api.assertThrows
    import java.util.concurrent.ThreadLocalRandom

    class LinkedListTest {

      private lateinit var list: LinkedList

      @BeforeEach
      fun setup() {
        list = LinkedList()
      }

      @Test
      fun empty() {
        assertThat(list.size).isEqualTo(0)
        assertThat(list.toString()).isEqualTo("[]")
        assertThat(list[0]).isNull()
        assertThrows<IndexOutOfBoundsException> { list[0] = 0 }
        assertThat(list.head).isNull()
        assertThat(list.tail).isNull()
      }

      @Test
      fun addFirst_simple() {
        list.addFirst(1, 2, 3)

        assertThat(list.size).isEqualTo(3)
        assertThat(list.toString()).isEqualTo("[3, 2, 1]")
        assertThat(list[0]).isEqualTo(3)
        assertThat(list[1]).isEqualTo(2)
        assertThat(list[2]).isEqualTo(1)
        assertThat(list.head).isEqualTo(3)
        assertThat(list.tail).isEqualTo(1)
      }

      @Test
      fun addLast_simple() {
        list.addLast(1, 2, 3)

        assertThat(list.size).isEqualTo(3)
        assertThat(list.toString()).isEqualTo("[1, 2, 3]")
        assertThat(list[0]).isEqualTo(1)
        assertThat(list[1]).isEqualTo(2)
        assertThat(list[2]).isEqualTo(3)
        assertThat(list.head).isEqualTo(1)
        assertThat(list.tail).isEqualTo(3)
      }

      @Test
      fun add_mixed() {
        list.addFirst(2)
        list.addLast(3)
        list.addFirst(1)
        list.addLast(4)

        assertThat(list.size).isEqualTo(4)
        assertThat(list.toString()).isEqualTo("[1, 2, 3, 4]")
        assertThat(list[0]).isEqualTo(1)
        assertThat(list[1]).isEqualTo(2)
        assertThat(list[2]).isEqualTo(3)
        assertThat(list[3]).isEqualTo(4)
        assertThat(list.head).isEqualTo(1)
        assertThat(list.tail).isEqualTo(4)
      }

      @Test
      fun add_at() {
        list.add(0, 1)
        assertThat(list.toString()).isEqualTo("[1]")
        assertThat(list.head).isEqualTo(1)
        assertThat(list.tail).isEqualTo(1)

        assertThrows<IndexOutOfBoundsException> { list.add(-1, 2) }
        assertThrows<IndexOutOfBoundsException> { list.add(2, 2) }

        list.add(1, 3)
        assertThat(list.toString()).isEqualTo("[1, 3]")
        assertThat(list.head).isEqualTo(1)
        assertThat(list.tail).isEqualTo(3)

        list.add(1, 2)
        assertThat(list.toString()).isEqualTo("[1, 2, 3]")
        assertThat(list.head).isEqualTo(1)
        assertThat(list.tail).isEqualTo(3)
      }

      @Test
      fun add_at_fuzzy() {
        val ctrl = ArrayList<Int>()
        val rand = ThreadLocalRandom.current()

        for (i in 0..100) {
          val value = rand.nextInt()
          val index = rand.nextInt(ctrl.size + 1)

          ctrl.add(index, value)
          list.add(index, value)
          assertThat(list.toString()).isEqualTo(ctrl.toString())
        }
      }

      @Test
      fun removeFirst_simple() {
        list.addFirst(2)
        list.addLast(3)
        list.addFirst(1)
        list.addLast(4)

        assertThat(list[0]).isEqualTo(1)
        assertThat(list.removeFirst()).isEqualTo(1)
        assertThat(list.size).isEqualTo(3)

        assertThat(list[0]).isEqualTo(2)
        assertThat(list.removeFirst()).isEqualTo(2)
        assertThat(list.size).isEqualTo(2)

        assertThat(list[0]).isEqualTo(3)
        assertThat(list.removeFirst()).isEqualTo(3)
        assertThat(list.size).isEqualTo(1)

        assertThat(list[0]).isEqualTo(4)
        assertThat(list.removeFirst()).isEqualTo(4)
        assertThat(list.size).isEqualTo(0)

        assertThat(list.removeFirst()).isNull()
        assertThat(list.size).isEqualTo(0)
      }

      @Test
      fun removeLast_simple() {
        list.addFirst(2)
        list.addLast(3)
        list.addFirst(1)
        list.addLast(4)

        assertThat(list[3]).isEqualTo(4)
        assertThat(list.removeLast()).isEqualTo(4)
        assertThat(list.size).isEqualTo(3)

        assertThat(list[2]).isEqualTo(3)
        assertThat(list.removeLast()).isEqualTo(3)
        assertThat(list.size).isEqualTo(2)

        assertThat(list[1]).isEqualTo(2)
        assertThat(list.removeLast()).isEqualTo(2)
        assertThat(list.size).isEqualTo(1)

        assertThat(list[0]).isEqualTo(1)
        assertThat(list.removeLast()).isEqualTo(1)
        assertThat(list.size).isEqualTo(0)

        assertThat(list.removeLast()).isNull()
        assertThat(list.size).isEqualTo(0)
      }

      @Test
      fun remove_at_ends() {
        list.addLast(1, 2, 3, 4)

        assertThat(list.remove(0)).isEqualTo(1)
        assertThat(list.head).isEqualTo(2)
        assertThat(list.tail).isEqualTo(4)

        assertThat(list.remove(2)).isEqualTo(4)
        assertThat(list.head).isEqualTo(2)
        assertThat(list.tail).isEqualTo(3)
      }

      @Test
      fun remove_at_middle() {
        list.addLast(1, 2, 3, 4, 5)

        assertThat(list.remove(2)).isEqualTo(3)
        assertThat(list.toString()).isEqualTo("[1, 2, 4, 5]")
        assertThat(list.head).isEqualTo(1)
        assertThat(list.tail).isEqualTo(5)

        assertThat(list.remove(2)).isEqualTo(4)
        assertThat(list.toString()).isEqualTo("[1, 2, 5]")
        assertThat(list.head).isEqualTo(1)
        assertThat(list.tail).isEqualTo(5)
      }

      @Test
      fun remove_at_fuzzy() {
        val ctrl = ArrayList<Int>()
        val rand = ThreadLocalRandom.current()

        rand.ints(100, 0, 1000).forEach {
          list.addLast(it)
          ctrl.addLast(it)
        }

        while (ctrl.isNotEmpty()) {
          val index = rand.nextInt(ctrl.size)

          val removed = ctrl[index]
          ctrl.removeAt(index)
          assertThat(list.remove(index)).isEqualTo(removed)
          assertThat(list.toString()).isEqualTo(ctrl.toString())
        }
        assertThat(list.size).isEqualTo(0)
      }

      @Test
      fun get_simple() {
        assertThat(list[0]).isNull()
        assertThat(list[1]).isNull()
        assertThat(list[2]).isNull()
        assertThat(list[3]).isNull()

        list.addLast(3)
        list.addFirst(2)
        list.addLast(4)
        list.addFirst(1)

        assertThat(list[0]).isEqualTo(1)
        assertThat(list[1]).isEqualTo(2)
        assertThat(list[2]).isEqualTo(3)
        assertThat(list[3]).isEqualTo(4)
      }

      @Test
      fun set_simple() {
        list.addLast(3)
        list.addFirst(2)
        list.addLast(4)
        list.addFirst(1)

        list[0] = 9
        list[1] = 8
        list[2] = 7
        list[3] = 6

        assertThat(list[0]).isEqualTo(9)
        assertThat(list[1]).isEqualTo(8)
        assertThat(list[2]).isEqualTo(7)
        assertThat(list[3]).isEqualTo(6)

        assertThrows<IndexOutOfBoundsException> { list[4] = 0 }
        assertThrows<IndexOutOfBoundsException> { list[5] = 1 }
        assertThrows<IndexOutOfBoundsException> { list[6] = 2 }
      }

      @Test
      fun fuzzy() {
        val ctrl = ArrayList<Int>()
        val rand = ThreadLocalRandom.current()
        // Test add
        for (i in 0..100) {
          val addLast = rand.nextBoolean()
          val toBeAdded = rand.nextInt()

          if (addLast) {
            list.addLast(toBeAdded)
            ctrl.addLast(toBeAdded)
          }
          else {
            list.addFirst(toBeAdded)
            ctrl.addFirst(toBeAdded)
          }
        }
        // Test get
        for (i in 0..100) {
          assertThat(list[i]).isEqualTo(ctrl[i])
        }
        // Test toString
        assertThat(list.toString()).isEqualTo(ctrl.toString())
        // Test remove
        while (ctrl.isNotEmpty()) {
          val removeLast = rand.nextBoolean()

          if (removeLast) {
            assertThat(list.removeLast()).isEqualTo(ctrl.removeLast())
          } else {
            assertThat(list.removeFirst()).isEqualTo(ctrl.removeFirst())
          }
        }
        // Test size
        assertThat(list.size).isEqualTo(0)
      }
    }
    ```

=== "Python"

    ```python linenums="1" title="list.py"
    from typing import Optional

    class LinkedList:
        class Node:
            _prev: 'LinkedList.Node'
            _next: 'LinkedList.Node'

            def __init__(self, value: int):
                self.value = value

            @staticmethod
            def create(value: int, prev: 'LinkedList.Node', next: 'LinkedList.Node') -> 'LinkedList.Node':
                node = LinkedList.Node(value)
                node.next = next
                node.prev = prev
                return node

            @property
            def prev(self):
                return self._prev

            @property
            def next(self):
                return self._next

            @prev.setter
            def prev(self, value: 'LinkedList.Node'):
                self._prev = value
                value._next = self

            @next.setter
            def next(self, value: 'LinkedList.Node'):
                self._next = value
                value._prev = self

            def __str__(self):
                return f"{self.value}"

        def __init__(self):
            self.sentinel = LinkedList.Node(0)
            self.sentinel.next = self.sentinel
            self._size = 0

        @property
        def size(self) -> int:
            return self._size

        @property
        def empty(self):
            return self._size == 0

        @property
        def head(self) -> Optional[int]:
            if self.empty:
                return None
            return self.sentinel.next.value

        @property
        def tail(self) -> Optional[int]:
            if self.empty:
                return None
            return self.sentinel.prev.value

        def add_front(self, *values: int):
            for v in values:
                self._size += 1
                self.sentinel.next = LinkedList.Node.create(v, self.sentinel, self.sentinel.next)

        def add_last(self, *values: int):
            for v in values:
                self._size += 1
                self.sentinel.prev = LinkedList.Node.create(v, self.sentinel.prev, self.sentinel)

        def add(self, index: int, value: int):
            if index < 0 or index > self.size:
                raise IndexError("Index out of range")
            match index:
                case 0:
                    self.add_front(value)
                case self.size:
                    self.add_last(value)
                case _:
                    self._size += 1
                    pred = self.sentinel
                    for _ in range(index):
                        pred = pred.next
                    pred.next = LinkedList.Node.create(value, pred, pred.next)

        def remove_front(self) -> Optional[int]:
            if self.empty:
                return None
            self._size -= 1
            out, self.sentinel.next = self.sentinel.next.value, self.sentinel.next.next
            return out

        def remove_last(self) -> Optional[int]:
            if self.empty:
                return None
            self._size -= 1
            out, self.sentinel.prev = self.sentinel.prev.value, self.sentinel.prev.prev
            return out

        def remove(self, index: int) -> Optional[int]:
            if index < 0 or index >= self.size:
                raise IndexError("Index out of range")
            if self.empty:
                return None
            if index == 0:
                return self.remove_front()
            if index == self.size - 1:
                return self.remove_last()
            self._size -= 1
            pred = self.sentinel
            for _ in range(index):
                pred = pred.next
            out, pred.next = pred.next.value, pred.next.next
            return out

        def __getitem__(self, index: int) -> Optional[int]:
            if index < 0 or index >= self.size:
                return None
            cursor = self.sentinel
            for _ in range(index + 1):
                cursor = cursor.next
            return cursor.value

        def __setitem__(self, index: int, value: int):
            if index < 0 or index >= self.size:
                raise IndexError("Index out of range")
            cursor = self.sentinel
            for _ in range(index + 1):
                cursor = cursor.next
            cursor.value = value

        def __delitem__(self, index: int):
            return self.remove(index)

        def __str__(self):
            tokens = []
            cursor = self.sentinel.next
            while cursor != self.sentinel:
                tokens.append(f'{cursor.value}')
                cursor = cursor.next
            return '[' + ', '.join(tokens) + ']'
    ```

=== "Unit Tests"

    ```python linenums="1" title="test_list.py"
    import random

    from _pytest.python_api import raises
    from distributed.utils_test import throws
    from numpy.matlib import empty

    from linkedlist.list import LinkedList


    def test_empty():
        list = LinkedList()

        assert list.size is 0
        assert list.empty is True
        assert list.head is None
        assert list.tail is None
        assert list[0] is None
        assert str(list) == "[]"

    def test_add_first_simple():
        list = LinkedList()

        list.add_front(1, 2, 3)

        assert list.size is 3
        assert list.empty is False
        assert list.head is 3
        assert list.tail is 1
        assert list[0] is 3
        assert list[1] is 2
        assert list[2] is 1
        assert str(list) == "[3, 2, 1]"

    def test_add_last_simple():
        list = LinkedList()

        list.add_last(1, 2, 3)

        assert list.size is 3
        assert list.empty is False
        assert list.head is 1
        assert list.tail is 3
        assert list[0] is 1
        assert list[1] is 2
        assert list[2] is 3
        assert str(list) == "[1, 2, 3]"

    def test_add_mixed():
        list = LinkedList()

        list.add_front(2)
        list.add_last(3)
        list.add_front(1)
        list.add_last(4)

        assert list.size is 4
        assert list.empty is False
        assert list.head is 1
        assert list.tail is 4
        assert list[0] is 1
        assert list[1] is 2
        assert list[2] is 3
        assert list[3] is 4
        assert str(list) == "[1, 2, 3, 4]"

    def test_add_at():
        list = LinkedList()

        list.add(0, 1)
        assert str(list) == "[1]"
        assert list.head is 1
        assert list.tail is 1

        with raises(IndexError):
            list.add(-1, 2)

        with raises(IndexError):
            list.add(2, 2)

        list.add(1, 3)
        assert str(list) == "[1, 3]"
        assert list.head is 1
        assert list.tail is 3

        list.add(1, 2)
        assert str(list) == "[1, 2, 3]"
        assert list.head is 1
        assert list.tail is 3

    def test_add_at_fuzzy():
        list = LinkedList()
        ctrl = []

        for _ in range(100):
            value = random.randint(0, 10000)
            index = random.randint(0, len(ctrl))

            ctrl.insert(index, value)
            list.add(index, value)

            assert str(list) == str(ctrl)

    def test_remove_front_simple():
        list = LinkedList()

        list.add_front(2)
        list.add_last(3)
        list.add_front(1)
        list.add_last(4)

        assert list[0] is 1
        assert list.remove_front() is 1
        assert list.size is 3

        assert list[0] is 2
        assert list.remove_front() is 2
        assert list.size is 2

        assert list[0] is 3
        assert list.remove_front() is 3
        assert list.size is 1

        assert list[0] is 4
        assert list.remove_front() is 4
        assert list.size is 0

    def test_remove_last_simple():
        list = LinkedList()

        list.add_front(2)
        list.add_last(3)
        list.add_front(1)
        list.add_last(4)

        assert list[3] is 4
        assert list.remove_last() is 4
        assert list.size is 3

        assert list[2] is 3
        assert list.remove_last() is 3
        assert list.size is 2

        assert list[1] is 2
        assert list.remove_last() is 2
        assert list.size is 1

        assert list[0] is 1
        assert list.remove_last() is 1
        assert list.size is 0

    def test_remove_at_middle():
        list = LinkedList()

        list.add_last(1, 2, 3, 4, 5)

        assert list.remove(2) is 3
        assert str(list) == "[1, 2, 4, 5]"
        assert list.head is 1
        assert list.tail is 5

        assert list.remove(2) is 4
        assert str(list) == "[1, 2, 5]"
        assert list.head is 1
        assert list.tail is 5

    def test_remove_at_fuzzy():
        list = LinkedList()
        ctrl = []

        for _ in range(100):
            value = random.randint(0, 1000)
            list.add_last(value)
            ctrl.append(value)

        while len(ctrl) > 0:
            index = random.randint(0, len(ctrl) - 1)
            value = ctrl[index]

            del ctrl[index]
            assert list.remove(index) is value
        assert list.empty is True
    ```

=== "Go"

    ```golang linenums="1"
    package libs

    import (
      "fmt"
      "strings"
    )

    type Node struct {
      value      int
      prev, next *Node
    }

    func create(value int, prev, next *Node) *Node {
      n := Node{value, nil, nil}
      n.setPrev(prev)
      n.setNext(next)
      return &n
    }

    func (n *Node) setNext(next *Node) *Node {
      n.next = next
      if next != nil {
        next.prev = n
      }
      return n
    }

    func (n *Node) setPrev(prev *Node) *Node {
      n.prev = prev
      if prev != nil {
        prev.next = n
      }
      return n
    }

    func (n *Node) String() string {
      return fmt.Sprint(n.value)
    }

    type LinkedList struct {
      sentinel *Node
      size     int
    }

    func NewLinkedList() *LinkedList {
      sentinel := create(0, nil, nil)
      sentinel.setNext(sentinel)
      return &LinkedList{sentinel, 0}
    }

    func (l *LinkedList) AddFront(values ...int) {
      for _, v := range values {
        l.size++
        l.sentinel.next = create(v, l.sentinel, l.sentinel.next)
      }
    }

    func (l *LinkedList) AddBack(values ...int) {
      for _, v := range values {
        l.size++
        l.sentinel.prev = create(v, l.sentinel.prev, l.sentinel)
      }
    }

    func (l *LinkedList) Add(index int, value int) bool {
      if index < 0 || index > l.size {
        return false
      }
      if index == 0 {
        l.AddFront(value)
        return true
      }
      if index == l.size {
        l.AddBack(value)
        return true
      }
      l.size++
      pred, i := l.sentinel, 0
      for i < index {
        pred = pred.next
        i++
      }
      pred.next = create(value, pred, pred.next)
      return true
    }

    func (l *LinkedList) RemoveFront() (int, bool) {
      if l.size == 0 {
        return 0, false
      }
      l.size--
      value := l.sentinel.next.value
      l.sentinel.setNext(l.sentinel.next.next)
      return value, true
    }

    func (l *LinkedList) RemoveBack() (int, bool) {
      if l.size == 0 {
        return 0, false
      }
      l.size--
      value := l.sentinel.prev.value
      l.sentinel.setPrev(l.sentinel.prev.prev)
      return value, true
    }

    func (l *LinkedList) Remove(index int) (int, bool) {
      if index < 0 || index >= l.size {
        return 0, false
      }
      if index == 0 {
        return l.RemoveFront()
      }
      if index == l.size-1 {
        return l.RemoveBack()
      }
      pred, i := l.sentinel.next, 0
      for i < index-1 {
        pred = pred.next
        i++
      }
      l.size--
      value := pred.next.value
      pred.setNext(pred.next.next)
      return value, true
    }

    func (l *LinkedList) Get(index int) (int, bool) {
      if index < 0 || index >= l.size {
        return 0, false
      }
      if index == l.size-1 {
        return l.sentinel.prev.value, true
      }
      cursor, i := l.sentinel, 0
      for i < index {
        cursor = cursor.next
      }
      return cursor.value, true
    }

    func (l *LinkedList) Set(index, value int) bool {
      if index < 0 || index >= l.size {
        return false
      }
      if index == l.size-1 {
        l.sentinel.prev.value = value
        return true
      }
      cursor, i := l.sentinel, 0
      for i < index {
        cursor = cursor.next
      }
      cursor.value = value
      return true
    }

    func (l *LinkedList) Size() int {
      return l.size
    }

    func (l *LinkedList) IsEmpty() bool {
      return l.size == 0
    }

    func (l *LinkedList) Head() (int, bool) {
      if l.size == 0 {
        return 0, false
      }
      return l.sentinel.next.value, true
    }

    func (l *LinkedList) Tail() (int, bool) {
      if l.size == 0 {
        return 0, false
      }
      return l.sentinel.prev.value, true
    }

    func (l *LinkedList) String() string {
      var sb strings.Builder
      sb.WriteRune('[')
      cursor := l.sentinel.next
      for cursor != l.sentinel {
        sb.WriteString(fmt.Sprintf("%d", cursor.value))
        cursor = cursor.next
        if cursor != l.sentinel {
          sb.WriteString(" ")
        }
      }
      sb.WriteRune(']')
      return sb.String()
    }
    ```

=== "Unit Tests"

    ```golang linenums="1"
    package libs

    import (
      "fmt"
      rand2 "math/rand"
      "slices"
      "testing"
    )

    func TestEmpty(t *testing.T) {
      list := NewLinkedList()
      if !list.IsEmpty() {
        t.Fatalf(`List should be empty`)
      }
      if list.Size() != 0 {
        t.Fatalf(`List size should be 0 and not %d`, list.Size())
      }
      if head, ok := list.Head(); ok {
        t.Fatalf(`head should be absent and not %d`, head)
      }
      if tail, ok := list.Tail(); ok {
        t.Fatalf(`tail should be absent and not %d`, tail)
      }
      if list.String() != "[]" {
        t.Fatalf(`String should be "[]" and not %s`, list.String())
      }
    }

    func TestAddFirst(t *testing.T) {
      list := NewLinkedList()
      list.AddFront(1, 2, 3)
      if list.IsEmpty() {
        t.Fatalf(`List should not be empty`)
      }
      if list.Size() != 3 {
        t.Fatalf(`List size should be 3 and not %d`, list.Size())
      }
      if head, ok := list.Head(); !ok || head != 3 {
        t.Fatalf(`head should be 3 and not %d`, head)
      }
      if tail, ok := list.Tail(); !ok || tail != 1 {
        t.Fatalf(`tail should be 1 and not %d`, tail)
      }
      if list.String() != "[3 2 1]" {
        t.Fatalf(`String should be "[3 2 1]" and not %s`, list.String())
      }
    }

    func TestAddBack(t *testing.T) {
      list := NewLinkedList()
      list.AddBack(1, 2, 3)
      if list.IsEmpty() {
        t.Fatalf(`List should not be empty`)
      }
      if list.Size() != 3 {
        t.Fatalf(`List size should be 3 and not %d`, list.Size())
      }
      if head, ok := list.Head(); !ok || head != 1 {
        t.Fatalf(`head should be 3 and not %d`, head)
      }
      if tail, ok := list.Tail(); !ok || tail != 3 {
        t.Fatalf(`tail should be 1 and not %d`, tail)
      }
      if list.String() != "[1 2 3]" {
        t.Fatalf(`String should be "[1 2 3]" and not %s`, list.String())
      }
    }

    func TestAddMixed(t *testing.T) {
      list := NewLinkedList()
      list.AddFront(2)
      list.AddBack(3)
      list.AddFront(1)
      list.AddBack(4)
      if list.IsEmpty() {
        t.Fatalf(`List should not be empty`)
      }
      if list.Size() != 4 {
        t.Fatalf(`List size should be 4 and not %d`, list.Size())
      }
      if head, ok := list.Head(); !ok || head != 1 {
        t.Fatalf(`head should be 1 and not %d`, head)
      }
      if tail, ok := list.Tail(); !ok || tail != 4 {
        t.Fatalf(`tail should be 4 and not %d`, tail)
      }
      if list.String() != "[1 2 3 4]" {
        t.Fatalf(`String should be "[1 2 3 4]" and not %s`, list.String())
      }
    }

    func TestAddAt(t *testing.T) {
      list := NewLinkedList()
      list.Add(0, 1)
      if list.String() != "[1]" {
        t.Fatalf(`String should be "[1]" and not %s`, list.String())
      }

      if list.Add(-1, 2) == true {
        t.Fatalf(`Add should fail for index -1`)
      }
      if list.Add(2, 2) == true {
        t.Fatalf(`Add should fail for index 2`)
      }

      list.Add(1, 3)
      if list.String() != "[1 3]" {
        t.Fatalf(`String should be "[1 3]" and not %s`, list.String())
      }

      list.Add(1, 2)
      if list.String() != "[1 2 3]" {
        t.Fatalf(`String should be "[1 2 3]" and not %s`, list.String())
      }
    }

    func TestAddFuzzy(t *testing.T) {
      var ctrl []int
      list := NewLinkedList()
      rand := rand2.New(rand2.NewSource(10))

      for i := 1; i <= 100; i++ {
        index, value := rand.Intn(i), rand.Intn(10_000)
        list.Add(index, value)
        ctrl = slices.Insert(ctrl, index, value)

        if list.String() != fmt.Sprint(ctrl) {
          t.Fatalf(`String should be "%v", and not %s`, ctrl, list.String())
        }
      }
    }

    func TestRemoveFront(t *testing.T) {
      list := NewLinkedList()
      list.AddFront(2)
      list.AddBack(3)
      list.AddFront(1)
      list.AddBack(4)

      for i := 1; i <= 4; i++ {
        if head, ok := list.RemoveFront(); !ok || head != i {
          t.Fatalf(`head should be %d`, i)
        }
      }
    }

    func TestRemoveBack(t *testing.T) {
      list := NewLinkedList()
      list.AddFront(2)
      list.AddBack(3)
      list.AddFront(1)
      list.AddBack(4)

      for i := 4; i >= 1; i-- {
        if tail, ok := list.RemoveBack(); !ok || tail != i {
          t.Fatalf(`tail should be %d`, i)
        }
      }
    }

    func TestRemoveAt(t *testing.T) {
      list := NewLinkedList()
      list.AddBack(1, 2, 3, 4, 5)

      if v, ok := list.Remove(2); !ok || v != 3 {
        t.Fatalf(`value should be 3`)
      }

      if v, ok := list.Remove(2); !ok || v != 4 {
        t.Fatalf(`value should be 4`)
      }
    }

    func TestRemoveFuzzy(t *testing.T) {
      var ctrl []int
      list := NewLinkedList()
      rand := rand2.New(rand2.NewSource(10))
      for i := 1; i <= 100; i++ {
        index, value := rand.Intn(i), rand.Intn(10_000)
        list.Add(index, value)
        ctrl = slices.Insert(ctrl, index, value)
      }

      for len(ctrl) > 0 {
        index := rand.Intn(len(ctrl))
        value := ctrl[index]
        ctrl = append(ctrl[:index], ctrl[index+1:]...)

        if v, ok := list.Remove(index); !ok || v != value {
          t.Fatalf(`value should be %d`, value)
        }
        if list.String() != fmt.Sprint(ctrl) {
          t.Fatalf(`String should be "%v", and not %s`, ctrl, list.String())
        }
      }
    }
    ```
