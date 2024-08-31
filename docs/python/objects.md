# Python – Objects

<style>
.md-logo img {
  content: url('/python/python.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/python/python.svg');
}
</style>

## Basics

Everything in Python is an object, including primitives like numbers.

## Identity and Type

`id()` is built-in method to return an object's identity (its location in memory). `is` operator uses `id` to compare two objects.

```python
items = [1, 2, 3]

isinstance(items, (int, str)) # False
isinstance(items, list) # True
items.__class__ # <class 'list'>
```

## Reference Counting

```python 
a = 42 # reference count = 1
b = a  # reference count = 2
c = []
c.append(a) # reference count = 3

del a # attempt to access a now throws NameError
b # 42, other references to the address that contains 42 remain
c # [42]
```

reference count is decreased when:
- reference goes out of scope
- reference is reassigned
- reference is deleted via `del`

generally garbage collector will take care of cleaning up stuff, but it's good to clean up large data structures every now and then.

## Copying

```python
a = [1, 2, 3]
b = a
b is a # True

b[0] = 100
a # [100, 2, 3] # b is just another reference to the original list

b = list(a) # b now points to a shallow copy of a
b is a # False
```

To recursively copy content, use `deepcopy` from library `copy`, like this: `copy.deepcopy(a)`.

## `None` 

special singleton instance representing an optional/missing value.

## Object Protocol

```python
s = Stack() # translates to code below

s = Stack.__new__(Stack, args)
if isinstance(s, Stack):
  s.__init__(args)
```

`__new__` is a static method to create new instances. `__init__` is called to initialize newly created instances. `__del__` is called when an instances is being destroyed. `__repr__` is called when attempting to serialize an object as string. These 4 methods together constitute what we call _object protocol_

## Number Protocol

`+` is powered by `__add(self, other)`, `*` is powered by `__mul__(self, other)` etc. 

## Comparison Protocol

- `__bool__(self)` tells whether to map something as truthy or falsy.
`__eq__(self, other)` implements `==`.
`__ge__(self, other)` implements `>=`.

and so on.

## Conversion Protocol

- `__str__(self)` to serialize something as string.
- `__bytes__(self)` to convert to bytes.

and so on.

## Container Protocol

- `__len__(self)`
- `__getitem__(self, key)`
- `__setitem__(self, key, value)`
- `__delitem__(self, key)`
- `__contains__(self, obj)`

## Iteration Protocol

is an object supports iteration, it provides a method `__iter__()` which returns an iterator. An iterator in turn implements `__next()__` method.

```python
class MyRange:
  
  def __init__(self, start, stop):
    self.start = start
    self.stop = stop

  def __iter__(self):
    cursor = self.start
    while cursor < self.stop:
      yield cursor
```

## Attribute Protocol

Even `.` itself is powered through these methods:

- `__getattribute__(self, name)` gives `self.name`
- `__getattr__(self, name)` called when the previous method doesn't find it
- `__setattr__` for `self.name = value`
- `__delattr__` for `del self.name`

## Function Protocol

Objects can emulate functions by providing `__call__()` method.

## Context Manager Protocol

- `__enter__(self)` for entering a new context
- `__exit__(self, type, value, tb)` for leaving context.

used by `with` statement.
