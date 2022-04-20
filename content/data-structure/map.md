---
title: Hash Map
---
{{< toc >}}


## Introduction

First some definitions -- A _map_, _symbol table_, _associative array_ or _dictionary_ is an abstract data type that stores a collection of {{<katex>}} (key, value) {{</katex>}} pairs. Each {{<katex>}}key{{</katex>}} appears atmost once. They are implemented mainly as either:
- Hash table (also known as hash map)
- Self-balancing BST

A hash map uses a _hash function_ to compute an `index` into an array of bucket/slots to either insert/lookup desired value. Collisions are handle either with:

1. Separate Chaining: collided items are grouped together in a collection like linked-list or dynamic array.
2. Open addressing: Use probing to find the next empty slot in case collision.

Separate chanining with dynamic-array has advantage of being cache-friendly. If keep each bucket sorted, it can also give faster operations.

## Implementation

In this section I will implement a map of my own using separate chaining. Also, each bucket/slot will use a sorted dynamic array for colliding items. I'll use binary search to lookup items in a bucket.

{{< tabs "map-implementation" >}}
{{< tab "Slot interface" >}}
First a look at `Slot` interface. That's where colliding entries are kept together. An `Entry` is just a data class for a `(key, value)` pair.

{{< highlight Java "linenos=table" >}}
import java.util.List;

public interface Slot {
  void add(int key, String value);

  String get(int key);

  void remove(int key);

  boolean isEmpty();

  List<Entry> entries();
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "ArraySlot" >}}
Implementation of `Slot` interface as a dynamic array. Newly added entries are sorted into their correct position with insertion sort. 

{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.map;

import java.util.ArrayList;
import java.util.List;

public class ArraySlot implements Slot {

  private List<Entry> items;

  public ArraySlot() {
    this.items = new ArrayList<>(); // I don't feel like reimplementing an dynamic array;
  }

  @Override
  public void add(int key, String value) {
    Entry entry = new Entry(key, value);
    items.add(entry);
    if (items.size() == 1)
      return;

    // That's insertion sort, but the array is already sorted. We are just moving the newly added
    // item to its correct position.
    int idx = items.size() - 2;
    while (idx >= 0 && items.get(idx).key > key)
      items.set(idx+1, items.get(idx--)); // Notice that it's `set`, not `swap`.
                                          // No point swapping when `idx` entry itself will be
                                          // overwritten in next iteration.
    items.set(idx+1, entry);
  }

  @Override
  public String get(int key) {
    int index = findIndex(key);
    return index < 0 ? null : items.get(index).value;
  }

  @Override
  public void remove(int key) {
    int index = findIndex(key);
    if (index >= 0)
      items.remove(index);
  }

  @Override
  public boolean isEmpty() {
    return items.isEmpty();
  }

  @Override
  public List<Entry> entries() {
    return items;
  }

  private int findIndex(int key) {
    int l = 0, r = items.size() - 1;
    while (l <= r) {
      int m = l + (r - l) / 2;
      if (items.get(m).key == key) return m;
      if (key < items.get(m).key) r = m-1;
      else l = m+1;
    }
    return -1;
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "Custom HashMap" >}}
Next is my custom `HashMap` which uses a dynamic array of `Slots`. Take note of the `resize` operation. It does not resize when too many entries are added to the map, but instead when too many of the slots are used. 

{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.map;

public class HashMap {

  private static final int DEFAULT_CAPACITY = 32;
  private static final float DEFAULT_LOAD_FACTOR = 0.75f;

  private Slot[] slots;
  // It's counting number of slots in use, and not number of entries.
  private int size; 
  private float loadFactor;

  public HashMap() {
    this(DEFAULT_CAPACITY, DEFAULT_LOAD_FACTOR);
  }

  public HashMap(int capacity, float loadFactor) {
    this.slots = new Slot[capacity];
    this.size = 0;
    this.loadFactor = loadFactor;
  }

  public void put(int key, String value) {
    if (size >= slots.length * loadFactor) resize();

    if (slots[index(key)] == null) {
      slots[index(key)] = new ArraySlot();
      size++;
    }
    slots[index(key)].add(key, value);
    size++;
  }

  public String get(int key) {
    Slot slot = slots[index(key)];
    return slot == null ? null : slot.get(key);
  }

  public void remove(int key) {
    Slot slot = slots[index(key)];
    if (slot == null) return;
    slot.remove(key);

    if (slot.isEmpty()) size--;
  }

  private int index(int key) {
    return index(key, slots.length);
  }

  // Move entries to a new slots array.
  private void resize() {
    Slot[] newSlots = new Slot[slots.length * 2];
    for (Slot slot : slots) {
      if (slot == null) continue;

      for (Entry e : slot.entries()) {
        int h = index(e.key, newSlots.length);
        if (newSlots[h] == null) newSlots[h] = new ArraySlot();
        newSlots[h].add(e.key, e.value);
      }
    }
    slots = newSlots;
  }

  // Handles negative key values.
  private static int index(int key, int length) {
    int h = key % length;
    return h < 0 ? length + h : h;
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "Unit Test" >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.map;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class HashMapTest {

  private HashMap map;

  @BeforeEach
  public void setup() {
    map = new HashMap();
  }

  @Test
  public void testEmpty() {
    assertNull(map.get(0));
  }

  @Test
  public void testSingle() {
    map.put(1, "1");
    assertEquals("1", map.get(1));
  }

  @Test
  public void testWideRange() {
    map.put(1, "1");
    map.put(10000, "10000");
    map.put(761, "761");
    assertEquals("1", map.get(1));
    assertEquals("10000", map.get(10000));
    assertEquals("761", map.get(761));
  }

  @Test
  public void testFuzzyInsert() {
    Set<Integer> exists = ThreadLocalRandom.current().ints(1000).distinct().boxed().collect(Collectors.toSet());
    Set<Integer> absent = ThreadLocalRandom.current().ints(1000).distinct().filter(i -> !exists.contains(i)).boxed().collect(Collectors.toSet());
    exists.forEach(k -> map.put(k, String.valueOf(k)));

    absent.forEach(k -> assertNull(map.get(k)));
    exists.forEach(k -> {
      assertEquals(String.valueOf(k), map.get(k));
      map.remove(k);
      assertNull(map.get(k));
    });
  }

}
{{< /highlight >}}
{{< /tab >}}

{{< /tabs  >}}

## Benchmark

{{< tabs "benchmark" >}}
{{< tab "Against built-in HashMap" >}}
{{< highlight Java "linenos=table" >}}
@Test
public void benchmarkBuiltInPut() {
  System.out.print("['Size', 'Built-in', 'Custom']");
  for (int size : List.of(10, 100, 500, 1000, 2000, 3000, 4000, 5000, 10000)) {
    List<Integer> items = ThreadLocalRandom.current().ints(size).boxed().toList();

    HashMap custom = new HashMap();
    java.util.HashMap<Integer, String> builtin = new java.util.HashMap<>();

    long builtinStart = System.nanoTime();
    items.forEach(i -> builtin.put(i, String.valueOf(i)));
    long builtinElapsed = System.nanoTime() - builtinStart;

    long customStart = System.nanoTime();
    items.forEach(i -> custom.put(i, String.valueOf(i)));
    long customElapsed = System.nanoTime() - customStart;

    System.out.printf(",\n[%d,%d,%d]", size, builtinElapsed, customElapsed);
  }
}

@Test
public void benchmarkBuiltInGet() {
  System.out.print("['Size', 'Built-in', 'Custom']");
  for (int size : List.of(10, 100, 500, 1000, 2000, 3000, 4000, 5000, 10000)) {
    List<Integer> items = ThreadLocalRandom.current().ints(size).boxed().toList();

    HashMap custom = new HashMap();
    java.util.HashMap<Integer, String> builtin = new java.util.HashMap<>();
    items.forEach(i -> {
      custom.put(i, String.valueOf(i));
      builtin.put(i, String.valueOf(i));
    });

    long builtinStart = System.nanoTime();
    items.forEach(i -> builtin.get(i));
    long builtinElapsed = System.nanoTime() - builtinStart;

    long customStart = System.nanoTime();
    items.forEach(i -> custom.get(i));
    long customElapsed = System.nanoTime() - customStart;

    System.out.printf(",\n[%d,%d,%d]", size, builtinElapsed, customElapsed);
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "For differencet load-factors" >}}
{{< highlight Java "linenos=table" >}}
@Test
public void benchmarkLoadFactor(){
  System.out.print("['Size', '10%', '50%', '75%', '100%', '150%', '200%']");
  for (int size : List.of(1000, 2000, 3000, 4000, 5000, 10000, 100000)) {
    List<Integer> items = ThreadLocalRandom.current().ints(10000).boxed().toList();
    System.out.printf(",\n[%d", size);

    for (float factor: List.of(0.1f, 0.5f, 0.75f, 1.0f, 1.5f, 2.0f)) {
      HashMap custom = new HashMap(1, factor);

      long putStart = System.nanoTime();
      items.forEach(i -> custom.put(i, String.valueOf(i)));
      long putElapsed = System.nanoTime() - putStart;

      System.out.printf(",%d", putElapsed);
    }
    System.out.print(']');
  }
}
{{< /highlight >}}
{{< /tab >}}
{{< /tabs  >}}

I first compare how this custom `HashMap` performs against the Java collection's `HashMap`. For `put` operation, the built-in `HashMap` is clearly superior; for `get` operation it's harder to pick a winner.

{{< map-benchmark-against-builtin >}}

Next I look what affect `loadFactor` has on map operations. The `200%` load factor gives the best performance, but not by a lot.

{{< map-benchmark-load-factor >}}

Finally, comparing dynamic array based slots against linked list based slots. It appears that maintaining a sorted bucket and _binary search_ are both wasted efforts. There's just not that many collisions to see any gains.

{{< expand >}}
{{< highlight Java "linenos=table" >}}
package dev.justanotherblog.map;

import java.util.ArrayList;
import java.util.List;

public class LinkedListSlot implements Slot {

  private static class Node {
    int key;
    String value;
    Node next;

    Node(int key, String value, Node next) {
      this.key = key;
      this.value = value;
      this.next = next;
    }
  }

  private Node head;

  public LinkedListSlot() {
    head = null;
  }

  @Override
  public void add(int key, String value) {
    head = new Node(key, value, head);
  }

  @Override
  public String get(int key) {
    Node node = head;
    while (node != null) {
      if (node.key == key)
        return node.value;
      node = node.next;
    }
    return null;
  }

  @Override
  public void remove(int key) {
    Node node = head, prev = null;
    while (node != null) {
      prev = node;
      if (node.key == key)
        break;
      node = node.next;
    }
    if (prev == null) head = null;
    else if (node != null) prev.next = node.next;
  }

  @Override
  public boolean isEmpty() {
    return head == null;
  }

  @Override
  public List<Entry> entries() {
    Node node = head;
    List<Entry> entries = new ArrayList<>();
    while (node != null) {
      entries.add(new Entry(node.key, node.value));
      node = node.next;
    }
    return entries;
  }
}
{{< /highlight >}}
{{< /expand >}}

{{< map-benchmark-array-vs-linkedlist >}}