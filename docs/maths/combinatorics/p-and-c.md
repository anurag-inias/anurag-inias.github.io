# Combinatorics

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

## Permutation

The number of permutations of $n$ different objects taken $r$ at a time, where $0 < r \le n$ and the objects do not repeat is:

$$
\begin{alignat}{1}
{}^n\mathrm{ P }_r &= n (n-1) (n-2) \dots (n-r+1) \\
&= \dfrac{n!}{(n-r)!}
\end{alignat}
$$

we arrive at this in the following manner:

$$
\begin{alignat}{1}
\text{pick }1^{st}\text{ item} &= n \text{ options} \\
\text{pick }2^{nd}\text{ item} &= n-1 \text{ options} \\
\text{pick }3^{rd}\text{ item} &= n-2 \text{ options} \\
\text{pick }4^{th}\text{ item} &= n-3 \text{ options} \\
...\\
\text{pick }r^{th}\text{ item} &= n-r+1 \text{ options} \\
\end{alignat}
$$

Another way to think is that total permutation of all $n$ objects would be $n!$, and since we are only taking in $r$ objects, the permutation of remaining $n-r$ objects has to be removed.

### Identical objects

Number of permutations of $n$ objects, where $p$ objects are identical is

$$
\dfrac{n!}{p!}
$$

infact a more general format for $p_1$ objects of one kind, $p_2$ objects of second kind, ..., $p_k$ objects of $k^{th}$ kind is:

$$
\dfrac{n!}{p_1!p_2!\dots p_k!}
$$

As explanation, consider the number of permutation for $n$ distict objects: $^n\mathrm{P}_n = \dfrac{n!}{0!} = n!$. The $p_1$ interchangeable objects contributed $p_1!$ to the overcount, which can be corrected by dividing $p!$ by $p_1!$. Same for the other identical sets.

## Combinations

Combinations is the selection of objects from a set such that the order of selection is immaterial.

$$
^n\mathrm{C}_r = \dfrac{{}^n\mathrm{ P }_r}{r!} = \dfrac{n!}{(n-r)!r!}
$$

## Binomial Theorem

$$
\begin{alignat}{1}
(a + b)^0 &= \hspace{5.8em} 1 \\
(a + b)^1 &= \hspace{4.9em} a + b \\
(a + b)^2 &=  \hspace{3.2em} a^2 + 2ab + b^2 \\
(a + b)^3 &= \hspace{1.5em} a^3 + 3a^2b + 3ab^2 + b^3 \\
(a + b)^4 &= a^4 + 4a^3b + 6a^2b^2 + 4ab^3 + b^4 \\
...
\end{alignat}
$$

$$
\begin{alignat}{1}
& ^0\mathrm{C}_0 \\
^1\mathrm{C}_0 & \hspace{1.6em} ^1\mathrm{C}_1 \\
^2\mathrm{C}_0 \hspace{1.6em} & ^2\mathrm{C}_1 \hspace{1.6em} ^2\mathrm{C}_2 \\
& \dots \\
\end{alignat}
$$

## Properties

$$
\begin{alignat}{1}
& {}^n\mathrm{C}_r = {}^n\mathrm{C}_{n-r} \\
& {}^n\mathrm{C}_r + {}^n\mathrm{C}_{r-1} = {}^{n+1}\mathrm{C}_{r} \\
\\
& \sum_{k=0}^{n}{ ^n\mathrm{C}_k } = {}^n\mathrm{C}_0 + {}^n\mathrm{C}_1 + \dots + {}^n\mathrm{C}_n = (1+1)^n = 2^n \\
& \sum_{k=0}^{n}{ (^n\mathrm{C}_k)^2 } = {}^{2n}\mathrm{C}_n \\
\end{alignat}
$$
