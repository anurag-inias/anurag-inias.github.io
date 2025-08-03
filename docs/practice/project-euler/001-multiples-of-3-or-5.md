# Multiples of 3 or 5

[projecteuler.net/problem=1](https://projecteuler.net/problem=1)

Given a number $N$, find the sum of all the numbers $n$ divisible by either $3$ or $5$ such that $n \le N$.

=== "Naive solution"

    ??? "Expand"

        $O(N)$

        ```
        sum = 0
        for n in 1..N:
          if n % 3 == 0 OR n % 5 == 0:
            sum += n
        ```

        Solution above works fine. However, we end up iterative over all the numbers in $[1, N]$. Why even process $2, 4, 6, \dots$?

=== "Next level"

    ??? "Expand"

        We can simply process the elements we know would be in the sum. i.e. For loop with a `step`.

        ```
        sum = 0

        for n in 1..N step 5:
          sum += 5

        for n in 1..N step 3:
          if n % 5 == 0:       // don't count multiples of 5 twice.
            continue
          sum += 3
        ```

        This too is $O(N)$, but we saved some constant factor time.

=== "Final"

    ??? "Expand"

        ```
        solution = sum3 + sum5 - sum15
        ```

        where

        ```
        sum3 = 3 + 6 + 9 + ...
        sum5 = 5 + 10 + 15 + ...
        sum15 = 15 + 30 + 45 + ...
        ```

        we know that sum of first $n$ natural numbers has a closed form formular $n \times \dfrac{n + 1}{2}$. This comes from $\text{sequence length} \times \text{sequence average}$. From this we can gather that.

        ```
        sum3 = 3 + 6 + 9 + ... + 999
             = 3 (1 + 2 + 3 + ... + 333)
        ```

        Thus the full solution is

        ```kotlin
        private fun Int.sequenceSum(): Int {
          return this * (this + 1) / 2
        }

        private fun multipleOf3Or5(range: Int) : Int {
          val sum3 = (range / 3).sequenceSum() * 3
          val sum5 = (range / 5).sequenceSum() * 5
          val sum15 = (range / 15).sequenceSum() * 15
          return sum3 + sum5 - sum15
        }
        ```
