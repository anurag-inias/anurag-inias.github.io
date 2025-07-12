# Calculate exponent of an integer

## Problem

Given integers $a$ and $n$ where $n > 0$, calculate $a^n$.

## Hint

??? "Expand"

    Minimize the number of multiplications

## Solution

??? "Approach"

    A straightforward solution would be to multiply $a$ to itself $n$ times. That's $O(n)$ solution.

    As an alternative, consider the example of $6^{25}$.

    $$
    \begin{alignat}{1}
    6^{24} &= (6^{12})^2 \\
    6^{12} &= (6^6)^2 \\
    6^6 &= (6^3)^2 \\
    6^3 &= (6)^2 \cdot 6 \\
    \end{alignat}
    $$

    That is, $a^n$ can be broken down in recursive subproblems.

    $$
    a^n =
    \begin{cases}
        (a^{\frac{n}{2}})^2,& \text{if } n \text{ is even}\\
        (a^{\frac{n}{2}})^2 \cdot a,              & \text{otherwise}
    \end{cases}
    $$

??? "Implementation"

    ```kotlin linenums="1"
    fun pow(a: Int, b: Int): Int {
      if (b == 0) return 1
      if (b == 1) return a
      if (b < 0) throw IllegalArgumentException("power must be positive")

      val t = pow(a, b / 2)
      if (b % 2 == 0) { // b = 2c
        return t * t
      }
      return t * t * a
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun example_pow() {
  assertThat(pow(3, 3)).isEqualTo(27)
  assertThat(pow(9, 2)).isEqualTo(81)
}

@Test
fun random_pow() {
  val rand = ThreadLocalRandom.current()

  for (i in 1..100) {
    val a = rand.nextInt(1, 100)
    val b = rand.nextInt(1, 100)

    val expected = a.toDouble().pow(b.toDouble()).toLong()
    if (expected !in Int.MIN_VALUE..Int.MAX_VALUE) continue

    assertThat(pow(a, b)).isEqualTo(expected.toInt())
  }
}
```
