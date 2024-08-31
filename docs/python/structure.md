# Python – Program Structure

<style>
.md-logo img {
  content: url('/python/python.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/python/python.svg');
}
</style>

## Structure

All Python programs are sequence of statments, and statements have equal status with all other statements.

```python
if debug:
  def square(x):
    # do something
else:
  def square(x):
    # do something else
```

which makes the above valid, something not possible in other languages.

## Loops

```python
a = [(1, 2, 3), (4, 5, 6)]

for x, y, z in s:
  # x = 1, y = 2, z = 3

for x, _, z in s:
  # x = 1, z = 3

for i, x in enumerate(s):
  # built-in function to get index
```

```python
a = ['a', 'b', 'c']
b = ['p', 'q', 'r']

for x, y in zip(a, b): # combines the two in an iterable of tuples
  # x = 'a', y = 'p'
```

## Exception

Exception class | Notes
----------------|------------
`BaseException` | Root class for all exceptions
`Exception`     | Base of all program-related errors
`ArithmeticError` | Base of all math-related errors
`ImportError` | Base of all import related errors
`LookupError` | Base of all container lookup errors
`OSError` | Base of all system errors
`ValueError` | Base of all value related errors, including Unicode
`UnicodeError` | Base of all string encoding errors

Some exception are used to alter control flow. e.g. `SystemExit` for when progrm exits, `KeyboardInterrupt` for when program is killed via Ctrl+C, and `StopIteration` to signal iteration end.
