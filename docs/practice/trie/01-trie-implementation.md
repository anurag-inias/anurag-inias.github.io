# Basic Trie

In this section, we introduce a basic implementation of a trie, useful for algorithm and data-structure problems.

## Componenets

=== "`TrieNode`"

    Represents an individual node in `Trie`.

    ```kotlin linenums="1"
    class TrieNode(val key: String? = null) : PrintableNode {
      val branches = mutableMapOf<Char, TrieNode>()

      val type: NodeType
        get() = if (key == null) NodeType.BRANCH else NodeType.LEAF

      override fun toString(): String {
        return content()
      }

      override fun content(): String {
        if (type == NodeType.LEAF) return "l($key)"
        return "b(%s)".format(branches.keys.sorted().joinToString(separator = ", "))
      }

      override fun children(): List<PrintableNode> {
        return branches.entries.sortedBy { it.key }.map { it.value }.toList()
      }
    }
    ```

    Here `NodeType` represents the type of node, $\text{leaf}$ or $\text{branch}$.

    ```kotlin linenums="1"
    enum class NodeType {
      LEAF,
      BRANCH,
    }
    ```

=== "`Trie`"

    Encapsulates the `Trie` data structure. It will always have a _branch_ trie node at the top, called `root`.

    ```kotlin linenums="1"
    class Trie(val terminationChar: Char = '#') {

      val root = TrieNode()

      fun search(key: String): SearchResult {
        /* implementation */
      }

      fun insert(key: String) {
        /* implementation */
      }

      override fun toString(): String {
        return print(root)
      }
    }
    ```

=== "`insert`"

    ```kotlin linenums="1"
    fun insert(key: String) {
      insert(root, "$key$terminationChar", 0)
    }

    private fun insert(node: TrieNode, key: String, index: Int) : TrieNode {
      // Ended up on a leaf node. Turn this into a branch node.
      if (node.type == NodeType.LEAF) {
        var split = TrieNode()
        split = insert(split, key, index)
        split = insert(split, node.key!!, index)
        return split
      }

      val k = key[index]
      val next = node.branches[k]
      if (next == null) {
        // Jumped off Trie. So simply insert the new node at last branch.
        node.branches[k] = TrieNode(key)
      } else {
        // Continue on searching.
        node.branches[k] = insert(next, key, index + 1)
      }
      return node
    }
    ```

=== "`search`"

    ```kotlin linenums="1"
    fun search(key: String): SearchResult {
      val trueKey = "$key$terminationChar"
      var index = 0
      var pred: TrieNode? = root
      var cursor: TrieNode? = root

      while (cursor != null && cursor.type == NodeType.BRANCH && index < trueKey.length) {
        pred = cursor
        cursor = cursor.branches[trueKey[index++]]
      }
      return SearchResult(trueKey == cursor?.key, pred)
    }

    data class SearchResult(val success: Boolean = false, val parent: TrieNode? = null)
    ```

## Full implementation

```kotlin linenums="1"
import com.example.practice.treeprinter.PrintableNode
import com.example.practice.treeprinter.print

enum class NodeType {
  LEAF,
  BRANCH,
}

class TrieNode(val key: String? = null) : PrintableNode {
  val branches = mutableMapOf<Char, TrieNode>()

  val type: NodeType
    get() = if (key == null) NodeType.BRANCH else NodeType.LEAF

  override fun toString(): String {
    return content()
  }

  override fun content(): String {
    if (type == NodeType.LEAF) return "l($key)"
    return "b(%s)".format(branches.keys.sorted().joinToString(separator = ", "))
  }

  override fun children(): List<PrintableNode> {
    return branches.entries.sortedBy { it.key }.map { it.value }.toList()
  }
}

data class SearchResult(val success: Boolean = false, val parent: TrieNode? = null)

class Trie(val terminationChar: Char = '#') {

  val root = TrieNode()

  fun search(key: String): SearchResult {
    val trueKey = "$key$terminationChar"
    var index = 0
    var pred: TrieNode? = root
    var cursor: TrieNode? = root

    while (cursor != null && cursor.type == NodeType.BRANCH && index < trueKey.length) {
      pred = cursor
      cursor = cursor.branches[trueKey[index++]]
    }
    return SearchResult(trueKey == cursor?.key, pred)
  }

  fun insert(key: String) {
    insert(root, "$key$terminationChar", 0)
  }

  private fun insert(node: TrieNode, key: String, index: Int) : TrieNode {
    if (node.type == NodeType.LEAF) {
      var split = TrieNode()
      split = insert(split, key, index)
      split = insert(split, node.key!!, index)
      return split
    }
    val k = key[index]
    val next = node.branches[k]
    if (next == null) {
      node.branches[k] = TrieNode(key)
    } else {
      node.branches[k] = insert(next, key, index + 1)
    }
    return node
  }

  override fun toString(): String {
    return print(root)
  }
}
```

## Unit tests

```kotlin linenums="1"
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class TrieTest {

  private lateinit var trie: Trie

  @BeforeEach
  fun setup() {
    trie = Trie()
  }

  @Test
  fun empty() {
    assertThat(trie.toString()).isEqualTo("b()")
  }

  @Test
  fun emptySearch() {
    val result = trie.search("star")
    assertThat(result.success).isFalse()
    assertThat(result.parent?.toString()).isEqualTo("b()")
  }

  @Test
  fun singleKey() {
    trie.insert("viper")
    assertThat(trie.toString()).isEqualTo("""
      b(v)
        |
    l(viper#)
    """.trimIndent())
  }

  @Test
  fun singleKeySearch() {
    trie.insert("viper")

    var result = trie.search("vault")
    assertThat(result.success).isFalse()
    assertThat(result.parent?.toString()).isEqualTo("b(v)")

    result = trie.search("viper")
    assertThat(result.success).isTrue()
    assertThat(result.parent?.toString()).isEqualTo("b(v)")
  }

  @Test
  fun branchAtFirstCharacter() {
    trie.insert("hello")
    trie.insert("aloha")
    trie.insert("bonjour")
    assertThat(trie.toString()).isEqualTo("""
              b(a, b, h)
        +----------+----------+
    l(aloha#) l(bonjour#) l(hello#)
    """.trimIndent())
  }

  @Test
  fun branchAtSecondCharacter() {
    trie.insert("hello")
    trie.insert("aloha")
    trie.insert("hola")
    trie.insert("bonjour")
    assertThat(trie.toString()).isEqualTo("""
              b(a, b, h)
        +----------+-------------------+
    l(aloha#) l(bonjour#)           b(e, o)
                              +--------+-------+
                          l(hello#)        l(hola#)
    """.trimIndent())
  }

  @Test
  fun prefix() {
    trie.insert("react")
    trie.insert("reactivate")
    trie.insert("reactivated")
    assertThat(trie.toString()).isEqualTo("""
               b(r)
                 |
               b(e)
                 |
               b(a)
                 |
               b(c)
                 |
               b(t)
                 |
              b(#, i)
        +--------+---------------------+
    l(react#)                        b(v)
                                       |
                                     b(a)
                                       |
                                     b(t)
                                       |
                                     b(e)
                                       |
                                    b(#, d)
                            +----------+----------+
                     l(reactivate#)        l(reactivated#)
    """.trimIndent())
  }

  @Test
  fun searchPrefixes() {
    trie.insert("react")
    trie.insert("reactivate")
    trie.insert("reactivated")

    var result = trie.search("react")
    assertThat(result.success).isTrue()
    assertThat(result.parent?.toString()).isEqualTo("b(#, i)")

    result = trie.search("reactivate")
    assertThat(result.success).isTrue()
    assertThat(result.parent?.toString()).isEqualTo("b(#, d)")

    result = trie.search("reaction")
    assertThat(result.success).isFalse()
    assertThat(result.parent?.toString()).isEqualTo("b(v)")

    trie.insert("reaction")
    assertThat(trie.toString()).isEqualTo("""
               b(r)
                 |
               b(e)
                 |
               b(a)
                 |
               b(c)
                 |
               b(t)
                 |
              b(#, i)
        +--------+-------------------+
    l(react#)                     b(o, v)
                           +---------+---------------------+
                     l(reaction#)                        b(a)
                                                           |
                                                         b(t)
                                                           |
                                                         b(e)
                                                           |
                                                        b(#, d)
                                                +----------+----------+
                                         l(reactivate#)        l(reactivated#)
    """.trimIndent())

    result = trie.search("reaction")
    assertThat(result.success).isTrue()
    assertThat(result.parent?.toString()).isEqualTo("b(o, v)")
  }
}
```
