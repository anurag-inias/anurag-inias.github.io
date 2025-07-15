# Find the maximum occurring word in a given set of strings

## Description

Given a set of words, find the most frequent word in it.

!!! info

    We are **not** asking about the majority element, one which appears more than $\dfrac{n}{2}$ times.

## Example

$\text{code}, \text{coder}, \text{coding}, \text{codable}, \text{codec},\text{codecs}, \text{coded}, \text{codeless}, \text{codec}, \text{codecs},$

$\text{codependence}, \text{codex}, \text{codify}, \text{codependents}, \text{codes}, \text{code}, \text{coder}, \text{codesign},$

$\text{codec}, \text{codeveloper}, \text{codrive}, \text{codec}, \text{codecs}, \text{codiscovered}$

The most frequent word here is $\text{codec}$.

## Stub

```kotlin linenums="1"
fun main() {
  println(
    mostFrequentWord(
      "code",
      "coder",
      "coding",
      "codable",
      "codec",
      "codecs",
      "coded",
      "codeless",
      "codec",
      "codecs",
      "codependence",
      "codex",
      "codify",
      "codependents",
      "codes",
      "code",
      "coder",
      "codesign",
      "codec",
      "codeveloper",
      "codrive",
      "codec",
      "codecs",
      "codiscovered"
    )
  )
}

fun mostFrequentWord(vararg words: String): String {
  /* Fill here */
}
```

## Solution

??? "Approach 1"

    Simply add each word in the trie and when the same word is added again, keep increasing a counter. Then traverse all leaf nodes and find the one with highest counter.

    ```kotlin linenums="1"
    fun mostFrequentWord(vararg words: String): String {
      val trie = Trie()
      for (word in words) {
        trie.insert(word)
      }
      val word = maxCount(trie.root).first
      return word.substring(0..<word.length - 1)
    }

    fun maxCount(node: TrieNode): Pair<String, Int> {
      if (node.key != null) {
        return Pair(node.key, node.count)
      }

      var count = 0
      var word = ""
      for (b in node.branches.values) {
        val (w, c) = maxCount(b)
        if (c > count) {
          count = c
          word = w
        }
      }
      return Pair(word, count)
    }
    ```

??? "Approach 2"

    Simply use a map.

    ```kotlin linenums="1"
    fun mostFrequentWord(vararg words: String): String {
      var candidateWord = ""
      var candidateCount = 0
      val counts = mutableMapOf<String, Int>()

      for (word in words) {
        var count = counts[word] ?: 0
        counts[word] = ++count

        if (count > candidateCount) {
          candidateCount = count
          candidateWord = word
        }
      }

      return candidateWord
    }
    ```
