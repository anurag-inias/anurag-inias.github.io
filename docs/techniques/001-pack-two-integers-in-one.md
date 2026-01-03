# Pack two integers in one

Let $a, b \in [0, n)$. We can pack both $a$ and $b$ in one integer $x$ such that they can be recovered back.

$$
x = a + n \cdot b
$$

<div markdown class="grid">

### Recover $a$

### Recover $b$

<div markdown>
$$
\begin{align}
x \ \% \ n &= (a + n \cdot b) \ \% \ n \\
      &= a \ \% \ n \ \ + \ \ n \cdot b \ \% \ n \\
      &= a + 0 \\
      &= a
\end{align}
$$
</div>

<div markdown>
$$
\begin{align}
x \ \div \ n &= (a + n \cdot b) \ \div \ n \\
      &= a \ \div \ n \ \ + \ \ n \cdot b \ \div \ n \\
      &= 0 + b \\
      &= b
\end{align}
$$

where $\div$ is integer division.
</div>

</div>
