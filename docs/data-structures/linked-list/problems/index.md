# Read Me

Wherever unstated, we'll be referring to singly-linked implementation of linked lists. That's because:

- Not having \\(prev\\) reference makes these more challenging in many cases.
- Having to account for boundary conditions is half the fun.
- Restricted traversal in a single direction gets the techniques across in succinct manner.

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

### Problems

1. [ ] Turn a linked list Iterable <a target="_blank" href="/data-structures/linked-list/problems/iterable">:octicons-link-external-16:</a>
2. [ ] Reverse a linked list in-place <a target="_blank" href="/data-structures/linked-list/problems/reverse">:octicons-link-external-16:</a>
3. [ ] Create a stack from a linked list <a target="_blank" href="/data-structures/linked-list/problems/stack-as-linked-list">:octicons-link-external-16:</a>
4. [ ] Create a queue from a linked list <a target="_blank" href="/data-structures/linked-list/problems/queue-as-linked-list">:octicons-link-external-16:</a>
5. [ ] Check if two given linked lists are identical <a target="_blank" href="/data-structures/linked-list/problems/equality">:octicons-link-external-16:</a>
6. [ ] Deep copy a linked list <a target="_blank" href="/data-structures/linked-list/problems/clone">:octicons-link-external-16:</a>
7. [ ] In-place merge two sorted linked list <a target="_blank" href="/data-structures/linked-list/problems/merge">:octicons-link-external-16:</a>
8. [ ] Detect cycle a linked list <a target="_blank" href="/data-structures/linked-list/problems/cycle-detection">:octicons-link-external-16:</a>
9. [ ] Insert a node in its correct place in a sorted linked list <a target="_blank" href="/data-structures/linked-list/problems/sorted-insert">:octicons-link-external-16:</a>
10. [ ] In-place sort a linked list <a target="_blank" href="/data-structures/linked-list/problems/sorting">:octicons-link-external-16:</a>
