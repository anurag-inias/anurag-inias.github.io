# Laws of arithmetic

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

## _Commutativity_

Addition and multiplication are _commutative_ operations, for the order in which two numbers are added or multiplied doesn't affect the result.

$$
\begin{alignat}{1}
a + b & = b + a \\
ab & = ba \\
\end{alignat}
$$

This is not the case with subtraction and division.

$$
\begin{alignat}{1}
a - b & \not = b - a \text{, unless } a = b \\
\dfrac{a}{b} & \not = \dfrac{b}{a} \text{, unless } a = b
\end{alignat}
$$

## _Associativity_

The way in which two or more numbers are associated under addition and multiplication does not affect the result.

$$
\begin{alignat}{1}
a + (b + c) & = (a + b) + c \\
a (bc) & = (ab) c
\end{alignat}
$$

This is not the case with subtraction and division.

$$
\begin{alignat}{1}
a - (b - c) & \not = (a - b) - c \\
\Rightarrow (a - b + c) & \not = (a - b -c) \text{, unless } c = 0 \\
\\
a \div (b \div c) & \not = (a \div b) \div c \\
\Rightarrow \dfrac{ac}{b} & \not = \dfrac{a}{bc} \text{, unless } c = 1
\end{alignat}
$$

## _Distributivity_

Multiplication is distributed over addition and subtraction in either direction.

$$
\begin{alignat}{1}
a (b + c) & = ab + ac \\
(a - b) & c = ac - bc
\end{alignat}
$$

Division is distributed over addition and subtraction from the right, but not from the left.

$$
\begin{alignat}{1}
(a \pm b) \div c & = (a \div b) \pm (b \div c) \\
\Rightarrow \dfrac{a \pm b}{c} & = \dfrac{a}{c} \pm \dfrac{b}{c} \\
\\
a \div (b \pm c) & \not = (a \div b) \pm (a \div c)  \\
\Rightarrow \dfrac{a}{b \pm c} & \not = \dfrac{a}{b} \pm \dfrac{a}{c} \\
\end{alignat}
$$
