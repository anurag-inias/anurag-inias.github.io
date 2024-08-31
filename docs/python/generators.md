# Python – Generators

<style>
.md-logo img {
  content: url('/python/python.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/python/python.svg');
}
</style>

If a function uses `yield` that's a generator.

```python
def countdown(n):
  while n > 0:
    yield n
    n -= 1

next(countdown(4)) # 4
next(countdown(4)) # 4
next(countdown(4)) # 4
next(countdown(4)) # 4

c = countdown(4)
next(c) # 4
next(c) # 3
next(c) # 2
next(c) # 1
next(c) # StopIteration
```

`next` is generally not called directly, but through a `for` loop.

## Cleanup

a generator may get abandoned before being fully consumed. we can schedule any cleanup on it being garbage collected through a `finally` block.

```python
def countdown(n):
  try:
    while n > 0:
      yield n
      n -= 1
  finally:
    # release any resources
```

## Restarting

a generator can only be executed to completion once.

```python
c = countdown(3)

for n in c:
  print(n) # 3 2 1

for n in c:
  print(n) # does nothing
```

if you want to be able to restart, convert it to a class and make `__iter__` return a generator:

```python
class countdown:

  def __init__(self, start):
    self.start = start

  def __init__(self):
    n = self.start  
    while n > 0:
      yield n
      n -= 1

c = countdown(3)

for n in c:
  print(n) # 3 2 1

for n in c:
  print(n) # 3 2 1
```

as an object, when `for` loop is called on `c`, it implicitly calls `__iter__`, thus creating a fresh new generator.

## Generator Intake

`yield` can be used in right-hand-side to pass value to a generator.

```python
def receiver():
  print('ready')
  while True:
    n = yield
    print('Got' n)
```

we can call it like this:

```python
r = receiver()

r.send(None) # ready
r.send(1)    # Got 1
r.send(2)    # Got 2

r.close()
r.send(3)    # StopIteration
```

the first `send` is necessary so the generator executes the statements leading to the first `yield`.

There isn't much practical use of this feature these days.

## `yield from`

[Read this](https://stackoverflow.com/questions/9708902/in-practice-what-are-the-main-uses-for-the-yield-from-syntax-in-python-3-3)
