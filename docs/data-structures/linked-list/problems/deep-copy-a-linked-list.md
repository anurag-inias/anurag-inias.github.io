# Deep copy a linked list

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

## Problem

Create a method that creates a deep copy of a linked list.

## Solution

??? "Expand"

    ```python
    def __copy__(self):
        copy = LinkedList()
        for e in self:
            copy.append(e)
        return copy
    ```

## Unit tests

```python linenums="1"
def test_clone():
    l = LinkedList()
    assert copy(l) == l
    assert copy(l) is not l

    l = LinkedList()
    l.prepend(3)
    l.prepend(2)
    l.prepend(1)
    assert copy(l) == l
    assert copy(l) is not l
```