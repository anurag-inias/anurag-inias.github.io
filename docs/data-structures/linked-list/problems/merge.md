# Merge linked lists

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

## Problem

In-place merge two sorted linked list such that the resultant linked list is sorted too.

## Hint

??? "First hint"

    Run two cursors, one on each linked list. Snip the smallest node from its parent linked list and move to the resultant linked list.

??? "Pseudocode"

    1. Set up head for merged list
    2. Merge until either list exhausts.
    3. No need to loop here, we can just link the remaining list.
    4. We don't need to find the `tail` of the remaining list. It'll be the `prev` of original sentinel.
    5. Doing the same work as line 22 and 25.
    6. Stitch the two ends of new list.
    7. Leave the ingested list empty.

## Solution

??? "Expand"

    ```python
    def sorted_ingest(self, other: 'LinkedList'):
        if self is other:
            return

        new_sentinel = Node(0) # (1)!
        cursor = new_sentinel

        cursor_self = self._sentinel.next
        cursor_other = other._sentinel.next

        while cursor_self is not self._sentinel and cursor_other is not other._sentinel: # (2)!
            if cursor_self.value <= cursor_other.value:
                cursor.next = cursor_self
                cursor_self = cursor_self.next
            else:
                cursor.next = cursor_other
                cursor_other = cursor_other.next
            cursor = cursor.next

        if cursor_self is not self._sentinel:
            cursor.next = cursor_self # (3)!
            new_sentinel.prev = self._sentinel.prev # (4)!
        elif cursor_other is not other._sentinel:
            cursor.next = cursor_other
            new_sentinel.prev = other._sentinel.prev
        else:
            new_sentinel.prev = cursor # (5)!

        self._sentinel = new_sentinel # (6)!
        other._sentinel.next = other._sentinel # (7)!
    ```

## Unit tests

```python linenums="1"
def test_merge_empty():
    a = LinkedList()
    b = LinkedList()
    a.sorted_ingest(b)

    assert str(a) == "[]"
    assert b.empty


def test_merge_empty_in_single():
    a = LinkedList()
    a.append(1)
    b = LinkedList()
    a.sorted_ingest(b)

    assert str(a) == "[1]"
    assert b.empty


def test_merge_single_in_empty():
    a = LinkedList()
    b = LinkedList()
    b.append(1)
    a.sorted_ingest(b)

    assert str(a) == "[1]"
    assert b.empty


def test_merge_is_append():
    a = LinkedList()
    a.append(1)
    a.append(2)
    a.append(3)
    b = LinkedList()
    b.append(4)
    b.append(5)
    b.append(6)
    a.sorted_ingest(b)

    assert str(a) == "[1, 2, 3, 4, 5, 6]"
    assert b.empty


def test_merge_is_prepend():
    a = LinkedList()
    a.append(1)
    a.append(2)
    a.append(3)
    b = LinkedList()
    b.append(4)
    b.append(5)
    b.append(6)
    b.sorted_ingest(a)

    assert str(b) == "[1, 2, 3, 4, 5, 6]"
    assert a.empty


def test_merge_is_interleave():
    a = LinkedList()
    a.append(1)
    a.append(3)
    a.append(5)
    b = LinkedList()
    b.append(2)
    b.append(4)
    b.append(6)
    b.sorted_ingest(a)

    assert str(b) == "[1, 2, 3, 4, 5, 6]"
    assert a.empty


def test_merge_is_interleave_uneven():
    a = LinkedList()
    a.append(1)
    a.append(3)
    a.append(5)
    a.append(10)
    b = LinkedList()
    b.append(2)
    b.append(4)
    b.append(6)
    b.sorted_ingest(a)

    assert str(b) == "[1, 2, 3, 4, 5, 6, 10]"
    assert a.empty


def test_merge_random():
    a = sorted([random.randint(0, 100) for x in range(0, 10)])
    b = sorted([random.randint(0, 100) for x in range(0, 10)])
    c = sorted(a + b)

    p = LinkedList()
    for e in a:
        p.append(e)

    q = LinkedList()
    for e in b:
        q.append(e)

    p.sorted_ingest(q)

    for i, e in enumerate(p):
        assert e == c[i]
```
