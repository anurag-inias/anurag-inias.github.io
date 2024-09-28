# Java Collections

<style>
.md-logo img {
  content: url('/java/logo.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/java/logo.svg');
}
</style>

![](./collections.svg){width=1280px}

## [Outline of the Collections Framework](https://docs.oracle.com/javase/8/docs/technotes/guides/collections/reference.html)

[:material-alpha-i-circle-outline: Collection](https://docs.oracle.com/javase/8/docs/api/java/util/Collection.html): A group of objects. No assumptions are made about the order of the collection (if any) or whether it can contain duplicate elements. Most of the common operations such as `add`, `remove`, `isEmpty`, `contains` come from here.

- [:material-alpha-i-circle-outline: Set](https://docs.oracle.com/javase/8/docs/api/java/util/Set.html): The familiar set abstraction. No duplicate elements permitted. May or may not be ordered.
    - [:material-alpha-c-circle: HashSet](https://docs.oracle.com/javase/8/docs/api/java/util/HashSet.html): Concrete implementation of a `Set`. Implemented using hash table, and as such iteration order is not guaranteed. All basic operations `add`, `remove`, `contains` are constant time \\(O(1)\\).
    - [:material-alpha-c-circle: LinkedHashSet](https://docs.oracle.com/javase/8/docs/api/java/util/LinkedHashSet.html): Concrete implementation of a `Set`. Implemented using a doubly-linked list where the oldest element is at front and the latest element is at back. It has a deterministic iteration order, which is the order of insertion. Average time complexity for basic operations is still \\(O(1)\\), but may go as high as \\(O(n)\\).
    - [:material-alpha-i-circle-outline: SortedSet](https://docs.oracle.com/javase/8/docs/api/java/util/SortedSet.html): Further provides a total ordering on its elements. This lets it support `first` and `last` elements in a set, as well as various windows such as `subSet`, `headSet`, and `tailSet`. `SortedSet` is further extended by [:material-alpha-i-circle-outline: NavigableSet](https://docs.oracle.com/javase/8/docs/api/java/util/NavigableSet.html) with navigation methods reporting closest matches for given search targets.
        - [:material-alpha-c-circle: TreeSet](https://docs.oracle.com/javase/8/docs/api/java/util/TreeSet.html): Red-black tree implementation of `NavigableSet`. Guaranteed \\(O(log \\ n)\\) time for most basic operations.
- [:material-alpha-i-circle-outline: List](https://docs.oracle.com/javase/8/docs/api/java/util/List.html): Ordered collection, also known as a sequence. Duplicates are generally permitted. Allows positional access.
    - [:material-alpha-c-circle: Vector](https://docs.oracle.com/javase/8/docs/api/java/util/Vector.html): Implemented as resizable array. Retrofitted to `List` interface in Java 1.2, and is synchronized by default. Use `ArrayList` instead. Similarly, [:material-alpha-c-circle: Stack](https://docs.oracle.com/javase/8/docs/api/java/util/Stack.html) which builds on top of `Vector` inherits its unnecessary costs. Use `Deque` instead.
    - [:material-alpha-c-circle: ArrayList](https://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html): Good 'ol resizable array.
    - [:material-alpha-c-circle: LinkedList](https://docs.oracle.com/javase/8/docs/api/java/util/LinkedList.html): Doubly-linked list implementation of the `List` and `Deque` interfaces.
- [:material-alpha-i-circle-outline: Queue](https://docs.oracle.com/javase/8/docs/api/java/util/Queue.html): A collection designed for holding elements before processing. Provide additional insertion, extraction, and inspection operations.
    - [:material-alpha-c-circle: LinkedList](https://docs.oracle.com/javase/8/docs/api/java/util/LinkedList.html): See above.
    - [:material-alpha-c-circle: PriorityQueue](https://docs.oracle.com/javase/8/docs/api/java/util/PriorityQueue.html): A min-heap.
    - [:material-alpha-i-circle-outline: Deque](https://docs.oracle.com/javase/8/docs/api/java/util/Deque.html): A double ended queue, supporting element insertion and removal at both ends.
        - [:material-alpha-c-circle: ArrayDeque](https://docs.oracle.com/javase/8/docs/api/java/util/ArrayDeque.html): Implemented as a circular resizable-array. However, since it's a `Queue` interface and not `List`, one cannot access elements randomly by index.