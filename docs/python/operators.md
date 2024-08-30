# Python – Operators

<style>
.md-logo img {
  content: url('/python/python.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/python/python.svg');
}
</style>

## Literals

```python
42 # decimal int
0b1010 # bin(42)
0o52 # oct(42)
0x2a # hex(42)

42.0 # IEEE 754 64-bit value
42. # same as 42.0
4.2e+1 # same
```

## Expressions vs Statement

Expressions produce at least one value. Statement do something and are composed of expressions / other statements.

`if` is usually as statement

naming a result is only allowed within a statement, not in an expression. `:=` is an assignment expression which lets you do that.

```python 
if x = add(4, 5): # SyntaxError
if x := add(4, 5): # this works

x := 4 # SyntaxError. not allowed as normal assignment operator
(x := 4) # allowed now
```

## Standard Operators

`+`, `-`, `*` etc are the common number operators like other languages. But other objects in Python tend to work with these too with some common sense:

```python
[1] + [2, 3] # [1, 2, 3]
[1, 2] * 4   # [1, 2, 1, 2, 1, 2, 1, 2] if + is add, then * must be repeated add
```

## Object Comparison

`==` checks for equality.

- in case of lists and tuples, size must be same and with equal elements in same order.
- in case of dictionaries, same set of keys and corresponding mapped values.
- in case of sets, elements must be same.
- different types of objects will return `False` on comparison.
- implicit casting is possible when comparing int and floats.

if you want Java like comparison (i.e. same object in memory), use `x is y`, `id(x) == id(y)`. Here `id()` is like `hashCode`. 

## Iterable Operations

iteration is supported by all containers (list, tuple, dict etc), files and generator functions.

```python
for name in names:
  # iteration

first, second = ['oink', 'piggy'] # unpacking

'oink' in names # membership check

[first, *rest, last] = ['oink', 'piggy', 'peppa', 'snort'] # expansion, same as JS destructuring
first # 'oink'
last # 'snort'
rest # ['piggy', 'peppa']
```

```python
any([False, False, True]) # True, checks if any item is true
all([False, False, True]) # False, checks if all items are true
sorted([4, 3]) # [3, 4] gives a sorted copy
```

## Sequence Operations

sequence are iterable containers with size and indices. i.e. strings, lists and tuples.

```python
[1, 2] + [3, 4] # [1, 2, 3, 4] concaternation
'hello' * 2 # 'hellohello' makes 2 copies
names[i] # indexing
names[i:j] # slicing
names[i:j:k] # slicing with steps
len(names) # length
```

## Mutable Sequence Operations

So only lists, as strings and tuples are immutable.

```python
names[i] = 'peter' # assignment at index
names[i:j] # assign a whole slice
del names[i] # delete an element
```

## Set Operations

```python
a | b # union
a & b # intersection
a - b # difference
a ^ b # symmetric diff (items in a or b, but not in both)

set.add(...)
set.remove(...) # remove if exists, else an error
set.discard(...) # remove if exists
```

## Map Operations

`del m[key]`, `m.keys()`, `m.values()`. use `m.items()` for entries (i.e. key-value tuples).

-----------------

## Comprehensions

Basically `map` from Java streams.

```python
nums = [1, 2, 3]
odd_squares = [n ** 2 for n in nums if n % 2 != 0] # [1, 9]

odd_squares_set = {...same stuff...} # {1, 9} can also do this with sets and dictionary
```

## Generator Expression

Same as comprehensions, but lazy.

```python
odd_squares = (n ** 2 for n in nums if n % 2 != 0) # <generator object <genexpr> at 0x100b09ff0>

next(odd_squares) # 1
next(odd_squares) # 9
next(odd_squares) # StopIteration error
```
