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
