# Check if the content of a linked list is a palindrome

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

## Problem

Given a linked list, see if its content form a palindrome.

$$
\begin{alignat}{1}
1 \rightarrow 2  \rightarrow 2 \rightarrow 1 & \text{ (palindrome)} \\
1 \rightarrow 2  \rightarrow 3 \rightarrow 1 & \text{ (not a palindrome)}
\end{alignat}
$$

## Hint

There are multiple approaches to this problem.

??? "Expand"

    Consider leveraging _recursion_ and the implicit stack it generates.

## Solution

??? "Expand"

    ```kotlin linenums="1"
    fun isPalindrome(head: Node?): Boolean {
      if (head?.next == null) return true

      val topdown = StringBuilder()  // Populate this winding-down the recursion stack
      val bottomup = StringBuilder()
      visit(head, topdown, bottomup) // Populate this winding-out the recursion stack
      return topdown.toString() == bottomup.toString()
    }

    private fun visit(node: Node?, topdown: StringBuilder, bottomup: StringBuilder) {
      if (node == null) {
        return
      }
      topdown.append(node.value)
      visit(node.next, there, back)
      bottomup.append(node.value)
    }
    ```

    $$
    \begin{alignat}{1}
    \fbox 1 \rightarrow & 2 \rightarrow 3 \\
    topdown = [1] &{} \ bottomup = [] \\
    \\
    1 \rightarrow & \fbox 2 \rightarrow 3 \\
    topdown = [1, 2] &{} \ bottomup = [] \\
    \\
    1 \rightarrow & 2 \rightarrow \fbox 3 \\
    topdown = [1, 2, 3] &{} \ bottomup = [] \\
    \\
    1 \rightarrow & 2 \rightarrow \fbox 3 \\
    topdown = [1, 2, 3] &{} \ bottomup = [3] \\
    \\
    1 \rightarrow & \fbox 2 \rightarrow 3 \\
    topdown = [1, 2, 3] &{} \ bottomup = [3, 2] \\
    \\
    \fbox 1 \rightarrow & 2 \rightarrow 3 \\
    topdown = [1, 2, 3] &{} \ bottomup = [3, 2, 1] \\
    \\
    \end{alignat}
    $$
