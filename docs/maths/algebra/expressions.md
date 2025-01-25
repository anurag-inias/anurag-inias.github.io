# Algebraic expressions

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

## Terms and coefficient

$$
3xy - 4y
$$

- is an algebraic expression in two variables $x$ and $y$.
- It has two terms: $xy$ term and $y$ term.
- $3$ is the coefficient of $xy$ term and $-4$ is the coefficient of $y$ term.

## Polynomial

Is a mathematical expression consisting of variables (aka indeterminates) and coefficients, e.g.

$$
p(x) = x^2 + 2x + 1
$$

### Degree of a polynomial

is the largest degree of any term with nonzero coefficient. For example:

- $2x^2 - 5x$ has degree 2.
- $x^2y$ has degree 3.
- Polynomial of degree zero is called a _constant polynomial_.
- of degree one is called a _linear polynomial_.
- of degree two is called a _quadratic polynomial_.
- of degree three is called a _cubic polynomial_.

### Factorization

Fundamental Theorem of Algebra states that every polynomial $p(x)$ of degree $n$ with coefficients in $\mathbb{C}$ is the product of $n$ linear factors.

$$
p(x) = a(x - r_1)\ldots(x - r_n) \text{ where } r_1, r_2, \ldots r_n \in \mathbb{C}
$$

### Factor theorem

If $p(x)$ is a polynomial, then $(x - a)$ is a factor of $p(x)$ iff $p(a) = 0$.

## Common identities

$$
\begin{alignat}{1}
(a + b)^2 & = a^2 + 2ab + b^2 \\
(a - b)^2 & = a^2 - 2ab + b^2 \\
(a + b)(a - b) & = a^2 - b^2 \\
\\
(a + b + c)^2 & = a^2 + b^2 + c^2 + 2ab + 2bc + 2ca \\
(a + b)^3 & = a^3 + b^3 + 3ab(a + b) \\
(a - b)^3 & = a^3 - b^3 - 3ab(a - b) \\
\\
(x + a)(x + b) & = x^2 + (a + b)x + ab \\
\\
\end{alignat}
$$

## Quadratic formula

is the closed-form expression describing the solutions of a quadratic equation.

Given a general quadratic equation $P(x) = ax^2 + bx + c$ and $a \not = 0$, the roots (aka _zeros_) of the equation are:

$$
x = \dfrac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$

$P(x)$ has:

1. two distinct real roots, if $b^2 - 4ac > 0$.
2. two equal roots, if $b^2 - 4ac = 0$.
3. no real roots, if $b^2 - 4ac < 0$.

### Derivation

From the previously mentioned identities:

$$
\begin{alignat}{1}
(x + k)^2 & = x^2 + 2xk + k^2
\end{alignat}
$$

we can acquire roots of a $ax^2 + bx + c$ by transforming it in the form above.

$$
\begin{alignat}{1}
ax^2 + bx + c & = 0 \\
x^2 + \dfrac{b}{a}x + \dfrac{c}{a} & = 0 \\
x^2 + \dfrac{b}{a}x &= -\dfrac{c}{a} \\
\end{alignat}
$$

with $k = \dfrac{b}{2a}$, we tranform:

$$
\begin{alignat}{1}
x^2 + 2(\dfrac{b}{2a})x + (\dfrac{b}{2a})^2 &= -\dfrac{c}{a} + (\dfrac{b}{2a})^2 \\
(x + \dfrac{b}{2a})^2 &= \dfrac{b^2}{4a^2} -\dfrac{c}{a} \\
& = \dfrac{b^2 - 4ac}{4a^2} \\
x + \dfrac{b}{2a} & = \pm \dfrac{\sqrt{b^2 - 4ac}}{2a} \\
x & = \pm \dfrac{\sqrt{b^2 - 4ac}}{2a} - \dfrac{b}{2a} \\
& = \dfrac{-b \pm \sqrt{b^2 - 4ac}}{2a}
\end{alignat} \\
$$
