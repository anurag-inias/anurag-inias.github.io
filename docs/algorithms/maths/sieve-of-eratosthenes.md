# Sieve of Eratosthenes

## Pseudocode

1. Create a list of integers $2, 3, \dots, n$.
2. Initially let $c = 2$ be the smallest prime.
3. Mark all multiples of $c$, as non-primes.
4. Find the smallest number in the list $p > c$ that is not marked.
5. $c = p$ go back to step 3.

## Implementation

```kotlin
fun primesTill(n: Int): List<Int> {
  if (n < 2) return emptyList()

  val prime = BooleanArray(n + 1){ true }
  prime[0] = false
  prime[1] = false

  var start = 2
  while (start < prime.size) {
    if (prime[start]) {
      markMultiples(start, prime)
    }
    start++
  }

  return prime.mapIndexed { n, prime -> if (prime) n else null }.filterNotNull()
}

private fun markMultiples(prime: Int, array: BooleanArray) {
  for (i in (2 * prime)..<array.size step prime) {
    array[i] = false
  }
}
```

## Unit tests

```kotlin
@Test
fun simple() {
  assertThat(primesTill(0)).isEmpty()
  assertThat(primesTill(1)).isEmpty()
  assertThat(primesTill(2)).containsExactly(2)
  assertThat(primesTill(3)).containsExactly(2, 3)
  assertThat(primesTill(4)).containsExactly(2, 3)
  assertThat(primesTill(5)).containsExactly(2, 3, 5)
  assertThat(primesTill(6)).containsExactly(2, 3, 5)
  assertThat(primesTill(7)).containsExactly(2, 3, 5, 7)
  assertThat(primesTill(8)).containsExactly(2, 3, 5, 7)
  assertThat(primesTill(9)).containsExactly(2, 3, 5, 7)
  assertThat(primesTill(10)).containsExactly(2, 3, 5, 7)
  assertThat(primesTill(11)).containsExactly(2, 3, 5, 7, 11)
  assertThat(primesTill(100)).containsExactly(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97)
}
```
