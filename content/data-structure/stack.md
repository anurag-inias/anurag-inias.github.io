---
title: Stack
---
{{< toc >}}

Stack is an abstract data type that serves as a collection of elements. It implements a _last-in, first-out_ (LIFO) policy. Below are the two implementation of it in Java.

## Implementation

{{< tabs "implementation" >}}
{{< tab "Array based" >}}
{{< highlight Java "linenos=table" >}}
import java.util.EmptyStackException;

public class ArrayStack implements Stack {

  private static final int DEFAULT_CAPACITY = 32;

  private int[] items;
  private int size;

  public ArrayStack() {
    this(DEFAULT_CAPACITY);
  }

  public ArrayStack(int capacity) {
    if (capacity <= 0) throw new RuntimeException("capacity cannot be zero");
    this.items = new int[capacity];
    this.size = 0;
  }

  @Override
  public void push(int value) {
    if (size == items.length) resize();
    items[size++] = value;
  }

  @Override
  public int pop() {
    if (size == 0) throw new EmptyStackException();
    return items[--size];
  }

  @Override
  public int peek() {
    if (size == 0) throw new EmptyStackException();
    return items[size-1];
  }

  @Override
  public boolean isEmpty() {
    return size == 0;
  }

  private void resize() {
    int[] newItems = new int[items.length * 2];
    System.arraycopy(items, 0, newItems, 0, items.length);
    items = newItems;
  }
}
{{< /highlight >}}
{{< /tab >}}

{{< tab "LinkedList based" >}}
{{< highlight Java "linenos=table" >}}
import java.util.EmptyStackException;

public class LinkedListStack implements Stack {

  private static class Node {
    int value;
    Node next;

    Node(int value, Node next) {
      this.value = value;
      this.next = next;
    }
  }

  private Node head;

  public LinkedListStack() {
    head = null;
  }

  @Override
  public void push(int value) {
    head = new Node(value, head);
  }
  @Override
  public int pop() {
    int value = peek();
    head = head.next;
    return value;
  }

  @Override
  public int peek() {
    if (head == null) throw new EmptyStackException();
    return head.value;
  }

  @Override
  public boolean isEmpty() {
    return head == null;
  }

}

{{< /highlight >}}
{{< /tab >}}

{{< tab "Unit tests" >}}
{{< highlight Java "linenos=table" >}}
import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Collections;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class StackTest {

  private Stack stack;

  @BeforeEach
  public void setup() {
    //stack = new ArrayStack();
    stack = new LinkedListStack();
  }

  @Test
  public void testEmptyPop() {
    assertThrows(RuntimeException.class, stack::pop);
  }

  @Test
  public void testSinglePush() {
    stack.push(1);
    assertEquals(1, stack.peek());
    assertEquals(1, stack.pop());
    assertTrue(stack.isEmpty());
  }

  @Test
  public void testPopOrder() {
    stack.push(1);
    stack.push(2);
    stack.push(3);
    assertEquals(3, stack.pop());
    assertEquals(2, stack.pop());
    assertEquals(1, stack.pop());
    assertTrue(stack.isEmpty());
  }

  @Test
  public void testResize() {
    Stack stack = new ArrayStack(1);
    stack.push(1);
    stack.push(2);
    stack.push(3);
    assertEquals(3, stack.pop());
    assertEquals(2, stack.pop());
    assertEquals(1, stack.pop());
    assertTrue(stack.isEmpty());
  }

  @Test
  public void testFuzzy() {
    List<Integer> items = ThreadLocalRandom.current().ints(1000).boxed().collect(Collectors.toList());
    items.forEach(stack::push);
    Collections.reverse(items);
    items.forEach(exp -> assertEquals(exp, stack.pop()));
    assertTrue(stack.isEmpty());
  }
}
{{< /highlight >}}
{{< /tab >}}
{{< /tabs >}}

## Min-Stack

A _minimum-stack_ is a stack that supports an additional method `min` that returns the smallest item in the stack. We can implement it {{< katex >}} O(1) {{< /katex >}} time. We can do so by not only storing the items, but also the minimum item seen so far.

{{< tabs "minstack" >}}
{{< tab "Implementation" >}}
{{< highlight Java "linenos=table,hl_lines=8 26" >}}
import java.util.EmptyStackException;

public class ArrayStack implements Stack {

  private static final int DEFAULT_CAPACITY = 32;

  private int[] items;
  private int[] mins;
  private int size;

  public ArrayStack() {
    this(DEFAULT_CAPACITY);
  }

  public ArrayStack(int capacity) {
    if (capacity <= 0) throw new RuntimeException("capacity cannot be zero");
    this.items = new int[capacity];
    this.mins = new int[capacity];
    this.size = 0;
  }

  @Override
  public void push(int value) {
    if (size == items.length) resize();
    items[size] = value;
    mins[size] = isEmpty() ? value : Math.min(value, mins[size-1]);
    size++;
  }

  @Override
  public int pop() {
    if (size == 0) throw new EmptyStackException();
    return items[--size];
  }

  @Override
  public int peek() {
    if (size == 0) throw new EmptyStackException();
    return items[size-1];
  }

  public int min() {
    if (size == 0) throw new EmptyStackException();
    return mins[size-1];
  }

  @Override
  public boolean isEmpty() {
    return size == 0;
  }

  private void resize() {
    int[] newItems = new int[items.length * 2];
    int[] newMins = new int[items.length * 2];
    System.arraycopy(items, 0, newItems, 0, items.length);
    System.arraycopy(mins, 0, newMins, 0, mins.length);
    items = newItems;
    mins = newMins;
  }
}
{{< /highlight >}}
{{< /tab >}}
{{< tab "Unit test" >}}
{{< highlight Java "linenos=table" >}}
import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class StackTest {

  private ArrayStack stack;

  @BeforeEach
  public void setup() {
    stack = new ArrayStack();
  }

  @Test
  public void testEmptyPop() {
    assertThrows(RuntimeException.class, stack::pop);
  }

  @Test
  public void testMinEmpty() {
    assertThrows(RuntimeException.class, stack::min);
  }

  @Test
  public void testMinSingle() {
    stack.push(1);
    assertEquals(1, stack.min());
    assertEquals(1, stack.pop());
    assertTrue(stack.isEmpty());
  }

  @Test
  public void testMinAscending() {
    stack.push(1);
    stack.push(2);
    assertEquals(1, stack.min());
    assertEquals(2, stack.pop());
    assertEquals(1, stack.min());
    assertEquals(1, stack.pop());
    assertTrue(stack.isEmpty());
  }

  @Test
  public void testMinDescending() {
    stack.push(2);
    stack.push(1);
    assertEquals(1, stack.min());
    assertEquals(1, stack.pop());
    assertEquals(2, stack.min());
    assertEquals(2, stack.pop());
    assertTrue(stack.isEmpty());
  }

  @Test
  public void testFuzzy() {
    List<Integer> items = ThreadLocalRandom.current().ints(1000).boxed().toList();
    List<Integer> mins = new ArrayList<>(items.size());
    mins.add(items.get(0));

    for (int i = 1; i < items.size(); i++)
      mins.add(Math.min(items.get(i), mins.get(i-1)));

    items.forEach(stack::push);
    for (int i = items.size() - 1; i >= 0; i--) {
      assertEquals(mins.get(i), stack.min());
      assertEquals(items.get(i), stack.pop());
    }
    assertTrue(stack.isEmpty());
  }

}
{{< /highlight >}}
{{< /tab >}}
{{< /tabs >}}