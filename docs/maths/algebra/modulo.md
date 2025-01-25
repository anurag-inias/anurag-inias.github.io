# Modular arithmetic

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

It is a system for dealing with restricted ranges of integers. We define $x \text{ (mod} \ N)$ to be the remainder when $x$ is divided by $N$. That is:

$$
\begin{alignat}{1}
x \ (\text{mod} \ N) & = r \\ \text{ where } x & = qN + r \text{ with } 0 \le r < N
\end{alignat}
$$

In modular arithmetic, we have a new type of equivalence between numbers $x$ and $y$ called _congruent modulo $N$_ if the numbers differ by multiples of $N$.

$$
x \equiv y \ (\text{mod} \ N) \Leftrightarrow N \text{ divides } (x - y)
$$

For example `13 % 60` and `253 % 60 = 13`, hence $253 \equiv 13 \ (\text{mod} \ 60)$.

## Addition

$$
\begin{alignat}{1}
a + b & = c\\
\Rightarrow a \text{ (mod} \ N) + b \text{ (mod} \ N) & \equiv c \text{ (mod} \ N)
\end{alignat}
$$

$$
\begin{alignat}{1}
a & \equiv b \text{ (mod} \ N) \\
\Rightarrow -a & \equiv -b \text{ (mod} \ N)
\end{alignat}
$$

$$
\begin{alignat}{1}
a & \equiv b \text{ (mod} \ N) \\
\Rightarrow a + k & \equiv b + k \text{ (mod} \ N)
\end{alignat}
$$

$$
\begin{alignat}{1}
a & \equiv b \text{ (mod} \ N) \\
c & \equiv d \text{ (mod} \ N) \\
\Rightarrow a + c & \equiv b + d \text{ (mod} \ N)
\end{alignat}
$$

## Multiplication

$$
\begin{alignat}{1}
a \cdot b & = c\\
\Rightarrow a \text{ (mod} \ N) \cdot b \text{ (mod} \ N) & \equiv c \text{ (mod} \ N)
\end{alignat}
$$

$$
\begin{alignat}{1}
a & \equiv b \text{ (mod} \ N) \\
\Rightarrow ka & \equiv kb \text{ (mod} \ N)
\end{alignat}
$$

$$
\begin{alignat}{1}
a & \equiv b \text{ (mod} \ N) \\
c & \equiv d \text{ (mod} \ N) \\
\Rightarrow ac & \equiv bd \text{ (mod} \ N)
\end{alignat}
$$

## Exponent

$$
\begin{alignat}{1}
a & \equiv b \text{ (mod} \ N) \\
\Rightarrow a^k & \equiv b^k \text{ (mod} \ N)
\end{alignat}
$$

## Division

$$
\begin{alignat}{1}
\text{gcd}(k, N) & = 1 \\
ka & \equiv kb \text{ (mod} \ N) \\
\Rightarrow a & \equiv b \text{ (mod} \ N)
\end{alignat}
$$

example

$$
\begin{alignat}{1}
\text{gcd}(4, 7) & = 1 \\
12 & \equiv 33 \text{ (mod} \ 7) \\
\Rightarrow 4 & \equiv 11 \text{ (mod} \ 7)
\end{alignat}
$$

## Handling negative numbers

In modulo set of $N$, a step back (-1) is just moving to the other end of the closed set.

<div style="text-align: center;">
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350.08276745133315 344.080683269042" width="300"><g stroke-linecap="round" transform="translate(52.26405805974622 48.99919500596218) rotate(0 126.046875 123.408203125)"><path d="M153.86 3.47 C167.84 4.4, 182.48 11.08, 194.59 18.6 C206.7 26.12, 217.87 37.14, 226.53 48.6 C235.19 60.06, 242.28 74.03, 246.56 87.36 C250.84 100.69, 253.06 114.58, 252.22 128.57 C251.39 142.56, 246.98 158.3, 241.55 171.28 C236.12 184.27, 229.22 196.25, 219.66 206.47 C210.1 216.69, 197.22 225.99, 184.17 232.6 C171.12 239.22, 155.53 244.44, 141.37 246.17 C127.22 247.9, 113.24 246.28, 99.24 242.98 C85.25 239.68, 69.61 233.85, 57.4 226.37 C45.18 218.88, 34.61 209.14, 25.97 198.09 C17.32 187.04, 9.83 173.6, 5.54 160.08 C1.25 146.57, -0.5 131.07, 0.23 116.99 C0.96 102.91, 4.35 88.57, 9.93 75.59 C15.51 62.62, 23.94 49.28, 33.72 39.14 C43.49 29, 55.99 20.96, 68.58 14.73 C81.17 8.5, 93.16 3.09, 109.26 1.74 C125.37 0.4, 154.22 4.78, 165.2 6.66 C176.18 8.53, 175.9 11.04, 175.17 13.01 M160.48 5.09 C174.41 6.93, 188.65 15.17, 200.26 23.23 C211.88 31.29, 222.17 41.78, 230.15 53.47 C238.13 65.15, 244.41 79.66, 248.15 93.33 C251.9 107, 253.81 121.35, 252.61 135.47 C251.4 149.59, 247.1 165.19, 240.93 178.03 C234.75 190.88, 225.83 203.16, 215.57 212.55 C205.31 221.94, 192.78 228.88, 179.35 234.36 C165.92 239.83, 149.54 243.9, 134.99 245.4 C120.45 246.91, 106.02 246.92, 92.09 243.38 C78.16 239.84, 63.3 232.8, 51.4 224.18 C39.5 215.55, 28.41 203.4, 20.7 191.63 C13 179.86, 8.72 167.14, 5.16 153.54 C1.59 139.94, -2.12 123.91, -0.68 110.03 C0.76 96.14, 7.41 82.82, 13.83 70.24 C20.24 57.66, 27.61 44.39, 37.8 34.56 C48 24.74, 62.03 17.23, 74.99 11.29 C87.95 5.35, 101.3 0.28, 115.57 -1.08 C129.85 -2.45, 153.21 1.91, 160.64 3.1 C168.08 4.3, 160.98 4, 160.16 6.1" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g stroke-linecap="round"><g transform="translate(136.97414430396537 56.78454161814568) rotate(0 19.756392712100876 56.809656006819694)"><path d="M0.53 -1.04 C7.05 17.83, 32.62 94.59, 39.2 113.8 M-0.65 1.03 C5.68 20.07, 31.39 96.91, 38.09 115.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(176.56021247689586 172.92182661837387) rotate(0 -12.190629563706835 59.15378660380625)"><path d="M-0.31 0.18 C-4.37 20.17, -19.63 99.16, -23.83 118.9 M1.73 -0.77 C-2.49 18.96, -20.34 96.94, -24.49 117.08" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(249.1154377068371 72.97405952176291) rotate(0 -36.401903160417675 49.36797237512289)"><path d="M0.55 0.59 C-11.72 17.06, -61.7 82.64, -73.93 99.03 M-0.62 -0.15 C-12.51 15.93, -59.65 80.31, -71.8 97.06" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(175.76112006497175 171.13444471574178) rotate(0 -53.04889963163541 31.228778508837337)"><path d="M-1.12 0.29 C-18.89 10.64, -88.72 52.26, -106.08 62.68 M0.49 -0.6 C-17.49 9.31, -89.34 49.86, -107.02 60.67" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(175.6002726758797 170.99614550185453) rotate(0 -54.65839150279311 -25.634348820825068)"><path d="M0.02 0.22 C-17.88 -8.32, -90.14 -42.21, -108.49 -50.95 M-1.43 -0.71 C-19.32 -9.66, -91.32 -44.45, -109 -52.9" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(303.10201392560583 166.87408248498247) rotate(0 -62.78610497380086 1.7358321223961752)"><path d="M0.83 0.32 C-20.22 0.7, -105.29 1.8, -126.3 2.51 M-0.19 -0.56 C-20.86 -0.07, -103.03 2.98, -123.97 3.55" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(176.27758213179692 170.74039062917723) rotate(0 42.762167153334644 45.52900354490407)"><path d="M-0.72 -0.96 C13.45 14.35, 71.62 76.81, 85.88 92.2 M1.1 1.15 C15.07 16.13, 70.74 75.38, 85.12 90.67" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(174.70302873566305 81.82893405355799) rotate(0 4.269996643066406 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(236.3226185881412 125.26151409719182) rotate(0 7 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(246.55099792579944 194.1862623799537) rotate(0 6.079994201660156 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(186.6451745678457 233.90200407494814) rotate(0 5.849998474121094 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g transform="translate(124.23857606766745 217.99511277813207) rotate(0 6.180000156164169 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">5</text></g><g transform="translate(88.54123678258082 160.15120304234574) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">6</text></g><g transform="translate(115.17449204727149 102.34161767125647) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(10 162.6309081802882) rotate(0 8.079986572265625 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">-1</text></g><g stroke-linecap="round"><g transform="translate(79.67088687380533 59.99492211383608) rotate(0 -25.774036486579433 46.54992079367452)"><path d="M1.07 -0.95 C-4.64 6.08, -26.09 25.62, -34.74 41.28 C-43.39 56.94, -48.18 84.2, -50.81 93 M0.18 1.17 C-5.12 8.47, -23.93 27.25, -32.49 42.77 C-41.05 58.29, -47.71 86.05, -51.19 94.27" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(79.67088687380533 59.99492211383608) rotate(0 -25.774036486579433 46.54992079367452)"><path d="M-51.84 69.28 C-53.44 74.31, -51.83 83.54, -51.19 94.27 M-51.84 69.28 C-51.48 75.59, -50.6 83.85, -51.19 94.27" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(79.67088687380533 59.99492211383608) rotate(0 -25.774036486579433 46.54992079367452)"><path d="M-35.62 74.7 C-41.41 78.46, -44.03 86.28, -51.19 94.27 M-35.62 74.7 C-40.04 79.57, -43.9 86.25, -51.19 94.27" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(70.5581190311762 290.5080072925721) rotate(0 11.109992980957031 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">-2</text></g><g stroke-linecap="round"><g transform="translate(74.79250933477533 193.5067404329548) rotate(305.6674340967637 -25.772858719324688 46.54992079367452)"><path d="M0.76 0.24 C-4.7 7.28, -24.67 26.26, -33.44 41.69 C-42.21 57.13, -49.04 84.3, -51.86 92.86 M-0.3 -0.68 C-5.82 6.02, -25.43 23.95, -34.18 39.74 C-42.93 55.53, -49.62 84.98, -52.79 94.06" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(74.79250933477533 193.5067404329548) rotate(305.6674340967637 -25.772858719324688 46.54992079367452)"><path d="M-54.34 69.11 C-53.67 75.82, -53.15 80.66, -52.79 94.06 M-54.34 69.11 C-54.59 76.93, -52.25 82.59, -52.79 94.06" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(74.79250933477533 193.5067404329548) rotate(305.6674340967637 -25.772858719324688 46.54992079367452)"><path d="M-37.94 73.95 C-41.23 79.59, -44.67 83.26, -52.79 94.06 M-37.94 73.95 C-42.83 80.42, -45.09 84.72, -52.79 94.06" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(204.7350169481872 309.080683269042) rotate(0 10.189987182617188 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">-3</text></g><g stroke-linecap="round"><g transform="translate(172.05591229648672 278.79877973709273) rotate(246.73803922725722 -23.506701176471495 39.37673394802411)"><path d="M-0.44 -0.14 C-5.67 6.2, -24.17 24.33, -31.87 37.67 C-39.58 51.02, -44.12 73.2, -46.66 79.91 M1.53 -1.27 C-3.81 5.21, -24.69 25.37, -32.82 38.61 C-40.95 51.85, -44.89 71.51, -47.24 78.17" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(172.05591229648672 278.79877973709273) rotate(246.73803922725722 -23.506701176471495 39.37673394802411)"><path d="M-48.64 56.87 C-48.59 62.36, -49.91 68.43, -47.24 78.17 M-48.64 56.87 C-47.15 65.49, -47.21 73.24, -47.24 78.17" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(172.05591229648672 278.79877973709273) rotate(246.73803922725722 -23.506701176471495 39.37673394802411)"><path d="M-34.62 60.96 C-38.16 65.34, -43.1 70.36, -47.24 78.17 M-34.62 60.96 C-38.68 67.86, -44.3 74, -47.24 78.17" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(317.48054494299237 228.4402871083343) rotate(0 9.959991455078125 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">-4</text></g><g stroke-linecap="round"><g transform="translate(301.6653914263688 237.8781936002204) rotate(204.32292953209424 -25.772858719324688 46.54992079367452)"><path d="M0.75 0.32 C-4.63 7.13, -24.56 24.78, -33.32 40.36 C-42.09 55.95, -48.72 84.9, -51.85 93.83 M-0.31 -0.55 C-5.71 6.41, -25.25 25.97, -33.99 41.37 C-42.74 56.78, -49.75 83.46, -52.78 91.87" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(301.6653914263688 237.8781936002204) rotate(204.32292953209424 -25.772858719324688 46.54992079367452)"><path d="M-53.77 66.89 C-53.11 73.06, -55.11 76.98, -52.78 91.87 M-53.77 66.89 C-54.43 75.23, -53.56 84.08, -52.78 91.87" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(301.6653914263688 237.8781936002204) rotate(204.32292953209424 -25.772858719324688 46.54992079367452)"><path d="M-37.48 72.09 C-40.26 77.26, -45.72 80.08, -52.78 91.87 M-37.48 72.09 C-43.99 78.68, -49 85.64, -52.78 91.87" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(301.76676247316874 91.28554345285227) rotate(0 10.289985656738281 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">-5</text></g><g stroke-linecap="round"><g transform="translate(354.5631398209378 122.177298465136) rotate(147.86380161455298 -25.772858719324688 46.54992079367452)"><path d="M0.85 -0.7 C-4.63 6.16, -25.18 26.05, -33.78 41.64 C-42.38 57.23, -47.95 84.22, -50.76 92.82 M-0.16 1.55 C-5.72 7.99, -26.2 24.26, -34.69 39.66 C-43.18 55.07, -48.58 84.86, -51.11 93.99" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(354.5631398209378 122.177298465136) rotate(147.86380161455298 -25.772858719324688 46.54992079367452)"><path d="M-53.99 69.16 C-54.41 74.91, -52.12 81.76, -51.11 93.99 M-53.99 69.16 C-53.76 75.55, -52.43 83.19, -51.11 93.99" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(354.5631398209378 122.177298465136) rotate(147.86380161455298 -25.772858719324688 46.54992079367452)"><path d="M-37.35 73.12 C-41.57 78.08, -43.07 84.03, -51.11 93.99 M-37.35 73.12 C-41.76 78.43, -45.03 84.97, -51.11 93.99" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(180.19102903324256 11.375396675230036) rotate(0 10.509986877441406 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">-6</text></g><g stroke-linecap="round"><g transform="translate(285.3979773838334 12.257901834966106) rotate(98.87996366169128 -25.772858719324688 46.54992079367452)"><path d="M-0.72 -0.76 C-6.39 6.13, -24.52 25.41, -33.05 41.23 C-41.58 57.06, -48.79 85.51, -51.89 94.2 M1.11 1.46 C-4.74 8.54, -24.59 27.54, -33.58 42.7 C-42.57 57.86, -49.85 83.78, -52.84 92.43" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(285.3979773838334 12.257901834966106) rotate(98.87996366169128 -25.772858719324688 46.54992079367452)"><path d="M-53.75 67.45 C-54.67 78.32, -53.28 85.94, -52.84 92.43 M-53.75 67.45 C-54.13 77.19, -52.73 86.54, -52.84 92.43" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(285.3979773838334 12.257901834966106) rotate(98.87996366169128 -25.772858719324688 46.54992079367452)"><path d="M-37.48 72.71 C-44.61 81.47, -49.42 87.09, -52.84 92.43 M-37.48 72.71 C-44.23 80.42, -49.2 87.72, -52.84 92.43" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(32.59627017187756 17.01222643704591) rotate(0 9.689987182617188 12.5)"><text x="0" y="17.619999999999997" font-family="Excalifont, Xiaolai, Segoe UI Emoji" font-size="20px" fill="#f08c00" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">-7</text></g><g stroke-linecap="round"><g transform="translate(143.0737987097932 -25.42778829444569) rotate(55.842657177256015 -25.772858719324688 46.54992079367452)"><path d="M-0.22 -0.51 C-5.87 6.32, -24.88 26.47, -33.6 42.15 C-42.32 57.83, -49.63 84.95, -52.56 93.57 M-1.79 -1.83 C-7.6 5.17, -26.35 24.89, -34.42 40.44 C-42.48 55.99, -47.48 82.92, -50.19 91.47" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(143.0737987097932 -25.42778829444569) rotate(55.842657177256015 -25.772858719324688 46.54992079367452)"><path d="M-52.56 66.58 C-52.41 75.08, -49.48 81.05, -50.19 91.47 M-52.56 66.58 C-51.83 75.95, -51.08 82.87, -50.19 91.47" stroke="#f08c00" stroke-width="2" fill="none"></path></g><g transform="translate(143.0737987097932 -25.42778829444569) rotate(55.842657177256015 -25.772858719324688 46.54992079367452)"><path d="M-36.01 70.88 C-41.27 77.95, -43.7 82.53, -50.19 91.47 M-36.01 70.88 C-40.91 78.9, -45.77 84.37, -50.19 91.47" stroke="#f08c00" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>
</div>

In programming languages, ${\scriptsize\%}$ of negative number will not get rid of the sign and so we need to the following extra work:

$$
i \text{ (mod} \ N)=
\begin{cases}
(N + i \ {\scriptsize\%} \ N) \ {\scriptsize\%} \ N, & \text{if } i < 0 \\
\\
\ \ i \ {\scriptsize\%} \ N,  & \text{else}
\end{cases}
$$

Here $i \ {\scriptsize\%} \ N$ brings any large negative number in $[-N+1, 0]$ range. Adding $N$ rids of negative sign, moving the number in $[1, N]$ range. The last ${\scriptsize\%} \ N$ shift it back in $[0, N)$ range.

$$
\begin{array} {|r|r|}
\hline i & i \ {\scriptsize\%} \ N & (N + i \ {\scriptsize\%} \ N) \ {\scriptsize\%} \ N \\
\hline -14 & 0 & 0 \\
\hline -13 & -6 & 1 \\
\hline -12 & -5 & 2 \\
\hline -11 & -4 & 3 \\
\hline -10 & -3 & 4 \\
\hline -9 & -2 & 5 \\
\hline -8 & -1 & 6 \\
\hline -7 & 0 & 0 \\
\hline -6 & -6 & 1 \\
\hline -5 & -5 & 2 \\
\hline -4 & -4 & 3 \\
\hline -3 & -3 & 4 \\
\hline -2 & -2 & 5 \\
\hline -1 & -1 & 6 \\
\hline 0 & 0 & 0 \\
\hline 1 & 1 & 1 \\
\hline 2 & 2 & 2 \\
\hline 3 & 2 & 3 \\
\hline 4 & 4 & 4 \\
\hline 5 & 5 & 5 \\
\hline 6 & 6 & 6 \\
\hline 7 & 0 & 0 \\
\hline 8 & 1 & 1 \\
\hline 9 & 2 & 2 \\
\hline 10 & 3 & 3 \\
\hline 11 & 4 & 4 \\
\hline 12 & 5 & 5 \\
\hline 13 & 6 & 6 \\
\hline 14 & 0 & 0 \\
\hline
\end{array}
$$
