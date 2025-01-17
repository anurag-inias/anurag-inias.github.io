# Patterns

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
