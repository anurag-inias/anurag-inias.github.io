# Longest Common Substring

<style>
.md-logo img {
  content: url('/algorithms/dynamic-programming/logo-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/dynamic-programming/logo-dark.png');
}
</style>

## Problem

Same as [longest common subsequence](longest-common-subsequence.md), but now we are interested in finding the contiguous subsequence (substring).

## Example

$$
\begin{alignat}{1}
X_1 &= A\fbox{BABC} \\
Y_2 &= \fbox{BABC}A \\
LCS &= BABC
\end{alignat}
$$

## Hint

??? "Expand"

    Can $L_{ij}$ reuse $L_{(i-1) \ j}$ and $L_{i \ (j-1)}$?

## Solution

??? "Expand"

    Lets consider a subproblem where our two strings be $X_i$ and $Y_j$, ending at $i^{th}$ index of $X$ and $j^{th}$ index of $Y$ respectively.

    $$
    \begin{alignat}{1}
    X_i &= \fbox{ $\dots$ x} \\
    Y_j &= \fbox{ $\dots$ y} \\
    \end{alignat}
    $$

    if $x = y$, then $L_{ij} = 1 + L_{(i-1)(j-1)}$. But note that $L_{(i-1) \ j}$ and $L_{i \ (j-1)}$ are not subproblem to $L_{ij}$.

    $$
    L_{ij} =
    \begin{cases}
        L_{(i-1)(j-1)} & \text{ if } x = y\\
        \\
        0 & \text{ otherwise}
    \end{cases}
    $$

    $$
    \begin{array}
      {r | r r}
      {} & A & B & C & B & D & A & B & {} \\
      \hline {} B & 0 & 1 & 0 & 1 & 0 & 0 & 1 \\
      D & 0 & 0 & 0 & 0 & 2 & 0 & 0 \\
      C & 0 & 0 & 1 & 0 & 0 & 0 & 0 \\
      A & 1 & 0 & 0 & 0 & 0 & 1 & 0 \\
      B & 0 & 2 & 0 & 1 & 0 & 0 & 2 \\
      A & 1 & 0 & 0 & 0 & 0 & 1 & 0 \\
    \end{array}
    $$

    so the longest common substrings are $AB$ and $BD$.
