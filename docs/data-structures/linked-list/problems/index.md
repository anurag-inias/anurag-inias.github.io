# Read Me

Wherever unstated, we'll be referring to singly-linked implementation of linked lists. That's because:

- Not having \\(prev\\) reference makes these more challenging in many cases.
- Having to account for boundary conditions is half the fun.
- Restricted traversal in a single direction gets the techniques across in succinct manner.

At times we may operate directly on the `Node` class for simplicity.

??? "Node class"

    ```kotlin
    class Node(var value: Int, var next: Node? = null) {

      constructor(vararg values: Int): this(values.first()) {
        var tail: Node? = this
        for ((i, v) in values.withIndex()) {
          if (i == 0) continue
          tail?.next = Node(v)
          tail = tail?.next
        }
      }

      override fun toString(): String {
        if (next == null) return "$value"

        val values = mutableListOf<Int>()
        var cursor: Node? = this
        while (cursor != null) {
          values.add(cursor.value)
          cursor = cursor.next
        }
        return values.toString()
      }
    }
    ```

## Common patterns

### Predecessor-cursor pair

A common requirement in linked list problems is the need to find a node through iteration, but then also having access to its predecssor so the list can be mutated.

```kotlin
var pred: Node? = null
var cursor = head

while (cursor != null && /* my condition */) {
  pred = cursor
  cursor = cursor.next
}

pred.next = /* do something */
```

while obvious, this proves helpful a too many scenarios.

<hr>

### Offset cursor with $\text{Deque}$

<div markdown class="grid">

```kotlin linenums="1" title="before"
var cursor: Node? = this

while (cursor != null) {
  cursor = cursor.next
}
```

```kotlin linenums="1" hl_lines="2 7" title="after"
val dq = ArrayDeque<Node?>()
dq.add(null) // move cursor behind by one step
dq.add(this)

while (cursor != null) {
  val c = dq.removeFirst()
  c?.next?.let { dq.add(it) }
}
```

</div>

=== "With no `dq.add(null)`"

    ```
    before = 1, after = 1
    before = 2, after = 2
    before = 3, after = 3
    before = 4, after = 4
    before = 5, after = 5
    before = 6, after = 6
    before = 7, after = 7
    before = 8, after = 8
    ```

=== "With one `dq.add(null)`"

    ```
    before = 1, after = null
    before = 2, after = 1
    before = 3, after = 2
    before = 4, after = 3
    before = 5, after = 4
    before = 6, after = 5
    before = 7, after = 6
    before = 8, after = 7
    ```

=== "With two `dq.add(null)`"

    ```
    before = 1, after = null
    before = 2, after = null
    before = 3, after = 1
    before = 4, after = 2
    before = 5, after = 3
    before = 6, after = 4
    before = 7, after = 5
    before = 8, after = 6
    ```

<hr>

### Two pointer shuffle

Out of two pointers, move the one which would get us closer to our goal. Variation of this techniques can be useful when dealing with sorted inputs.

$$
\begin{alignat}{1}
&{} \fbox 1 \rightarrow 4 \rightarrow 7 \rightarrow 10 \ \text{ since 1 < 2, move this cursor} \\
&{} \fbox 2 \rightarrow 4 \rightarrow 6 \rightarrow 8 \rightarrow 10 \\
\\
&{} 1 \rightarrow \fbox 4 \rightarrow 7 \rightarrow 10 \\
&{} \fbox 2 \rightarrow 4 \rightarrow 6 \rightarrow 8 \rightarrow 10 \ \text{ since 2 < 4, move this cursor} \\
\\
&{} \text{ match! move both cursors} \\
&{} 1 \rightarrow \fbox 4 \rightarrow 7 \rightarrow 10 \\
&{}  2 \rightarrow \fbox 4 \rightarrow 6 \rightarrow 8 \rightarrow 10 \\
\\
&{} 1 \rightarrow 4 \rightarrow \fbox 7 \rightarrow 10 \\
&{} 2 \rightarrow 4 \rightarrow \fbox 6 \rightarrow 8 \rightarrow 10 \ \text{ since 6 < 7, move this cursor} \\
\\
&{} 1 \rightarrow 4 \rightarrow \fbox 7 \rightarrow 10  \ \text{ since 7 < 8, move this cursor} \\
&{} 2 \rightarrow 4 \rightarrow 6 \rightarrow \fbox 8 \rightarrow 10 \\
\\
&{} 1 \rightarrow 4 \rightarrow 7 \rightarrow \fbox{10} \\
&{} 2 \rightarrow 4 \rightarrow 6 \rightarrow \fbox 8 \rightarrow 10 \ \text{ since 8 < 10, move this cursor} \\
\\
&{} \text{ match! move both cursors} \\
&{} 1 \rightarrow 4 \rightarrow 7 \rightarrow \fbox{10} \\
&{} 2 \rightarrow 4 \rightarrow 6 \rightarrow 8 \rightarrow \fbox{10} \\
\end{alignat}
$$

<hr>

## Problems

1. [ ] Turn a linked list Iterable <a target="_blank" href="/data-structures/linked-list/problems/turn-a-linked-list-iterable">:octicons-link-external-16:</a>
2. [ ] Reverse a linked list in-place <a target="_blank" href="/data-structures/linked-list/problems/reverse-a-linked-list-in-place">:octicons-link-external-16:</a>
3. [ ] Create a stack from a linked list <a target="_blank" href="/data-structures/linked-list/problems/create-a-stack-from-a-linked-list">:octicons-link-external-16:</a>
4. [ ] Create a queue from a linked list <a target="_blank" href="/data-structures/linked-list/problems/create-a-queue-from-a-linked-list">:octicons-link-external-16:</a>
5. [ ] Check if two given linked lists are identical <a target="_blank" href="/data-structures/linked-list/problems/check-if-two-given-linked-lists-are-identical">:octicons-link-external-16:</a>
6. [ ] Deep copy a linked list <a target="_blank" href="/data-structures/linked-list/problems/deep-copy-a-linked-list">:octicons-link-external-16:</a>
7. [ ] In-place merge two sorted linked list <a target="_blank" href="/data-structures/linked-list/problems/in-place-merge-two-sorted-linked-list">:octicons-link-external-16:</a>
8. [ ] In-place merge arbitrary number of sorted linked list <a target="_blank" href="/data-structures/linked-list/problems/in-place-merge-arbitrary-number-of-sorted-linked-list">:octicons-link-external-16:</a>
9. [ ] Detect cycle in a linked list <a target="_blank" href="/data-structures/linked-list/problems/detect-cycle-in-a-linked-list">:octicons-link-external-16:</a>
10. [ ] Insert a node in its correct place in a sorted linked list <a target="_blank" href="/data-structures/linked-list/problems/insert-a-node-in-its-correct-place-in-a-sorted-linked-list">:octicons-link-external-16:</a>
11. [ ] In-place sort a linked list <a target="_blank" href="/data-structures/linked-list/problems/in-place-sort-a-linked-list">:octicons-link-external-16:</a>
12. [ ] Split linked list in first and second halves <a target="_blank" href="/data-structures/linked-list/problems/split-linked-list-in-first-and-second-halves">:octicons-link-external-16:</a>
13. [ ] Remove duplicates from sorted linked list <a target="_blank" href="/data-structures/linked-list/problems/remove-duplicates-from-sorted-linked-list">:octicons-link-external-16:</a>
14. [ ] Intersection of two sorted linked list <a target="_blank" href="/data-structures/linked-list/problems/intersection-of-two-sorted-linked-list">:octicons-link-external-16:</a>
