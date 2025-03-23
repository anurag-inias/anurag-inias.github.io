# Divide two integers without arithmetic operators

## Problem

Given two numbers, divide them with bit operations.

## First approach

??? "Hint"

    Brute force

??? "Solution"

    For $a \div b$, repeatedly subtract $b$ from $a$ until the remainder $\lt b$.

## Second approach

??? "Hint 1"

    Do more work in each iteration.

??? "Hint 2"

    $a \div b \Rightarrow a = q \cdot b + r$. Finding $q$ is not straightforward, but we can find the closest power of two such that $2^k \cdot b \le a$.

??? "Explanation"

    In each iteration, find $2^k$ such that $2^k \cdot b \le a$. Subtract this from $a$ and repeat the process.

??? "Implementation"

    ```kotlin linenums="1"
    fun divide(a: Int, b: Int): Pair<Int, Int> {
      if (b == 0) throw IllegalArgumentException("Cannot divide by zero")
      if (a < 0 && b < 0) return divide(-a, -b)
      if (b < 0) return divide(-a, -b)
      if (a < 0) {
        val p = divide(-a, b)
        return Pair(-p.first, p.second)
      }

      var quotient = 0
      var remainder = a
      var pow = 32             // (1)
      var bPowered = b shl pow

      while (remainder >= b) {
        while (bPowered > remainder) {
          bPowered = bPowered ushr 1
          pow--
        }
        quotient += (1 shl pow)
        remainder -= bPowered
      }

      return Pair(quotient, remainder)
    }
    ```

    1. We could start with $b << 0$ and keep shifting it right until it becomes larger than what's remaining of $a$. Instead we start as high as possible and then come down, saving time in next iterations.

### Unit tests

```kotlin linenums="1"
@Test
fun example_divide() {
  assertThat(divide(4, 2)).isEqualTo(Pair(2, 0))
  assertThat(divide(5, 2)).isEqualTo(Pair(2, 1))
  assertThat(divide(51, 17)).isEqualTo(Pair(3, 0))
  assertThat(divide(51, 3)).isEqualTo(Pair(17, 0))
  assertThat(divide(51, 50)).isEqualTo(Pair(1, 1))
  assertThat(divide(45, 2)).isEqualTo(Pair(22, 1))
  assertThat(divide(-45, 2)).isEqualTo(Pair(-22, 1))
  assertThat(divide(45, -2)).isEqualTo(Pair(-22, 1))
  assertThat(divide(-45, -2)).isEqualTo(Pair(22, 1))
}

@Test
fun random_divide() {
  val rand = ThreadLocalRandom.current()

  for (i in 1..100) {
    val a = rand.nextInt(-1000, 1000)
    val b = rand.nextInt(-1000, 1000)


    assertThat(divide(a, b).first).isEqualTo(a / b)
    assertThat(divide(a, b).second).isEqualTo(abs(a % b))
  }
}
```
