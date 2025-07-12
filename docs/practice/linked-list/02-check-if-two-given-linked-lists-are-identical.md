# Check if two given linked lists are identical

## Problem

Check if two given linked lists are identical.

## Hint

??? "Expand"

    Run two cursors, one in each linked list and compare the corresponding nodes.

## Solution

??? "Expand"

    ```python
    def __eq__(self, other: 'LinkedList'):
        if self is other:
            return True

        cursor = self._sentinel.next
        for e in other:
            if e != cursor.value:
                return False
            cursor = cursor.next

        return cursor is self._sentinel
    ```

## Unit tests

```python linenums="1"
def test_equality_empty():
    assert LinkedList() == LinkedList()
    assert LinkedList() is not LinkedList()


def test_equality_simple():
    p = LinkedList()
    p.append(1)
    p.append(2)
    p.append(3)

    q = LinkedList()
    q.append(1)
    q.append(2)
    q.append(3)
    assert p == q
    assert p is not q


def test_equality_partial():
    p = LinkedList()
    p.append(1)
    p.append(2)
    p.append(3)
    p.append(4)

    q = LinkedList()
    q.append(1)
    q.append(2)
    q.append(3)

    assert p != q

    q.append(4)
    assert p == q

    q.append(5)
    assert p != q

```
