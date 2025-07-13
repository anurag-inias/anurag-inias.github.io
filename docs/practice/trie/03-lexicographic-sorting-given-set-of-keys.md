# Lexicographic sorting of a given set of keys

## Description

Given a set of strings, return them sorted in lexicographic order.

## Example

$\text{flower}, \text{flight}, \text{flow} \rightarrow \text{flight}, \text{flow}, \text{flower}$

## Stub

```kotlin linenums="1" hl_lines="22"
fun main() {
  println(sortWords(words("flower flight flow")))
  println(
    sortWords(
      words(
        """
    lexicographic sorting of a set of keys can be accomplished with a simple trie
    based algorithm we insert all keys in a trie output all keys in the trie by means
    of preorder traversal which results in output that is in lexicographically increasing
    order preorder traversal is a kind of depth first traversal
  """.trimIndent()
      )
    )
  )
}

fun words(line: String): List<String> {
  return line.split(' ').map { it.trim() }.filter { it.length > 1 }
}

fun sortWords(words: List<String>): List<String> {
  /* Fill here */
}
```

## Solution

??? "Expand"

    Insert all words in Trie. Then list all leaf nodes.


    ```kotlin linenums="1"
    fun sortWords(words: List<String>): List<String> {
      val trie = Trie()
      for (word in words) {
        trie.insert(word)
      }

      val sorted = mutableListOf<String>()
      addLeaves(trie.root, sorted)
      return sorted
    }

    fun addLeaves(node: TrieNode, sorted: MutableList<String>) {
      if (node.type == NodeType.LEAF) {
        val word = node.key!!
        sorted.add(word.substring(0..<word.length - 1))
        return
      }
      node.branches.entries.sortedBy { it.key }.forEach { addLeaves(it.value, sorted) }
    }
    ```

    ```
    [flight, flow, flower]
    [
      accomplished, algorithm, all, based, be, by, can, depth, first, in,
      increasing, insert, is, keys, kind, lexicographic, lexicographically,
      means, of, order, output, preorder, results, set, simple, sorting,
      that, the, traversal, trie, we, which, with
    ]
    ```
