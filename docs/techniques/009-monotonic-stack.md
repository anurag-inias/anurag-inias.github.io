# Monotonic stack

is a stack pattern that maintains the elements in a fixed order either increasing or decreasing.

```kotlin
var stack = ArrayDeque<Int>()
...
while(stack.isNotEmpty() && stack.last() < needle) {
  stack.removeLast()
}
...
val result = if (stack.isEmpty()) -1 else stack.last()
```

The elements $e$s themselves can be stored in the stack, or even their indices $i$s.