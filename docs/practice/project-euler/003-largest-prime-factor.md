# Largest Prime Factor

[projecteuler.net/problem=3](https://projecteuler.net/problem=3)

What is the largest prime factor of $600851475143$.

=== "Level 1"

    ??? "Expand"

        The largest prime factor of $N$ will be $\le \lfloor \sqrt{N} \rfloor$. So we use [Sieve of Eratosthenes](/algorithms/maths/sieve-of-eratosthenes) to find all the primes in $[2, \lfloor \sqrt{N} \rfloor]$. We then iterate of these primes in reverse order and the first prime that divides $N$ is our answer.

        ```kotline
        fun largestPrimeFactor(n: Long) {
          val possibleCandidate = sqrt(n.toDouble()).toInt()
          val primes = primesTill(possibleCandidate)

          for (p in primes.reversed()) {
            if (n % p.toLong() != 0L) continue
            println(p)
            break
          }
        }
        ```
