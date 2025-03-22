# Add two integers without arithmetic operators

## Problem

Given two numbers, add them with bit operations.

## Solution

??? "Notes"

    $a + b + carry$, then the $carry$ will be non-zero if out of these three, at least two are non-zero. And the sum will be $\oplus$ of the three.

??? "Expand"

    ```kotlin linenums="1"
    fun add(a: Int, b: Int): Int {
      var result = 0

      var x = a
      var y = b
      var m = 1 // mask
      var c = 0 // carry

      while (x != 0 || y != 0 || c != 0) {
        val ma = a and m
        val mb = b and m
        result = result or (ma xor mb xor c)
        c = (ma and mb) or (ma and c) or (mb and c) // at least 2 out of 3 aren't 0

        c = c shl 1
        m = m shl 1
        x = x ushr 1
        y = y ushr 1
      }

      return result
    }
    ```

### Unit tests

```kotlin linenums="1"
@Test
fun example_add() {
  assertThat(add(0b111, 0b101)).isEqualTo(0b1100)
  assertThat(add(19, 17)).isEqualTo(36)
}

@Test
fun random_add() {
  val rand = ThreadLocalRandom.current()

  for (i in 1..100) {
    val a = rand.nextInt()
    val b = rand.nextInt()

    assertThat(add(a, b)).isEqualTo(a + b)
  }
}
```
