# Longest Common Subsequence

<style>
.md-logo img {
  content: url('/algorithms/dynamic-programming/logo-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/dynamic-programming/logo-dark.png');
}
</style>

## Context

A strand of DNA consists of a string of molecules called _bases_, where the possible bases are:

- A: adenine
- C: cytosine
- G: guanine
- T: thymine

As an example, the DNA of two organism may be

$$
\begin{alignat}{1}
S_1 &= ACCGGTCGAGTGCGCGGAAGCCGGCCGAA \\
S_2 &= GTCGTTCGGAATGCCGTTGCTCTGTAAA
\end{alignat}
$$

we now may be interested in figuring out how similar the two DNAs are. There can be many criteria to this:

1. Is one DNA strand substring of the other?
2. what is the edit distance between the two strands?
3. what is the longest subsequence the two strands share?

It is the last criteria we are interested in.

## Problem

Given two strings of arbitrary length, find the longest common subsequence between the two. Going back to our DNA example, that'll be:

$$
\begin{alignat}{1}
S_1 &= ACCG\fbox{GTC}GA\fbox{GT}GCG\fbox{CGGAA}\fbox{GCCG}\fbox{GC}\fbox{C}\fbox{G}\fbox{AA} \\
S_2 &= \fbox{GTC}\fbox{GT}T\fbox{CGGAA}T\fbox{GCCG}TT\fbox{GC}T\fbox{C}T\fbox{G}T\fbox{AA}A \\
LCS &= \fbox{GTC}\fbox{GT}\fbox{CGGAA}\fbox{GCCG}\fbox{GC}\fbox{C}\fbox{G}\fbox{AA}
\end{alignat}
$$

## Examples

Let's begin thinking of the solution for two strings $S_1$ and $S_2$ in terms of their substrings. For simplicity's sake consider we start with substrings of same length.

<div markdown class="grid">

$$
\begin{alignat}{1}
S_1 &= \fbox ABCBDAB \\
S_2 &= \fbox BDCABA \\
LCS &= \fbox {$\phantom{A}$} \\
length &= 0
\end{alignat}
$$

<div markdown>
$A$ and $B$ have nothing in common, so $LCS_{00}=0$
</div>

<hr>

<hr>

$$
\begin{alignat}{1}
S_1 &= \fbox {AB} CBDAB \\
S_2 &= \fbox {BD} CABA \\
LCS &= \fbox {B} \\
length &= 1
\end{alignat}
$$

<div markdown>
$AB$ and $BD$ don't end on same character.

$$
\begin{alignat}{1}
S_1 &= \fbox{AB} \\
S_2 &= \fbox{B}D \\
LCS_{11} &= LCS_{10}
\end{alignat}
$$

</div>

<hr>

<hr>

$$
\begin{alignat}{1}
S_1 &= \fbox {ABC} BDAB \\
S_2 &= \fbox {BDC} ABA \\
LCS &= \fbox {BC} \\
length &= 2
\end{alignat}
$$

<div markdown>
$ABC$ and $BDC$ **do** end on same character.

$$
\begin{alignat}{1}
S_1 &= \fbox{ABC} \\
S_2 &= \fbox{BDC} \\
LCS_{22} &= LCS_{11} + 1
\end{alignat}
$$

</div>

</div>

## Solution

??? "Formula"

    $$
    LCS_{ij} = max
    \begin{cases}
        LCS_{i-1 \ \ j-1} \\
        LCS_{i-1 \ \ j} \\
        LCS_{i \ \ j-1} \\
    \end{cases} +
    \begin{cases}
        1 & \text{ if } S_i = S_j \\
        0 & \text{ otherwise} \\
    \end{cases}
    $$

    $$
    \begin{array}
      {r | r r}
      {} & A & B & C & B & D & A & B & {} \\
      \hline {} B & 0 & 1 & 0 & 1 & 0 & 0 & 1 \\
      D & 0 & 1 & 1 & 1 & 2 & 2 & 2 \\
      C & 0 & 1 & 2 & 2 & 2 & 2 & 2 \\
      A & 1 & 1 & 2 & 2 & 2 & 3 & 3 \\
      B & 0 & 2 & 2 & 3 & 3 & 3 & 4 \\
      A & 1 & 2 & 2 & 3 & 3 & 4 & 4 \\
    \end{array}
    $$

    ![](/algorithms/dynamic-programming/lcs-construction.png)

??? "Implementation"

    ```golang linenums="1"
    func LCS(row, column string) string {
      // If one of the string is empty, then there
      // is no longest common subsequence to return.
      if len(row) == 0 {
        return ""
      }
      if len(column) == 0 {
        return ""
      }
      memoization := make([][]int, len(row))
      // Method to handle invalid indices gracefully.
      // i.e. trying to get memoization value at
      // (-1, -1), (-1, 0) and (0, -1).
      get := func(r, c int) int {
        if r < 0 || c < 0 {
          return 0
        }
        return memoization[r][c]
      }

      // Populate memoization table with our solution
      // formula.
      for r, x := range row {
        memoization[r] = make([]int, len(column))

        for c, y := range column {
          memoization[r][c], _ = max(get(r-1, c-1), get(r-1, c), get(r, c-1))
          if x == y {
            memoization[r][c]++
          }
        }
      }

      // We have the length of the LCS.
      // Now work backwords to get the actual string.
      result := make([]rune, memoization[len(row)-1][len(column)-1])
      i := len(result) - 1
      for r, c := len(row)-1, len(column)-1; r >= 0 && c >= 0; {
        a, b := row[r], column[c]
        if a == b {
          result[i], i, r, c = rune(a), i-1, r-1, c-1
        } else {
          _, direction := max(get(r-1, c-1), get(r-1, c), get(r, c-1))
          switch direction {
          case 0:
            r, c = r-1, c-1
          case 1:
            r--
          case 2:
            c--
          }
        }
      }

      slices.Reverse(result)
      return string(result)
    }

    // Helper method to get the maximum of given number
    // as well as index of that max number.
    func max(nums ...int) (int, int) {
      if len(nums) == 0 {
        return 0, -1
      }
      m, mi := nums[0], 0
      for i := 1; i < len(nums); i++ {
        if nums[i] > m {
          m, mi = nums[i], i
        }
      }
      return m, mi
    }
    ```
