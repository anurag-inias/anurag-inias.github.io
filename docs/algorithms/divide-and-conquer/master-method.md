# The Master Method

<style>
.md-logo img {
  content: url('/algorithms/divide-and-conquer/logo-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/divide-and-conquer/logo-dark.png');
}
</style>

<div markdown style="text-align: center">
[![](/algorithms/divide-and-conquer/one.gif){width=200}]("I couldn't resist")
</div>

The master method is a "black-box" method to determine the running time of a recursive algorithm.

## Recurrence Expression

Given a recursive algorithm, let $T(n)$ be the time complexity for input size $n$. We can express $T(n)$ in terms of complexity of recursive calls.

$$
T(n) \le a \cdot T{\Large(}\dfrac{n}{b}{\Large)} + O(n^d)
$$

- $a$ is the number of recursive calls.
- $b$ is the shrinkage factor of the input in recursive calls.
- $d$ is the exponent of the running time during the _combine step_.
- $T{\Large(}\dfrac{n}{b}{\Large)}$ is the time complexity of individual recursion subproblem.

## Master Method

Give the standard recurrence expression above, the master method defines bounds of $T(n)$ as follows:

$$
T(n)=
\begin{cases}
    O(n^d \log n) & \text{if } a = b^d \\
    \\
    O(n^d)        & \text{if } a < b^d \\
    \\
    O(n^{\log_{b} a}) & \text{if } a > b^d
\end{cases}
$$

## Examples

### 1. Merge sort

In merge sort, we have two recursive calls $a = 2$. Each call works on half of the passed input $b = 2$. Finally, the merge steps runs in linear time $d = 1$.

$$
\begin{alignat}{1}
a &= 2 \\
b^d &= 2^1 \\
\Rightarrow a &= b^d
\end{alignat}
$$

Which gives us $T(n) = O(n \log n)$.

### 2. Binary search

In binary search we work on half the input after each branching $b = 2$, yet the recursive calls remains just $1$. There is no work to be done in _combine step_ $d = 0$.

$$
\begin{alignat}{1}
a &= 1 \\
b^d &= 2^0 = 1 \\
\Rightarrow a & = b^d
\end{alignat}
$$

Leading to $T(n) = O(\log n)$.

## Explanation

![](/algorithms/divide-and-conquer/subproblem-graph.png)

At any given level $i$, we have $a^i$ subproblems, each of input size $\dfrac{n}{b}$.

$$
\begin{alignat}{1}
c \cdot {\Large(}\dfrac{n}{b^i}{\Large)}^d &= \text{work per subproblem} \\
\text{number of subproblems} &= a^i \\
\Rightarrow \text{work done at level } i &= a^i \cdot {\Large(}\dfrac{n}{b^i}{\Large)}^d \\
&= n^d \cdot {\Large(} \dfrac{a}{b^d} {\Large)}^i
\end{alignat}
$$

This is where our ratio $\dfrac{a}{b^d}$ coming from. $a$ is factor with which the number of subproblems explode, and $b^d$ is the factor with which the input for these subproblems shrinks.

### case: $a = b^d$

Work done in each level simplifies to $n^d$, with a total of $\log_bn$ levels. This gives us the run time of $O(n^d \log_bn)$.

### case: $a < b^d$

We have at our hand a geometric progression of length $\log_bn$ and common ratio $\dfrac{a}{b^d}$. Recall the special case for geometric progression we previously covered [here](/maths/series). This gives us the time complexity of:

$$
\begin{alignat}{1}
T(n) &= \dfrac{n^d}{1 - \dfrac{a}{b^d}} \\
&= c \cdot n^d \text{ where } c = \dfrac{b^d}{b^d - a} \\
&= O(n^d)
\end{alignat}
$$

### case: $a > b^d$

Again from the geometric series sum, we have:

$$
\begin{alignat}{1}
T(n) &= n^d \cdot \dfrac{{\Large(}\dfrac{a}{b^d}{\Large)}^{\log_bn} - 1}{\dfrac{a}{b^d} - 1} \\
\\
&= n^d \cdot \dfrac{n^{\log_b{\frac{a}{b^d}}} - 1}{\dfrac{a}{b^d} - 1} \\
\\
&= n^d \cdot \dfrac{\dfrac{n^{\log_ba}}{n^d} - 1}{\dfrac{a}{b^d} - 1}
\\
\\
&= \dfrac{n^{\log_ba} - n^d}{\dfrac{a}{b^d} - 1}
\end{alignat} \\
$$

Since $a > b^d \Rightarrow \log_ba > \log_bb^d \Rightarrow \log_ba > d$, we can say that in the numerator, $n^{\log_ba}$ is the dominant term. Also since the denominator is a constant term, this gives us the run time of

$$
O(n^{\log_ba})
$$
