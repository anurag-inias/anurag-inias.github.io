# GCD

Given two non-negative integers $a$ and $b$, their greatest common divisor **GCD** is:

$$
\text{gcd}(a, b) = \begin{cases}
a, & \text{ if } b = 0 \\
\text{gcd}(b, a \text{ mod } b), & \text{ otherwise}
\end{cases}
$$

```kotlin linenums="1"
fun gcd(x: Int, y: Int): Int {
  var (a, b) = x to y
  while (b != 0) {
    val t = a
    a = b
    b = a % b
  }
  return a
}
```

with run time $O(\log{\text{min}(a, b)})$