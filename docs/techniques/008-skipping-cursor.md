# Skipping cursor

Let's say you want to delete certain elements from a given list. You can do so without performing an explicity **fint-and-delete** or a **shuffle-left** operation on the elements.

```java
public static int remove(char[] s, char toBeDeleted) {
  int cursor = 0;
  for (char c: s) {
    if (c != toBeDeleted) s[cursor++] = c;
  }
```

This will implicitly deleted the undesired element, as well as, shift its neighbours to the left.