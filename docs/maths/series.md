# Series

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

## Arithmetic progression

$$
\begin{alignat}{1}
a_1 & = \text{first term} \\
a_n & = \text{last term} \\
S_n = \sum_{i=1}^{n}{a_i} &= a_1 + a_2 + a_3 + \dots + a_n \\
&= n \cdot \dfrac{a_1 + a_n}{2} \\
&= n \cdot \overline a\\
&= \text{length of the series} \cdot \text{mean of the series}
\end{alignat}
$$

### First $n$ natural numbers

$$
1 + 2 + 3 + \dots + n = n \cdot \dfrac{n+1}{2}
$$

## Geometric progression

$$
\begin{alignat}{1}
a_0 &= a \hspace{2.9em} \text{the first term} \\
a_n &= ar^{n-1} \hspace{2em} \text{the last term} \\
S_n = \sum_{i=0}^{n-1}{ar^i} &= a + ar + ar^2 + \dots + ar^{n-1} \\
&= a \cdot \dfrac{r^n-1}{r-1} \text{ for } r \not = 1
\end{alignat}
$$

### Special case

When $|r| < 1$ and $n \to \infty$, the $r^n$ term vanishes and leaves a simplified sum:

$$
\dfrac{a}{1-r}
$$

## Common sums

$$
\begin{alignat}{1}
1 + \dfrac{1}{2} + \dfrac{1}{2^2} + \dfrac{1}{2^3} + \dots &= 2
\\
\\
1 + \dfrac{1}{1!} + \dfrac{1}{2!} + \dfrac{1}{3!} + \dots &= e \\
\\
1 + \dfrac{x}{1!} + \dfrac{x^2}{2!} + \dfrac{x^3}{3!} + \dots &= e^x \\
\\
{}^n\mathrm{C}_0 + {}^n\mathrm{C}_1 + {}^n\mathrm{C}_2 + \dots + {}^n\mathrm{C}_n &= 2^n \\
&= (1 + 1)^n \\
\\
\end{alignat}
$$
