# Shortest Superstring

## Problem

Given a list of strings, find the shortest string that will contain all given strings.

## Example

- Shortest superstring of $\text{aa}$ and $\text{bb}$ will be $\text{aabb}$ or $\text{bbaa}$. i.e. concatenation of the two.
- Shortest superstring of $\text{aaxxx}$ and $\text{axxx}$ will be $\text{aaxxx}$. i.e. the first string.
- Shortest superstring of $\text{aaxxx}$ and $\text{xxxbb}$ will be $\text{aaxxxbb}$.

## Hint

??? "Expand"

    Problem is NP-Hard. We can get a *near-optimal* solution though.

## Solution

??? "High-level overview"

    From the examples above it should be clear that we are interested in _"overlap"_ between two strings. That is, one string's suffix is another strings is prefix. We want to combine strings having longest such overlap.

    There are two greedy algorithm aspects here. First, we want to combine strings of similar length. Combining a very long string and a very short one doesn't give us too much in "saving". Instead if two strings of similar length, if they have an overlap, would save us most characters.

    Second, we priortize combining strings with most overlap. This obviously is not optimal. We can make a worse match-up that may have large overlap later down the line.

??? "Pseudocode"

    - Add all strings to a bag.
    - Sort that bag by string lengths. (greedy aspect 1).
    - while the bag has $2$ or more strings:

          - pop $first$ string.
          - from all the remaining strings, find one that has the most overlap with $first$, call it $second$. (greedy aspect 2).
          - if no such $second$ found, just pop $second$ from the bag (next shortest string).
          - push $first + second$ while taking care to not repeat the overlapping substring.

    - the remaining string in the bag is superstring.

??? "Implementation - Helper"

    ```kotlin linenums="1"
    // Finds the overlap between two strings.
    // e.g. aaxxx.endsWith(xxxbb) = 3
    //            aa.endsWith(bb) = 0
    fun CharSequence.endsWith(other: CharSequence): Int {
      var start = 0
      while (start < length) {

        var i = start
        var j = 0
        while (i < length && j < other.length) {
          if (this[i] != other[j]) break
          i++
          j++
        }

        if (i < length) {
          start++
        } else {
          return length - start
        }
      }

      return 0
    }

    // Unit tests.
    @Test
    fun endsWith_same() {
      assertThat("aaxxx".endsWith("xxxbb")).isEqualTo(3)
      assertThat("aaxxx".endsWith("axxxbb")).isEqualTo(4)
      assertThat("aaxxx".endsWith("aaxxxbb")).isEqualTo(5)
      assertThat("aaxxx".endsWith("baaxxx")).isEqualTo(0)
      assertThat("baaxxx".endsWith("aaxxx")).isEqualTo(5)
      assertThat("cdef".endsWith("de")).isEqualTo(0)
    }
    ```

??? "Implementation - Core"

    ```kotlin linenums="1"
    import com.example.tree.PrintableNode
    import com.example.tree.print

    class TextNode(val key: String, var left: TextNode? = null, var right: TextNode? = null) : PrintableNode {
      override fun content(): String = key

      override fun children(): List<PrintableNode> {
        val children = mutableListOf<TextNode>()
        if (left != null) children.add(left!!)
        if (right != null) children.add(right!!)
        return children
      }

      override fun toString(): String {
        return print(this)
      }
    }

    fun generateSuperString(vararg strings: String): TextNode {
      // Add all strings to a bag.
      val bag = ArrayList<TextNode>()
      for (string in strings) bag.add(TextNode(string))
      // Sort bag in ascending string lengths.
      bag.sortWith{ a, b -> a.key.length - b.key.length }

      while (bag.size > 1) {
        // pop shortest available string in the bag.
        var first = bag.first()
        bag.remove(first)

        var longestMatch = 0
        var second: TextNode? = null
        var swap = false
        for (s in bag) {
          // See if suffix of `first` is prefix of `second`.
          var matchLength = first.key.endsWith(s.key)
          if (matchLength > longestMatch) {
            longestMatch = matchLength
            second = s
            swap = false
          }

          // See if prefix of `first` is suffix of `second`.
          matchLength = s.key.endsWith(first.key)
          if (matchLength > longestMatch) {
            longestMatch = matchLength
            second = s
            // remember this so we can swap first and second later
            swap = true
          }
        }

        // We found no string overlapping with `first`. Pop the next shortest string for a plain concatenation.
        if (second == null) {
          second = bag.first()
          bag.remove(second)
          val combined = TextNode(first.key + second.key, first, second)
          bag.add(combined)
        } else {
          bag.remove(second)
          if (swap) {
            val temp = first
            first = second
            second = temp
          }
          // Some overlap between `first` and `second` was found.
          val combined = TextNode(first.key + second.key.substring(longestMatch), first, second)
          bag.add(combined)
        }
      }
      return bag.first()
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun generateSuperString_simple() {
  assertThat(generateSuperString("aaab", "abyz").toString()).isEqualTo("""
        aaabyz
    +-----+----+
  aaab       abyz
  """.trimIndent())
  assertThat(generateSuperString("aa", "bb").toString()).isEqualTo("""
      aabb
    +---+--+
  aa     bb
  """.trimIndent())
}

@Test
fun generateSuperString_example_1() {
  assertThat(generateSuperString("CATGC", "CTAAGT", "GCTA", "TTCA", "ATGCATC").toString()).isEqualTo("""
                      GCTAAGTTCATGCATC
          +------------------+------------------------------+
        GCTAAGT                                         TTCATGCATC
    +-----+------+                           +--------------+-------+
  GCTA        CTAAGT                      TTCATGC                ATGCATC
                                        +-----+-----+
                                      TTCA        CATGC
  """.trimIndent())
}

@Test
fun generateSuperString_example_2() {
  assertThat(generateSuperString("abcd", "cdef", "fgh", "de").toString()).isEqualTo("""
                abcdefgh
          +---------+-----------+
        abcde                cdefgh
    +----+---+           +-----+---+
  abcd      de         cdef       fgh
  """.trimIndent())
}

@Test
fun generateSuperString_example_3() {
  assertThat(generateSuperString("aaxxx", "xxxbb").toString()).isEqualTo("""
        aaxxxbb
    +------+-----+
  aaxxx        xxxbb
  """.trimIndent())
}
```
