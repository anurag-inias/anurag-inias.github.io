# Iterators

<style>
.md-logo img {
  content: url('/java/logo.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/java/logo.svg');
}
</style>

!!! quote "[Oracle docs](https://docs.oracle.com/javase/7/docs/api/java/util/Iterator.html)"

    `Iterator` takes the place of `Enumeration` in the Java Collections Framework. Iterators differ from enumerations in two ways:
    
    - Iterators allow the caller to remove elements from the underlying collection during the iteration with well-defined semantics.
    - Method names have been improved.

Now the neat thing about iterators is that we can define them for any arbitrary class, and not just collections.

## Basics

```java linenums="1"
record Employee(
  String firstName, 
  String lastName, 
  int id, 
  JobFamily jobFamily) {}

enum JobFamily {
  ADMIN,
  IT,
  SALES,
}
```

Here I have a record class for employee _records_. Let's say that for reason I want to iterate over all its fields. I can do so through `Iterable`.

<div class="grid" markdown>


<div markdown>

```java linenums="1" hl_lines="3 8"
record Employee(
  ...
) implements Iterable<String> {

  @Override
  public Iterator<String> iterator() {
    return new Iterator<>() {
      int cursor = 0; // internal state

      @Override
      public boolean hasNext() {
        return cursor < 3;
      }

      @Override
      public String next() {
        return switch (cursor++) {
          case 0 -> firstName;
          case 1 -> lastName;
          case 2 -> String.valueOf(id);
          case 3 -> jobFamily.name();
          default -> throw new NoSuchElementException();
        };
      }
    };
  }
}
```
</div>

<div markdown>

```java linenums="1"
var employee = new Employee(
  "John", "Doe", 13414, JobFamily.ADMIN
);
```

Following are all equivalent ways to iterate over an `Employee`'s fields:

```java linenums="1"
for (String attr: employee) {
  System.out.println(attr);
}
```

```java linenums="1"
var iter = employee.iterator();

while(iter.hasNext()) {
  System.out.println(iter.next);
}
```

```java linenums="1"
employee.forEach(System.out::println);
```

</div>

</div>

## Iterator vs Iterable

- `Iterator` is an object with an iteration state. It keeps track of how far you are and conveys that through `hasNext()`.
- `Iterable` is an interface to convey whether an object can be iterated over. Note that there is no state involved here.

## Iterator methods

`hasNext` and `next` are the bare minimum to implement an `Iterator`. On top of these, there is also `remove` which is optional.

### remove

!!! quote "[Oracle docs](https://docs.oracle.com/javase/7/docs/api/java/util/Iterator.html#remove())"

    Removes from the underlying collection the last element returned by this iterator (optional operation). This method can be called only once per call to `next()`.

Since my class is actually not a collection, and thus has nothing to remove, I can make it so `remove` simply resets these fields to some default. 

```java linenums="1" hl_lines="3"
@Override
public void remove() {
  switch (cursor - 1) {
    case 0 -> firstName = "UNSET";
    case 1 -> lastName = "UNSET";
    case 2 -> id = -1;
    case 3 -> jobFamily = JobFamily.SALES;
    default -> throw new IllegalStateException();
  };
}
```

`remove` can only be called after a `next` call. Though in this implementation, repeatd `remove` calls won't cause any issues.

### forEachRemaining

Java 8 introduced `forEachRemaining` for using lambdas with `Iterator`:

<div class="grid" markdown>

```java linenums="1" title="imperative way"
var iter = employee.iterator();

while(iter.hasNext()) {
  System.out.println(iter.next);
}
```

```java linenums="1" title="functional way"
var iter = employee.iterator();

iter.forEachRemaining(
  System.out::println
);
```


</div>

Just as `forEach` is used with `Iterable`, `forEachRemaining` is used with `Iterator`. That's it.

## ListIterator

[Oracle docs](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/ListIterator.html)

`ListIterator` is an interface that extends `Iterator` interface with few additional methods:

- `hasPrevious`, like `hasNext`.
- `previous`, like `next`.
- `nextIndex` and `previousIndex`.

```
     Elements:    [0]   [1]   [2]   [3]   [4]   [5]
       Cursor:  ▲     ▲     ▲     ▲     ▲     ▲     ▲

  hasPrevious:  𐄂     ✓     ✓     ✓     ✓     ✓     ✓
      hasNext:  ✓     ✓     ✓     ✓     ✓     ✓     𐄂

     previous:        0     1     2     3     4     5
         next:  0     1     2     3     4     5

previousIndex: -1     0     1     2     3     4     5
    nextIndex:  0     1     2     3     4     5     6
```