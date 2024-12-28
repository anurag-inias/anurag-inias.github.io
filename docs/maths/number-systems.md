# Number Systems

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

## Common Sets

- \\(\mathbb{N} = \lbrace 1, 2, 3, ... \rbrace \\), set of all natural numbers.
- \\(\mathbb{W} = \lbrace 0, 1, 2, 3, ... \rbrace \\), _whole numbers_, which is \\(\mathbb{N} \cup \lbrace0\rbrace\\)[^1].
- \\(\mathbb{Z} = \lbrace ..., -2, -1, 0, 1, 2, ... \rbrace \\), set of all integers.
- \\(\mathbb{Q} = \lbrace p/q \text{ | } p, q \in \mathbb{Z} \text{ and } q \not= 0 \rbrace \\), set of all rational numbers.
- \\(\mathbb{Z}\\), set of all real numbers.
- \\(\mathbb{C}\\), set of all complex numbers.
- \\(\phi\\), empty set.

[^1]: \\(\mathbb{W}\\) is mostly irrelavant since recent texts include \\(0\\) in \\(\mathbb{N}\\).

## Rational Numbers

A number \\(r\\) is called _a rational number_ if it can be written in the form of \\(\dfrac{p}{q}\\) where \\(p\\) and \\(q\\) are integers and \\(q \ne 0\\).

Rational numbers do not have a unique representation, e.g. \\(\dfrac{1}{2}\\) is same as \\(\dfrac{2}{4}, \dfrac{10}{20}, \dfrac{30}{60}\\) and so on.

Note that \\(0\\) is a rational number, so is \\(1, 2, 3...\\). There are infinitely many rational numbers between any two given rational numbers.

## Irrational Numbers

A number is called _irrational_ if it cannot be written in the form of \\(\dfrac{p}{q}\\). Some examples being \\(\sqrt 2, \sqrt 3, \pi, 0.123128821...\\).

Any real number is either rational or irrational.

## Decimal Expansion

Another way to differentiate between rational and irrational numbers is to look at their decimal expansions.

Consider the example of \\(\dfrac{10}{3}, \dfrac{7}{8}\\) and \\(\dfrac{1}{7}\\).

- \\(\dfrac{7}{8} = 0.875\\), decimal representation is finite as the remainder of the division eventually becomes zero.
- \\(\dfrac{10}{3} = 3.3333...\\) and \\(\dfrac{1}{7} = 0.142857142857...\\), decimal expansion never ends as the remainder of the division never becomes zero. Notice that the remainder repeats again and again. We write these as \\(3.\overline{3}\\) and \\(0.\overline{142857}\\).

!!! quote ""

    Thus a rational number is in which the decimal expansion is either terminating or recurringly non-terminating.

Irrational numbers, on the other hand are non-terminating non-recurring.

## Operations on Real Numbers

Rational numbers satisfy the commutative, associative and distributive laws for addition and multiplication. Moreoever, they are _"closed"_ with respect to addition, subtraction, multplication and division. That is, if we add, subtract, multiply or divide (except by zero) two rational numbers, we get another rational number.

However, this closure does not exist for irrational numbers. e.g. \\(\sqrt 2 - \sqrt{2} = 0, \dfrac{\pi}{\pi} = 1, \sqrt 3 \times \sqrt 3 = 3\\) are all rational numbers.

## Laws of Exponents

Work as expected for real numbers.

- \\(a^m a^n = a^{m+n}\\)
- \\((a^m) ^n = a^{mn}\\)
- \\(\dfrac{ a^m }{ a^n } = a^{m-n}\\)
- \\(a^m b^m = (ab) ^m\\)
