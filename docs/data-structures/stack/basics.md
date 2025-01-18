# Basics

<style>
.md-logo img {
  content: url('/data-structures/stack/stack.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/stack/stack.svg');
}
</style>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
</script>

Stack is an abstract data type that serves the elements of a collection in last in, first out fashion.

## Implementation

### As an array

$$
\begin{alignat}{1}
\fbox{ $\phantom{1}$ } \leftarrow & \ top \\
\fbox{ 1 } \leftarrow & \ top \ \ \ \text{ push}(1) \\
\fbox{ 1 | 2 } \leftarrow & \ top \ \ \ \text{ push}(2) \\
\fbox{ 1 | 2 | 3 } \leftarrow & \ top \ \ \ \text{ push}(3) \\
\fbox{ 1 | 2 } \leftarrow & \ top \ \ \ \text{ pop}() = 3 \\
\fbox{ 1 } \leftarrow & \ top \ \ \ \text{ pop}() = 2 \\
\fbox{ $\phantom{1}$ } \leftarrow & \ top \ \ \ \text{ pop}() = 1 \\
\end{alignat}
$$

=== "Golang"

    ![](/data-structures/stack/go-pop-light.png#only-light){width=300}
    ![](/data-structures/stack/go-pop-dark.png#only-dark){width=300}

    A neat trick we can do with Go *slices*s is popping an element by changing the region of the underlying array that the slice is projecting $\text{slice} \leftarrow \text{slice}(0 \dots length-1)$. Since the new slice keeps pointing to the same underlying array, we can update our bounds without having to keep a separate `top` pointer.

    ```golang linenums="1"
    package stack

    type Stack struct {
      elements []int
    }

    func NewStack() *Stack {
      return &Stack{}
    }

    func (s *Stack) IsEmpty() bool {
      return len(s.elements) == 0
    }

    func (s *Stack) Size() int {
      return len(s.elements)
    }

    func (s *Stack) Push(v int) {
      s.elements = append(s.elements, v)
    }

    func (s *Stack) Pop() (int, bool) {
      if s.IsEmpty() {
        return 0, false
      }
      top := s.elements[len(s.elements)-1]
      s.elements = s.elements[:len(s.elements)-1]
      return top, true
    }

    func (s *Stack) Peek() (int, bool) {
      if s.IsEmpty() {
        return 0, false
      }
      return s.elements[len(s.elements)-1], true
    }
    ```

=== "Unit tests"

    ```golang linenums="1"
    package stack

    import (
      "golang.org/x/exp/rand"
      "testing"
    )

    func TestEmpty(t *testing.T) {
      s := NewStack()
      if !s.IsEmpty() {
        t.Fatalf("new stack should be empty")
      }

      s.Push(1)
      if s.IsEmpty() {
        t.Fatalf("stack should be non-empty after inserting 1")
      }

      s.Pop()
      if !s.IsEmpty() {
        t.Fatalf("stack should be empty after removing the only element in it")
      }

      s.Push(1)
      s.Push(2)
      s.Push(3)
      s.Pop()
      s.Pop()
      s.Pop()
      if !s.IsEmpty() {
        t.Fatalf("stack should be empty after removing all the elements from it")
      }
    }

    func TestSize(t *testing.T) {
      s := NewStack()
      if s.Size() != 0 {
        t.Fatalf("new stack should report size as 0")
      }

      s.Push(1)
      if s.Size() != 1 {
        t.Fatalf("stack size should be 1, but was %d after inserting one element", s.Size())
      }

      s.Pop()
      if s.Size() != 0 {
        t.Fatalf("stack size should be 0, but was %d after removing the only element in it", s.Size())
      }

      s.Push(1)
      s.Push(2)
      s.Push(3)
      s.Pop()
      s.Pop()
      s.Pop()
      if s.Size() != 0 {
        t.Fatalf("stack size should be 0, but was %d after removing all the elements from it", s.Size())
      }
    }

    func TestSimple(t *testing.T) {
      s := NewStack()
      if top, ok := s.Peek(); ok {
        t.Fatalf("peek should be (_, false), but was (%d, %v) for an empty stack", top, ok)
      }

      s.Push(1)
      if top, ok := s.Peek(); top != 1 || !ok {
        t.Fatalf("peek should be (1, true), but was (%d, %v)", top, ok)
      }

      s.Push(2)
      if top, ok := s.Peek(); top != 2 || !ok {
        t.Fatalf("peek should be (2, true), but was (%d, %v)", top, ok)
      }

      s.Push(3)
      if top, ok := s.Peek(); top != 3 || !ok {
        t.Fatalf("peek should be (3, true), but was (%d, %v)", top, ok)
      }

      if top, ok := s.Pop(); top != 3 || !ok {
        t.Fatalf("pop should be (3, true), but was (%d, %v)", top, ok)
      }

      if top, ok := s.Pop(); top != 2 || !ok {
        t.Fatalf("pop should be (2, true), but was (%d, %v)", top, ok)
      }

      if top, ok := s.Pop(); top != 1 || !ok {
        t.Fatalf("pop should be (1, true), but was (%d, %v)", top, ok)
      }

      if top, ok := s.Pop(); ok {
        t.Fatalf("peek should be (_, false), but was (%d, %v) for an empty stack", top, ok)
      }
    }

    func TestRandom(t *testing.T) {
      s := NewStack()
      r := rand.New(rand.NewSource(10))
      var c []int

      for i := 0; i < 100; i++ {
        v := r.Intn(1000)
        c = append(c, v)
        s.Push(v)
      }

      for i := 99; i >= 0; i-- {
        if top, ok := s.Pop(); top != c[i] || !ok {
          t.Fatalf("pop should be (%d, true) but was (%d, true)", c[i], top)
        }
      }
      if !s.IsEmpty() {
        t.Fatalf("stack should be empty")
      }
    }
    ```

=== "Golang generic"

    ```golang linenums="1"
    type any interface{} // so we don't have to type `interface{}` again and again

    type Stack[T any] struct {
      elements []T
    }

    func NewStack[T any]() *Stack[T] {
      return &Stack[T]{}
    }

    func (s *Stack[T]) IsEmpty() bool {
      return len(s.elements) == 0
    }

    func (s *Stack[T]) Size() int {
      return len(s.elements)
    }

    func (s *Stack[T]) Push(v T) {
      s.elements = append(s.elements, v)
    }

    func (s *Stack[T]) Pop() (T, bool) {
      if s.IsEmpty() {
        var identity T // default value for type T
        return identity, false
      }
      top := s.elements[len(s.elements)-1]
      s.elements = s.elements[:len(s.elements)-1]
      return top, true
    }

    func (s *Stack[T]) Peek() (T, bool) {
      if s.IsEmpty() {
        var identity T
        return identity, false
      }
      return s.elements[len(s.elements)-1], true
    }
    ```

=== "Kotlin"

    We can use ${removeLast}$ to pop the last element from the underlying `ArrayList`, as it internally uses `fastRemove`.

    ```java title="Chill Oracle, I'm just paraphrasing"
    private void fastRemove(Object[] es, int i) {
      int newSize = size - 1
      if (newSize > i)            // shift left all elements to the right of i
          System.arraycopy(es, i + 1, es, i, newSize - i);
      es[size - 1] = null;
      size = newSize              // Update the bounds but keep using the same underlying array
    }
    ```

    The full implements is just a few lines.

    ```kotlin linenums="1"
    class Stack {

      private var underlying = ArrayList<Int>()

      val empty: Boolean
        get() = underlying.isEmpty()

      val size: Int
        get() = underlying.size

      fun push(value: Int) {
        underlying.add(value)
      }

      fun pop(): Int? = if (empty) {
        null
      } else {
        underlying.removeLast()
      }

      fun peek(): Int? = if (empty) {
        null
      } else {
        underlying.last()
      }
    }
    ```

=== "Unit tests"

    ```kotlin linenums="1"
    import org.assertj.core.api.Assertions.assertThat
    import org.junit.jupiter.api.Test
    import java.util.concurrent.ThreadLocalRandom

    class StackTest {

      private val stack = Stack()

      @Test
      fun empty() {
        assertThat(stack.empty).isTrue()

        stack.push(1)
        assertThat(stack.empty).isFalse()

        stack.pop()
        assertThat(stack.empty).isTrue()

        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.pop()
        stack.pop()
        stack.pop()
        assertThat(stack.empty).isTrue()
      }

      @Test
      fun size() {
        assertThat(stack.size).isEqualTo(0)

        stack.push(1)
        assertThat(stack.size).isEqualTo(1)

        stack.pop()
        assertThat(stack.size).isEqualTo(0)

        stack.push(1)
        assertThat(stack.size).isEqualTo(1)
        stack.push(2)
        assertThat(stack.size).isEqualTo(2)
        stack.push(3)
        assertThat(stack.size).isEqualTo(3)
        stack.pop()
        assertThat(stack.size).isEqualTo(2)
        stack.pop()
        assertThat(stack.size).isEqualTo(1)
        stack.pop()
        assertThat(stack.size).isEqualTo(0)
      }

      @Test
      fun simple() {
        assertThat(stack.peek()).isNull()
        assertThat(stack.pop()).isNull()

        stack.push(1)
        assertThat(stack.peek()).isEqualTo(1)

        stack.push(2)
        assertThat(stack.peek()).isEqualTo(2)

        stack.push(3)
        assertThat(stack.peek()).isEqualTo(3)

        assertThat(stack.pop()).isEqualTo(3)
        assertThat(stack.peek()).isEqualTo(2)

        assertThat(stack.pop()).isEqualTo(2)
        assertThat(stack.peek()).isEqualTo(1)

        assertThat(stack.pop()).isEqualTo(1)
        assertThat(stack.peek()).isNull()
      }

      @Test
      fun random() {
        val rand = ThreadLocalRandom.current()
        val ctrl = ArrayDeque<Int>()

        for (n in 0..100) {
          val v = rand.nextInt(1000)
          val add = rand.nextInt(0, 3) // [0, 1, 2]: pop if 0, else push
          when(add) {
            1, 2 -> {
              ctrl.addLast(v)
              stack.push(v)
            }
            else -> {
              assertThat(stack.pop()).isEqualTo(ctrl.removeLastOrNull())
            }
          }
        }

        while (ctrl.isNotEmpty()) {
          assertThat(stack.pop()).isEqualTo(ctrl.removeLastOrNull())
        }
        assertThat(stack.empty).isTrue()
      }

    }
    ```

=== "From raw arrays"

    ```java linenums="1"
    public class Stack {

      private static final int DEFAULT_CAPACITY = 10;

      private int[] underlying;
      private int top;

      public Stack() {
        underlying = new int[DEFAULT_CAPACITY];
        top = 0;
      }

      public void push(int value) {
        resize();
        underlying[top++] = value;
      }

      public Integer pop() {
        if (isEmpty()) return null;
        // For non-primitive types, don't forget to underlying[top-1] = null, to avoid memory leaks.
        return underlying[--top];
      }

      public Integer peek() {
        if (isEmpty()) return null;
        return underlying[top-1];
      }

      private void resize() {
        if (top < underlying.length) return; // top = size, and thus out of bounds

        int[] newUnderlying = new int[underlying.length * 2];
        System.arraycopy(underlying, 0, newUnderlying, 0, underlying.length);
        underlying = newUnderlying;
      }

      public int size() {
        return top;
      }

      public boolean isEmpty() {
        return top == 0;
      }
    }
    ```

## Comparison

<div id="impl"></div>

Not too bad.

??? Code

    ```java linenums="1"
    @Test
    public void benchmark() {
      // warmup
      treatPush(10000);
      ctrlPush(10000);

      System.out.println("[\"Size\", \"% diff\"],");
      for (int n : new int[]{
          1_000, 2_000, 3_000, 4_000, 5_000, 6_000, 7_000, 8_000, 9_000,
          10_000, 20_000, 30_000, 40_000, 50_000, 60_000, 70_000, 80_000, 90_000,
          100_000, 200_000, 300_000, 400_000, 500_000, 600_000, 700_000, 800_000, 900_000,}) {
        long before = System.nanoTime();
        treatPush(n);
        long treat = System.nanoTime() - before;

        before = System.nanoTime();
        ctrlPush(n);
        long ctrl = System.nanoTime() - before;

        float diff = 1f * (treat - ctrl) / ctrl;

        System.out.printf("[%d, %.4f],\n", n, diff);
        System.gc(); // ritual
      }
    }

    public void treatPush(int size) {
      Stack stack = new Stack();
      ThreadLocalRandom rand = ThreadLocalRandom.current();

      while (size-- > 0) {
        stack.push(rand.nextInt());
      }
    }

    public void ctrlPush(int size) {
      Stack stack = new Stack();
      ThreadLocalRandom rand = ThreadLocalRandom.current();

      while (size-- > 0) {
        stack.push(rand.nextInt());
      }
    }
    ```

<script type="text/javascript">
  function chart() {
    var data = google.visualization.arrayToDataTable(
      [
        ["Size", "% diff"],
        [1000, -0.1310],
        [2000, 0.3438],
        [3000, 0.0793],
        [4000, 0.0962],
        [5000, 0.1538],
        [6000, 0.0674],
        [7000, 0.0551],
        [8000, 0.0436],
        [9000, 0.0735],
        [10000, -0.0097],
        [20000, -0.0104],
        [30000, -0.0954],
        [40000, 0.0447],
        [50000, -0.1332],
        [60000, 1.2380],
        [70000, 0.1159],
        [80000, 0.0844],
        [90000, -0.5606],
        [100000, -0.0703],
        [200000, -0.3494],
        [300000, -0.0196],
        [400000, -0.3990],
        [500000, -0.1987],
        [600000, -0.1665],
        [700000, -0.0051],
        [800000, -0.0768],
        [900000, -0.0852],
      ]
    );

    var options = {
      title: '% of push time for custom stack implementation against stock ArrayDeque',
      curveType: 'function',
      explorer: {
      },
      hAxis: {
        title: 'input size',
        logScale: true,
      },
      vAxis: {
        title: '% time diff',
        viewWindow: {
          min: -0.6,
          max: 1.5
        },
        format: 'percent',
        gridlines: {
          minSpacing: 10
        },
      }
    };

    const chart = new google.visualization.LineChart(document.getElementById('impl'));
    chart.draw(data, options);
  };
  google.charts.setOnLoadCallback(chart);
</script>
