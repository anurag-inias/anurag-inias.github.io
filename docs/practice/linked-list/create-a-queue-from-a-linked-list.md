# Create a queue from a linked list

## Problem

Create a queue from a linked list.

## Hint

??? "Expand"

    Singly-linked list is not efficient for queue implementation. That's because `enqueue` can happen in \\(O(1)\\) at `head`, but then `dequeue` would require traversing the whole list till reaching the predecessor of `tail`. i.e. \\(O(n)\\).

    So use circular doubly-linked list.

## Solution

??? "Expand"

    ```python title="queue.py"
    from linkedlist.list import LinkedList


    class Queue:

        def __init__(self):
            self._list = LinkedList()

        @property
        def empty(self): return self._list.empty

        @property
        def peek(self): return self._list.head

        def enqueue(self, data: int):
            self._list.append(data)

        def dequeue(self):
            return self._list.remove_front()
    ```

## Unit tests

```python linenums="1" title="test_queue.py"
from linkedlist.queue import Queue


def test_queue_initialization():
    queue = Queue()
    assert queue.empty
    assert queue.peek is None


def test_queue_enqueue():
    queue = Queue()
    assert queue.empty

    queue.enqueue(1)
    assert queue.peek == 1
    assert not queue.empty

    queue.enqueue(2)
    assert queue.peek == 1
    assert not queue.empty

    queue.enqueue(3)
    assert queue.peek == 1
    assert not queue.empty


def test_queue_dequeue():
    queue = Queue()
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)

    assert queue.dequeue() == 1
    assert not queue.empty

    assert queue.dequeue() == 2
    assert not queue.empty

    assert queue.dequeue() == 3
    assert queue.empty

    assert queue.dequeue() is None
    assert queue.empty

```
