# Rod cutting

<style>
.md-logo img {
  content: url('/algorithms/dynamic-programming/logo-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/dynamic-programming/logo-dark.png');
}
</style>

## Problem

We are given a steel rod to cut into pieces. The cut itself is free; we can make one cut or no cut or as many as possible. The goal is to maximize the profit from selling the pieces for the price of a piece differs by length.

| length | price |
| ------ | ----- |
| 1      | 1     |
| 2      | 5     |
| 3      | 8     |
| 4      | 9     |
| 5      | 10    |
| 6      | 17    |
| 7      | 17    |
| 8      | 20    |
| 9      | 24    |
| 10     | 30    |

## An educated guess

an immediate reaction is to factor in _rates_ to help find a solution.

| length | price | rates ($ per m) |
| ------ | ----- | --------------- |
| 1      | 1     | $1$             |
| 2      | 5     | $2\frac{1}{2}$  |
| 3      | 8     | $2\frac{2}{3}$  |
| 4      | 9     | $2\frac{1}{4}$  |
| 5      | 10    | $2$             |
| 6      | 17    | $2\frac{5}{6}$  |
| 7      | 17    | $2\frac{3}{7}$  |
| 8      | 20    | $2\frac{1}{2}$  |
| 9      | 24    | $2\frac{2}{3}$  |
| 10     | 30    | $3$             |

we then sort cuts by descending rates.

| length | price | rates ($ per m) |
| ------ | ----- | --------------- |
| 10     | 30    | $3$             |
| 6      | 17    | $2\frac{5}{6}$  |
| 3,9    | 8,24  | $2\frac{2}{3}$  |
| 2,8    | 5,20  | $2\frac{1}{2}$  |
| 7      | 17    | $2\frac{3}{7}$  |
| 4      | 9     | $2\frac{1}{4}$  |
| 5      | 10    | $2$             |
| 1      | 1     | $1$             |

use the above as a lookup table to find the optimal cut.

| length | cut | optimal price | correct ?            |
| ------ | --- | ------------- | -------------------- |
| 10     | 10  | 30            | yes                  |
| 9      | 6,3 | 17+8=25       | yes                  |
| 8      | 6,2 | 17+5=22       | yes                  |
| 7      | 6,1 | 17+1=18       | yes                  |
| 6      | 6   | 17            | yes                  |
| 5      | 3,2 | 8+5=13        | yes                  |
| 4      | 3,1 | 8+1=9         | no! it's 2+2 for $10 |
| 3      | 3   | 8             | yes                  |
| 2      | 5   | 5             | yes                  |
| 1      | 1   | 1             | yes                  |

!!! warning

    Above was an example of a reasonable assumption that led us astray. If you are going to try a greedy approach, **ALWAYS** **ALWAYS** work out several examples before committing.

## What went wrong

The fault in our thought process can often only be made clear by concrete examples. Here we can see that our approach of making the most greedy choice, i.e. picking the highest rate cuts, worked well for long.

But as we can see with $4m$ rod example, the correct answer was picking a worse option for the first cut only to make up for it and more in the next.

## Greedy is still viable

As we'll show later, an actual correct answer with DP will be $O(n^2)$ in time complexity and $O(n)$ in space complexity. Our greedy approach outperforms it with $O(n \log n)$ time and $O(1)$ space complexity (we can actually skip the rates table).

In real world, a solution that's 99% times correct may be desirable than a 100% correct one depending on the economics.

## Solution

??? "Expand"

    ```kotlin linenums="1"
    private val defaultMap = mapOf(
      1 to 1,
      2 to 5,
      3 to 8,
      4 to 9,
      5 to 10,
      6 to 17,
      7 to 17,
      8 to 20,
      9 to 24,
      10 to 30,
    )

    // Return the maximum we can earn from cutting a rod of given length
    fun optimalCut(
      length: Int,
      priceMap: Map<Int, Int> = defaultMap
    ): List<Int> {
      val price = IntArray(length + 1) // memoize the price
      val cut = HashMap<Int, List<Int>>()   // memoize the actual cut

      // Start price as 0 for yet un-calculated cuts.
      // For the cuts in our price table, consider their starting price
      // same their value in the table.
      priceMap.forEach{
        if (it.key > length) return@forEach  // don't memoize larger cuts if not needed
        price[it.key] = it.value
        cut[it.key] = listOf(it.key)
      }

      // Split the rod in two [0, l) [l, length).
      for (l in 2..length) {
        var m = price[l] // max price of this cut. either 0 or the value from the price table.
        var optimal = cut.getOrDefault(l, listOf()) // fallback to no cuts for base case.
        for (split in 1..l) {
          // Since we are working bottom-up, this is safe.
          // Because the best price for both `split` and `l - split` cuts will be calculated by now.
          val c = price[split] + price[l - split]
          if (c > m) {
            m = c
            optimal = mutableListOf<Int>() +
                cut.getOrDefault(split, listOf()) +
                cut.getOrDefault(l - split, listOf())
          }
        }
        price[l] = m
        cut[l] = optimal
      }

      return cut[length]!!
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun simple() {
  assertThat(optimalCut(1)).isEqualTo(listOf(1))
  assertThat(optimalCut(2)).isEqualTo(listOf(2))
  assertThat(optimalCut(3)).isEqualTo(listOf(3))
  assertThat(optimalCut(4)).isEqualTo(listOf(2, 2))
  assertThat(optimalCut(5)).isEqualTo(listOf(2, 3))
  assertThat(optimalCut(6)).isEqualTo(listOf(6))
  assertThat(optimalCut(7)).isEqualTo(listOf(1, 6))
  assertThat(optimalCut(8)).isEqualTo(listOf(2, 6))
  assertThat(optimalCut(9)).isEqualTo(listOf(3, 6))
  assertThat(optimalCut(10)).isEqualTo(listOf(10))
}
```
