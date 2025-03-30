## Closest integer with same number of set bits

## Problem

Given an integer $n$, where $n \ne 0, -1$ (all $0s$ or $1s$), find the closest integer to it with same number of set bits.

## Example

- $1011 \rightarrow 1101$
- $1010 \rightarrow 1001$

## Hint

??? "Expand"

    There are two scenarios.

??? "Expand"

    Find the mask for both scenarios.

## Solution

??? "Principle"

    Find the rightmost consecutive bits that differ. That is $aaa0111 \rightarrow aaa1011$ and $aaa1000 \rightarrow aaa0100$

??? "Pseudocode"

    When the number doesn't terminate in $1s$.
    ```
                    x = aaa100
           m = x & -x = 000100 // mask of rightmost set bit
    m = m | (m >>> 1) = 000110 // mask to flip the target bit and the one on its right
                x ^ m = aaa010
    ```

    when the number terminates in $1s$.
    ```
                    x = aaa0111
                x + 1 = aaa1000
      m = x & (x + 1) = aaa0000 // unset trailing 1s in a number
      m = m ^ (x + 1) = 0001000 // Get mask for rightmost unset bit.
    m = m | (m >>> 1) = 0001100 // mask to flip the target bit and the one on its right
    ```

??? "Implementation"

    ```kotlin linenums="1"
    fun closestIntSameBitCount(x: Int): Int {
      var mask = x and -x // mask of rightmost set bit: 0001000

      if ((mask and 1) == 0) {
        mask = mask or (mask ushr 1) // 0001100
      } else {
        mask = x and (x + 1) // aaa0111 -> aaa0000
        mask = mask xor (x + 1) // 0001000
        mask = mask or (mask ushr 1)
      }
      return x xor mask
    }
    ```

## Unit tests

```kotlin linenums="1"
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import java.util.concurrent.ThreadLocalRandom

class ClosestIntSameBitCountKtTest {
  @Test
  fun example_1() {
    assertThat(closestIntSameBitCount(0b10)).isEqualTo(0b01)
    assertThat(closestIntSameBitCount(0b1)).isEqualTo(0b10)

    assertThat(closestIntSameBitCount(0b1011100)).isEqualTo(0b1011010)
    assertThat(closestIntSameBitCount(0b10111)).isEqualTo(0b11011)
  }

  @Test
  fun random() {
    val rand = ThreadLocalRandom.current()

    for (i in 1..100) {
      val n = rand.nextInt(1, Int.MAX_VALUE - 1)

      assertThat(closestIntSameBitCount(n)).isEqualTo(n.bruteForceClosestInteger())
    }
  }

  private fun Int.bruteForceClosestInteger(): Int {
    val count = setBits()

    var floor: Int? = null
    var n = this - 1
    while (n > 0) {
      if (n.setBits() == count) {
        floor = n
        break
      }
      n--
    }

    var ceil: Int? = null
    n = this + 1
    while (n != Int.MAX_VALUE) {
      if (n.setBits() == count) {
        ceil = n
        break
      }
      n++
    }

    return when {
      floor == null && ceil == null -> throw IllegalArgumentException()
      floor == null -> ceil!!
      ceil == null -> floor
      else -> if (this - floor < ceil - this) floor else ceil
    }
  }

  private fun Int.setBits(): Int {
    var c = 0
    var n = this
    while (n != 0) {
      c++
      n = n and (n - 1)
    }
    return c
  }
}
```
