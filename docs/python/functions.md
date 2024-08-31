# Python – Objects

<style>
.md-logo img {
  content: url('/python/python.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/python/python.svg');
}
</style>

## lambda expression

anonymous/unnamed functions

```python
a = lambda x, y: x + y
a(4, 5) # 9
```

lambda must use expression. Multiple statements, non-expression statments (e.g. `try`, `while`) cannot appear in lambda expressions.

```python
x = 2
f = lambda y: x * y

x = 3
g = lambda y: x * y

f(10) # 30
g(10) # 30
```

lambdas don't capture free variables (variables not specifid in parameters) and pick them up at evaluation time. This is different from what we see in Java. Use default param to capture the values

```python
x = 2
f = lambda y, x = x: x * y

x = 3
g = lambda y, x = x: x * y

f(10) # 20 
g(10) # 30
```

## Closure

```python
def greet()
  name = 'Piggy'
  def sayHi():
    print('Hello;, name)
  sayHi()

greet() # 'Hello Piggy'
```

when function is passed as data, it implicitly carries information of its environment in which it was defined. 

A _closure_ is a function along with an environment containing all of the variables needed to execute the function body.

Closure points to `name` variable and the value that it was most recently assigned. So be careful as the value may get mutated.

## Passing arguments to callback

```python
def caller(func):
  func()
```

how to pass arguments to `func`? We can wrap it up in lambda:

```python
caller(lambda: add(2, 3))
```

which is called a _thunk_, an expression that will be evaluated later when the zero-argument `func` param is eventually called. An alternative is `partial`:

```python
from functools import partial

caller(partial(add, 2, 3))
```

`partial` evaluates the arguments and binds them at the time of definition, whereas a _thunk_ would do so lazily.

## Decorators

wrappers around functions to alter/enchance the behaviour.

```python
@decorate
def func(x):
  ...
```

which is shorthand for

```python
def func(x):
  ...

func = decorate(func)
```

it's likely body snatching righ at the spawn. `decorate` returns an object that replaces the original `func`. Here is a real-life example:

```python
@trace
def square(x):
  return x * x
```

here `trace()` creates a wrapper that writes debugging output and then call the actual function. 

```python
from functools import wraps

def trace(func):
  @wraps(func) # special decorator to copy over original func metadata
  def call(*args, **kwargs):
      print('Calling', func.__name__)
      return func(*args, **kwargs)
  return call
```

## Map, Filter, Reduce

List comprehensions can do all these. If you want results lazily, use a generator expression:

```python
squares = (x * x for x in [1, 2, 3]) # generator
# or
squares = map(lambda x: x*x, [1, 2, 3]) # equivalent
```

```python
from functools import reduce

sum = reduce(lambda x, y: x + y, [1, 2, 3]) # 6
```

## Function Attributes

Functions are objects. We can inspect some of these key attributes:

Attribute | Notes
----------|--------
`__name__` | Function name
`__qualname__` | Fully qualified name
`__module__` | Name of the module in which it is defined
 
and so on.