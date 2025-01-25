# Proof $\sqrt 2$ is irrational

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

Assume that $\sqrt 2$ is in fact rationa. That is $\sqrt 2 = \dfrac{a}{b}$ where $a$ and $b$ are coprime (have no common factors other than $1$).

$$
\begin{alignat}{1}
\sqrt 2 &= \dfrac{a}{b} \\
2 &= \dfrac{a^2}{b^2} \\
2b^2 &= a^2
\end{alignat}
$$

There $a^2$ must be even and $2$ must divide $a^2$. Now if a prime $p$ divides $a^2$, then it must also divide $a$. This suggests that $2$ must divide $a$ too, i.e. $a = 2c$ for some $c$.

$$
\begin{alignat}{1}
2b^2 &= 4c^2 \\
b^2 &= 2c^2
\end{alignat}
$$

Same as before, this means $2$ must divide $b$. But this is a contradiction, as we started with the assumption that $a$ and $b$ are coprime.
