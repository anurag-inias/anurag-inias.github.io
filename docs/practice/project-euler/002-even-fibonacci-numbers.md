# Even Fibonacci Numbers

[projecteuler.net/problem=2](https://projecteuler.net/problem=2)

Find the sum of all even terms in the Fibonacci sequence, upto and until $N$.

=== "Level 1"

    ??? "Expand"

        We only need to generate the number of the sequence and sum them if they are even.

        ```kotlin
        private fun sumEvenFibonacci(max: Int) : Int {
          if (max < 1) return 0
          if (max < 2) return 0

          var sum = 0

          var first = 1
          var second = 2
          while (second <= max) {
            if (second % 2 == 0) sum += second
            val t = second
            second = first + second
            first = t
          }

          return sum
        }

        assertThat(sumEvenFibonacci(4_000_000)).isEqualTo(4613732)
    ```

=== "Level 2"

    ??? "Expand"

        Write down the actual sequence

        $$
        1, 1, \fbox{2}, 3, 5, \fbox{8}, 13, 21, \fbox{34}, 55, 89, \fbox{144}, \dots
        $$

        notice how every third number is even. We can use this to simply skip the check for even numbers.

        ```kotlin
        private fun sumEvenFibonacci(max: Int) : Int {
          var first = 1
          var second = 1
          var third = first + second // print 1, 1, 2

          var sum = 0
          while (third <= max) {
            sum += third
            first = second + third // slide window by 3 steps instead of just 1.
            second = third + first
            third = first + second

            // print 3, 5, 8
            // print 13, 21, 34
            // print 55, 89, 144
            // ...
          }
          return sum
        }

        assertThat(sumEvenFibonacci(4_000_000)).isEqualTo(4613732)
        ```
