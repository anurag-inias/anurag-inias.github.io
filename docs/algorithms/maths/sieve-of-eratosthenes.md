# Sieve of Eratosthenes

```kotlin
fun primesTill(n: Int): List<Int> {
  if (n < 5) return listOf(2, 3)

  // Create an array [0, 1, ..., n].
  // Initially mark them all prime.
  val candidate = BooleanArray(n + 1){ true }
  candidate[0] = false
  candidate[1] = false

  // Pick a prime at the start of the array and
  // mark its multiples as non-primes.
  var start = 2
  while (start < candidate.size) {
    if (candidate[start]) { // is prime
      punchMultiples(start, candidate)
    }
    start++
  }

  return candidate.mapIndexed { n, prime -> if (prime) n else null }.filterNotNull()
}

private fun punchMultiples(prime: Int, array: BooleanArray) {
  for (i in (2 * prime)..<array.size step prime) {
    array[i] = false
  }
}
```
