# Generate random numbers

## Problem

Given a RNG that emits $0$ or $1$, create a generalized random number generator for range $[a, b)$.

## Hint

??? "Expand"

    Power of two?

## Solution

??? "Approach"

    First simplify the problem. Instead of thinking $[a, b)$, think $[0, n)$.

    Next, notice that the problem is straightforward for $[0, 2^k)$. We just draw $0/1$ for all $k$ bits.

    Now for $[0, n)$, all we need to do is use the previous solution such that $n \le 2^k$. And if the drawn number is outside the range, draw the random number again.

??? "Implementation"

    ```kotlin linenums="1"
    val rand = ThreadLocalRandom.current()

    // [min, max)
    fun random(min: Int, max: Int): Int {
      val size = max - min // n
      var result: Int
      do {
        result = 0
        var i = 0
        while ((1 shl i) < size) {
          if (rand.nextBoolean()) result = result or (1 shl i)
          i++
        }
        result += min
      } while (result >= max)
      return result
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun random_gen() {
  val count = IntArray(100)
  for (i in 0..100_000) {
    val n = random(0, 100)
    count[n]++
  }

  for (i in 0..<100) {
    assertThat(count[i] in 95..105)
  }
}
```
