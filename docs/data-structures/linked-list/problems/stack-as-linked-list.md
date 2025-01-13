# Linked list as Stack

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

## Problem

Create a stack from a linked list.

## Hint

??? "Expand"

    Insert and remove elements at the _head_ of a singly-linked list.

## Solution

??? "Python"

    ```python linenums="1" title="stack.py"
    from typing import Optional

    from linkedlist.list import LinkedList


    class Stack:

        def __init__(self):
            self._list = LinkedList()

        @property
        def empty(self): return self._list.empty

        @property
        def top(self) -> Optional[int]:
            return self._list.head

        def push(self, data: int):
            self._list.prepend(data)

        def pop(self) -> Optional[int]:
            if self.empty:
                return None
            return self._list.remove_front()
    ```

## Unit tests

```python linenums="1" title="test_stack.py"
import pytest
from stack.stack import Stack
from typing import Optional


def test_initialize_stack():
    s = Stack()
    assert s.empty is True


def test_push_element_to_stack():
    s = Stack()
    assert s.top is None
    assert s.empty

    s.push(3)
    assert s.top is 3
    assert not s.empty

    s.push(2)
    assert s.top is 2
    assert not s.empty

    s.push(1)
    assert s.top is 1
    assert not s.empty


def test_pop_element_from_stack():
    s = Stack()
    s.push(3)
    s.push(2)
    s.push(1)

    assert s.pop() is 1
    assert not s.empty

    assert s.pop() is 2
    assert not s.empty

    assert s.pop() is 3
    assert s.empty

    assert s.pop() is None
    assert s.empty

```
