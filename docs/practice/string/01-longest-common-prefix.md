# Longest Common Prefix

## Problem

Given a list of strings, find the longest string that's prefix to them all.

## Example

$$
\begin{alignat}{1}
S_1 &= \fbox{fl}\ \text{ower} \\
S_2 &= \fbox{fl}\ \text{ow} \\
S_3 &= \fbox{fl}\ \text{ight} \\
\end{alignat}
$$

## First Solution

??? "Hint"

    The solution is straighforward, no tricks. But there is an optimization to cut down the problem at hand significantly.

??? "Pseudocode"

    Vertical scanning, that is:

    - Check the first character of all strings.
    - then, check the second character of all strings.
    - $\dots$
    - then, check the $i^{th}$ character of all strings.

    if the check fails at $i^{th}$ character for any string, then our longest common substring is the substring before that. That is, `any_of_the_strings[0:i]`.

??? "Implementation"

    ```kotlin linenums="1"
    fun longestCommonPrefix(strs: Array<String>): String {
      if (strs.isEmpty()) return ""
      if (strs.size == 1) return strs.first()

      // There are 2 or more strings to consider now.

      var cursor = 0
      while (cursor < strs.first().length) {
        val char = strs.first()[cursor]
        for (i in strs.indices) {
          if (cursor >= strs[i].length || strs[i][cursor] != char) {
            return strs.first().substring(0, cursor)
          }
        }
        cursor++
      }

      return strs.first()
    }
    ```

??? "Runtime"

    In worst case, we can assume all strings to be $d$ character long, only deviating at the very last character. That means each comparison is $c\cdot d$ work. For all $n$ strings, that's $c\cdot d \cdot n$ work, which is $O(n)$.

## Second Solution

??? "Hint"

    Use a Trie.

??? "Pseudocode"

    Insert all words into a Trie. Now traverse the trie from the root downwards. The first branch we hit is where the longest common prefix ends.

??? "Implementation"

    ```kotlin linenums="1"
    fun longestCommonPrefix(words: Array<String>): String {
      val root = TrieNode()
      for (word in words) {
        root.insert("$word#")
      }

      var cursor = root
      val path = StringBuilder()
      while (true) {
        if (cursor.isLeaf) return cursor.key!!
        if (cursor.branches.size != 1) break
        path.append(cursor.branches.keys.first())
        cursor = cursor.branches.values.first()
      }
      return path.toString()
    }

    data class TrieNode(
      var key: String? = null,
    ) {
      val isLeaf: Boolean
        get() = key != null

      val branches = mutableMapOf<Char, TrieNode>()

      fun insert(word: String, index: Int = 0) {
        val node = branches[word[index]]
        if (node == null) {
          branches[word[index]] = TrieNode(key = word)
          return
        }
        if (node.isLeaf) { // -> leaf => -> branch -> leaf1, leaf2
          branches[word[index]] = TrieNode()
          branches[word[index]]!!.insert(word, index + 1)
          branches[word[index]]!!.insert(node.key!!, index + 1)
          node.key = null
          return
        }
        node.insert(word, index + 1)
      }
    }
    ```

## Third Solution

??? "Hint 1"

    Do you actually need to check all strings?

??? "Hint 2"

    Would sorting help?

??? "Hint 3"

    What do we get out of sorting? is that needed?

??? "Pseudocode"

    Checking two strings which share a large prefix is wasteful work if some string down the line will have mismatches right away at index $1$. If we can find this worst match right away, we find longest common prefix without actually having to scan all strings.

    In the example below, we'd like to compare $S_1$ against $S_3$, and not $S_2$. That's because $S_3$ deviates from $S_1$ at the earliest.

    $$
    \begin{alignat}{1}
    S_1 &= aab \\
    S_2 &= aac \\
    S_3 &= ab \\
    \end{alignat}
    $$

    That is, we need to consider the lexical (dictionary) ordering of given strings and compare the very `first` string against the very `last` string. All strings prior to `last` will share longer and longer prefixes with `first`, with `second` string sharing the longest prefix with `first`.

    Note that this doesn't require sorting all the strings, only finding the `first` and `last`, i.e. `min` and `max` of given strings.

??? "Implementation Kotlin"

    ```kotlin linenums="1"
    fun longestCommonPrefix(strs: Array<String>): String {
      var first = strs[0]
      var last = strs[0]
      for (s in strs) {
        if(s < first) first = s
        if(s > last) last = s
      }
      val length = min(first.length, last.length)
      var c = 0
      while (c < length) {
        if (first[c] != last[c]) break
        c++
      }
      return first.substring(0, c)
    }
    ```

??? "Implementation C"

    ```C linenums="1"
    // Sorts strings by "natural" order.
    int compare(char *first, char *second) {
      int cursor = 0;
      while (first[cursor] != '\0' && second[cursor] != '\0') {
        if (first[cursor] == second[cursor]) {
          cursor++;
          continue;
        }
        if (first[cursor] < second[cursor]) {
          return -1;
        }
        return 1;
      }
      if (first[cursor] == '\0' && second[cursor] == '\0') {
        return 0;
      }
      if (first[cursor] == '\0') {
        return -1;
      }
      return 1;
    }

    // Finds the indices of min and max strings.
    void firstAndLast(char **strs, int strsSize, int *min, int *max) {
      for (int i = 1; i < strsSize; i++) {
        if (compare(strs[i], strs[*min]) == -1) {
          *min = i;
        }
        if (compare(strs[i], strs[*max]) == 1) {
          *max = i;
        }
      }
    }

    // Finds the shared prefix between the first and last strings
    // as per lexical ordering.
    char *longestCommonPrefix(char **strs, int strsSize) {
      int min = 0;
      int max = 0;
      firstAndLast(strs, strsSize, &min, &max);

      int c = 0;
      while (strs[min][c] != '\0' && strs[max][c] != '\0') {
        if (strs[min][c] != strs[max][c]) {
          strs[min][c] = '\0';
          break;
        }
        c++;
      }
      return strs[min];
    }
    ```

??? "Runtime"

    Same runtime as before, but this time we are cutting down significant time in the constant factors.

## Unit tests

```kotlin linenums="1"
@Test
fun example_1() {
  assertThat(longestCommonPrefix(arrayOf("flower","flow","flight"))).isEqualTo("fl")
}

@Test
fun example_2() {
  assertThat(longestCommonPrefix(arrayOf("dog","racecar","car"))).isEqualTo("")
}

@Test
fun example_3() {
  assertThat(longestCommonPrefix(arrayOf("aa","a"))).isEqualTo("a")
}

@Test
fun example_4() {
  assertThat(longestCommonPrefix(arrayOf("a","b"))).isEqualTo("")
}
```
