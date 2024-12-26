# Iterate over linked list

<style>
.md-logo img {
  content: url('/data-structures/linked-list/polyline-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/linked-list/polyline-night.svg');
}
</style>

## Get item

=== "Implementation"

    ```python linenums="1" title="list.py"
    def __getitem__(self, index) -> Optional[int]:
        i, cursor = 0, self._sentinel.next
        while i <= index:
            if cursor is self._sentinel:
                return None
            if i == index:
                return cursor.value
            i, cursor = i+1, cursor.next
    ```

=== "Unit tests"

    ```python linenums="1"
    def test_get():
        ll = LinkedList()
        ll.append(1)
        ll.append(2)
        ll.append(3)
        ll.append(4)
        ll.append(5)

        assert ll[0] == 1
        assert ll[1] == 2
        assert ll[2] == 3
        assert ll[3] == 4
        assert ll[4] == 5
        assert ll[5] is None
          
    ```

## Iterator

=== "Implementation"

    ```python linenums="1" title="list.py"
    def __iter__(self):
      cursor = self._sentinel.next
      while cursor is not self._sentinel:
          yield cursor.value
          cursor = cursor.next
    ```

=== "Unit tests"

    ```python linenums="1"
    def test_iteration():
        ll = LinkedList()
        ll.append(1)
        ll.append(2)
        ll.append(3)
        ll.append(4)
        ll.append(5)

        for i, v in enumerate(ll):
            assert v == ll[i]
    ```