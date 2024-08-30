# Python – Basics

<style>
.md-logo img {
  content: url('/python/python.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/python/python.svg');
}
</style>

## Primitive

```python
42 # int
4.2 # float
'forty-two' # str
True # bool
```

## Explicit type

```python
x: int = 42
```

## String template

```python
year = 2024
percentage = 0.123456

print(f'{year:>3d} {percentage:0.2f}')
```

most people are familiar with `0.2f`. `>3d` is formatter for 3-digit decimal number, right aligned.

## Operators

`7/4` is `1.75`, so `/` gives floating points. If you want truncating division, use `//`. e.g. `7//4 = 1`. `2**3 = 8`, so a built-in power operator. Beyond this you also get some built-in functions:

- `divmod(10, 3) = (3, 1)` i.e. the tuple `(10 // 3, 10 % 3)`
- `round(25.1245, 2) = 25.2` gives _banker's rounding, i.e. nearest even multiple. `round(24.5) = 24` and `round(25.5) = 26`.

Integers let you do bit operations like `<<` left shift, `>>` right shift, `&` and, `|` or, `~` negation, `^` xor. Logical operations are `and`, `or`, `not`.

## Strings

```python
a = 'hello'
b = "hello"
c = '''hello'''
d = """hello"""
```

all the above are valid strings. use `'''` and `"""` for multiline strings. Prefix with `f`, then you can embed expressions inside braces like `{x + 4}`. An alternative to this is `.format` method:

```python
print(f'{year} {percentage}')
# or
print('{0:d} {1:f}'.format(year, percentage))
```

Strings are sequence of unicode characters.

```python
a = 'hello'
print(len(a)) # 5
a[4] # o
a[-1] # o
```

common methods on strings are `lower()`, `upper()`, `endswith`, `startswith`, `find`, `replace`, `split`. 

## Casting

`int('32') = 32` wrap an object in the intended type. `str(42) = '42'`.

```python
>> print(str('hello\nworld'))
hello
world

>> prin(repr('hello\nworld'))
'hello\nworld'
```

so use `repr` instead of `str` during debugging.

## Lists

ordered collection of arbitrary objects.

```python
names = ['oink', 'piggy']
names[0] # 'oink'

names.append("that'll do") # 'oink', 'piggy', "that'll do"

names.insert(2, 'hi') # 'oink', 'piggy', 'hi', "that'll do"

for name in names:
  print(name)

names[0:2] # 'oink', 'piggy' (half-open)
```

can create empty list with either `[]` or with `list()`. Lists can be heterogeneous.

## Tuples

Think immutable lists. `('AMD', 2000)`.

## Sets

`{'Java', 'Python'}` unordered collection of objects. can also create with `set()`.

```python
a = b | c # union of b and c
a = b & c # intersection of b and c
a = b - c # in b but not in c
a = b ^ c # either in b or in c, but not both
```

## Dictionaries

```python
m = {
  'name': 'MSFT',
  'price': 120.0
}

if 'name' in m:
  name = m['name]
else
  name = 'foobar'

name = m.get('name', 'foobar') # shorthand
```

mutable data structures cannot be used as keys. 

```python
prices = {} # same as dict()
prices = dict([('foo', 10), ('fighter', 3)]) # from list of tuples

list(prices) # ['foo', 'fighter'] pass back in list() to get keys
prices.keys() # same
prices.values() # for listing all values
```

Interestingly, list conversion retains the order of key insertion.

-----------

## Control flow

```python
if a < b:
  print('hi')
elif a == b:
  pass # do nothing
else:
  print('bye')

while x < 10:
  # do something
```

basic `if` and `when` control flows.

```python
for n in [1, 2, 3]:
  print(n) # 1 2 3

for n in range(1, 3):
  print(n) # 1 2

range(1, 10) # 1 2 3 4 5 6 7 8 9
range(1, 10, 5) # 1 6
range(10, 1, -1) # 10 9 8 7 6 5 4 3 2
```

`range()` function creates an object that represents a half-open range. It computes values on demand.

## Functions

```python
def add(a, b):
  '''
  Computes the sum of a and b
  '''
  return a + b

def add(a: int, b int) -> int:
  '''
  More verbose version
  '''
  return a + b

add(4, 5) # 9
add(4.0, 5) # 9.0 type info not enforced at runtime
add('4', 5) # TypeError. no implicit cast.
```

```python
def add(a = 0, b = 0):
  # example of default paramter

def add(a, b):
  return (a+b, a, b) # return a tuple

sum, a, b = add(4, 5) # 9, 4, 5
```

## Exceptions

```python
try:
  # do something sketchy
except ValueError as err:
  # hide evidence


raise RuntimeError('Nope')
```

so we have `except` instead of `catch`, and `raise` instead of `throw`.

```python
try:
  # something something
finally:
  lock.release()

with lock:
  # something something
```

above two are equivalent.


## Objects

All values are objects in Python.

```python
class Stack:
  
  def __init__(self):
    self._items = []

  def push(self, item):
    self._items.append(item)

  def __repr__(self):
    # like toString in Java

s = Stack()
s.push('plate')
```

`self` instead of `this`. Methods with `__` as prefix and suffix are special. `_items` is not hidden or protected, it's just a convention.

```python
class NumericStack(Stack):
  '''
  Extend Stack
  '''

  def push(self, item):
    if not instance(item, (int, float)):
      raise TypeError('whoa')
    super().push(item)
```

but really, prefer composition over inheritence.

---------------

## Module

```python title="reader.py"
# reader.py
#
# Reads a poem.

def read_poem():
  print('grug')
```

```python title="plagarist.py"
import reader

reader.read_poem()
```

Here `reader.py` must be in one of the `sys.path` directories.

## Scripting

Any python file can be excuted as a script or as a library. So better distinguish the two:

```python title="solution.py"
def main():
  print('uwu world')

if __name__ == '__main__':
  main()
```

`__name__` is a built-in variable that contains the name of the enclosing module. 
- So if you run `python solution.py`, `__name__` will be `__main__`.
- But if `solution.py` is imported somewhere, `__name__` will be `solution`.  

## Packages

A package is a hierarchical collection of modules.

```
├ solution.py
└ www
  ├ __init__.py
  └ reader.py
```

creating `__init__.py` file, which is empty btw, allows us to make nested import statements.

```python title="solution.py"
from www.reader import read_poem

read_poem()
```
