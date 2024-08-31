# Python – Object Oriented Programming

<style>
.md-logo img {
  content: url('/python/python.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/python/python.svg');
}
</style>

## Scope

Unlike C++ or Java, `self` has be referenced while access methods and members inside a class. Classes define an isolated namespace for the methods, but that namespace does not serve as scope for resolving names used inside methods.

## Inheritence

`object` is the root class of all Python objects, providing default implementation for things like `__str__` and `__repr__`.

## Duck Typing

In Python, variable names don't have an associated type. If you attempt a lookup `.greet()`, it will work on any object with said method: _"if it looks like a duck, quacks like a duck, and walks like a duck, then it's a duck". 

That's much like Golang, and quite unlike Java/C++ family. Thus a lot of standard library containers work with `for` loops, yet none of them have a common `Iterable` base interface.

## Subclassing Built-ins

Python's built-in types are implemented in C. So subclassing these may have undefined behaviour.

```python
class UpperClassDict(dict):
  def __setitem__(self, key, value):
    super().__setitem__(key.upper(), value)

u = UpperClassDict()
u['name'] = 'Oink' # { 'NAME': 'Oink' }
```

success? not really:

```python
u = UpperClassDict(name='Oink') # { 'name': 'Oink' }
```

So use `UserDict`, `UserList`, `UserString` etc when subclassing stuff.

## Class Methods vs Static Methods

Class in Python is also an object that can carry state and be operated upon.

```python
class Account:
  
  def __init__(self, balance):
    self.balance = balance

  @classmethod
  def from_float(cls, amount):
    return cls(amount)

a = Account.from_float(2.0)
```

A class method is a method applied to the class itself. Usually used to define alternate constructors. First argument is always the class itself.

A static method is when you are using class merely as a namespace. `self` or `cls` is no longer added as an argument.

```python
class Arithmetic:

  @staticmethod
  def sum(a, b):
    return a + b
```

## Property

Special attribute that intercepts attribute access and handles it via user-defined methods.

```python
class Account:

  def __init__(self, owner):
    self.owner = owner

  @property
  def owner(self):
    return self._owner

  @owner.setter
  def owner(self, value):
    if not isinstance(value, str):
      raise TypeError('Expected str')
    self._owner = value
```

Basically the actual value is stored in a private attribute `_owner`, and a property `owner` is set up as a front. 

## Interfaces

```python
class Closeable:

  def close(self):
    raise NotImplementedError()
```

is how you define an interface. Similarly, abstract classes are defined as below:

```python
class Closeable:

  @abstractmethod
  def close(self):
    pass
```

attempting to create an instance will throw a `TypeError`.

## Mixin

A mixin class is a class that modifies or extends other clases. Consider:

```python
class Duck:
  def noise(self):
    return 'Quack'

  def waddle(self):
    return 'Waddle'

class Cyclist:
  def noise(self):
    return 'On your left!'

  def waddle(self):
    return 'Shring Shring'
```

both are unrelated, except for the `noise` method. So we can define:

```python
class LoudMixin:
  def noise(self):
    return super().noise().upper()
```

these refer to a non-existent base class. We use these like:

```python
class LoudDuck(LoudMixin, Duck):
  pass

d = LoudDuck()
d.noise() # 'QUACK'
```

## Multiple Inheritence

Python supports it. But how does it resolve conflicts?

```python
class Base:    # Base -> object
  pass

class A(Base): # A -> Base -> object
  pass

class B(A):    # B -> A -> Base -> object
  pass
```

to lookup methods in a class, Python uses _Method Resolution Order_, MRO for short and available as `__mro__` attribute:

```python
Base.__mro__ # Base, object
A.__mro__    # A, Base, object
B.__mro__    # B, A, Base, object
```

So it follows these two common sense rules:
- child class must always be checked before any of the ancestors.
- in case of multiple parents, resolution order is in the order of inheritence list.