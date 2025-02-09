# Longest Palindromic Subsequence

<style>
.md-logo img {
  content: url('/algorithms/dynamic-programming/logo-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/dynamic-programming/logo-dark.png');
}
</style>

## Problem

Given a string $S$, find the longest subsequence which is a palindrome.

## Example

$$
\begin{alignat}{1}
S &= AB\fbox BD\fbox{CACB} \\
LPS &= BCACB
\end{alignat}
$$

## Hint

??? "Expand"

    $$
    \begin{alignat}{1}
    S_{ij} &= \ \ \ \fbox { $\phantom{x} \dots \phantom{x}$ } \\
    \\
    S_{(i-1)(j+1)} &= x \ \fbox { $\phantom{x} \dots \phantom{x}$ } \ y
    \end{alignat}
    $$

## Solution

??? "Breakdown"

    Lets jump in the middle, and assume that we know the longest palindromic subsequence between indices $i$ and $j$ to be $L_{ij}$. If we now expand on either end by one character, we get.

    $$
    \begin{alignat}{1}
    S_{ij} &= \ \ \ \fbox { $\phantom{x} \dots \phantom{x}$ } \\
    \\
    S_{(i-1) \ (j+1)} &= x \ \fbox { $\phantom{x} \dots \phantom{x}$ } \ y
    \end{alignat}
    $$

    If $x = y$, then

    $$
    L_{(i-1) \ (j+1)} = L_{ij} + 2
    $$

    and if $x \not = y$ then

    $$
    \begin{alignat}{1}
    S_{(i-1) \ j} &= x \ \fbox { $\phantom{x} \dots \phantom{x}$ } \\
    S_{i \ (j+1)} &= \fbox { $\phantom{x} \dots \phantom{x}$ } \ y \\
    \\
    L_{(i-1) \ (j+1)} &= max( L_{(i-1) \ j} \ , \ L_{i \ (j+1)})
    \end{alignat}
    $$

??? "Formula"

    Let $L_{ij}$ be the longest palindromic subsequence starting at index $i$ and ending at index $j$.

    $$
    L_{ij} =
    \begin{cases}
        1 & \text{ if } i = j \\
        \\
        L_{(i+1)(j-1)} + 2 & \text{ if } S_i = S_j \\
        \\
        max(L_{(i+1) \ j} \ , \ L_{i \ (j-1)}) & \text{otherwise}
    \end{cases}
    $$
