# Generate Specified Row of Pascal's Triangle

<style>
.md-logo img {
  content: url('/practice/practice-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/practice/practice-dark.png');
}
</style>

## Problem

Recall [Pascal's Triangle](/maths/combinatorics/p-and-c).

$$
\begin{alignat}{1}
& 1 \\
1 \hspace{0.5em} &{} \hspace{1em} 1 \\
1 \hspace{1.5em} & 2 \hspace{1.5em} 1 \\
1 \hspace{1.5em} 3 \hspace{0.5em} &{} \hspace{1.0em} 3 \hspace{1.5em} 1
\end{alignat}
$$

Given row index $i$, generate the that row.

## Example

- $row = 3$
- $result$ is $1, 3, 3, 1$

## Hint

??? "First"

    You don't need to use the ${}^n\mathrm{C}_r$ formula.

??? "Second"

    $$
    \begin{alignat}{1}
    ^n\mathrm{C}_r &= \dfrac{n!}{(n-r)!r!} \\
    \\
    ^n\mathrm{C}_{r+1} &= \dfrac{n!}{(n-r-1)!(r+1)!} \\
    \\
    &= \dfrac{n!(n-r)}{(n-r)!(r+1)!} \\
    \\
    &= \dfrac{n!(n-r)}{(n-r)!r!(r+1)} \\
    \\
    &= ^n\mathrm{C}_r \cdot \dfrac{n-r}{r+1}
    \end{alignat}
    $$

    So we can derive the next item in the know, provided the previous item is known.

## Solution

??? "Expand"

    ```kotlin linenums="1"
    fun getRow(n: Int): List<Int> {
      val result = ArrayList<Int>(n + 1)
      result.add(1)
      var prev = 1L

      for (r in 0..<n) {
        val curr = prev * (n - r) / (r + 1)
        result.add(curr.toInt())
        prev = curr
      }

      return result
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun example() {
  assertThat(getRow(0)).isEqualTo(listOf(1))
  assertThat(getRow(1)).isEqualTo(listOf(1, 1))
  assertThat(getRow(2)).isEqualTo(listOf(1, 2, 1))
  assertThat(getRow(3)).isEqualTo(listOf(1, 3, 3, 1))
}
```
