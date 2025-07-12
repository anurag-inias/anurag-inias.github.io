# Design a stack that supports peeking minimum element

## Problem

Build a stack which can be queried for $minimum$ element in an efficient manner.

## Hint

??? "Expand"

    $2 \times m - M$

## Solution

??? "Explanation"

    Let's assume the stack is in some arbitrary state, with the current top being $x$ and minimum value in the stack being $t$ (for tiny).

    $$
    \begin{alignat}{1}
    \text{stack} & \Rightarrow \ [ \overline{ \underline{ \ \dots \ x \vphantom{|} } } \\
    \text{min} & \Rightarrow t \\
    \end{alignat}
    $$

    <div markdown class="grid">

    <div markdown>

    $push$ a value $m < t$ after mutating:

    $$
    \begin{alignat}{1}
    \text{stack} & \Rightarrow \ [ \overline{ \underline{ \ \dots \ x \ \ (2m - t) \vphantom{|} } } \\
    \text{min} & \Rightarrow \not{t} \ m \\
    \end{alignat}
    $$

    </div>

    <div markdown>

    $push$ a value $M \ge t$ as is:

    $$
    \begin{alignat}{1}
    \text{stack} & \Rightarrow \ [ \overline{ \underline{ \ \dots \ x \ \ M \vphantom{|} } } \\
    \text{min} & \Rightarrow t \\
    \end{alignat}
    $$

    </div>

    <div markdown>

    $pop$ on the other hand:

    $$
    \begin{alignat}{1}
    min() & = min \\
    &= m \\
    pop() & = min \\
    & = m \\
    \end{alignat}
    $$

    only addition is that we have to update $min$ value on $pop$:

    $$
    \begin{alignat}{1}
    new \ min & = 2 \cdot min - top \\
    & = t \\
    \end{alignat}
    $$

    </div>

    <div markdown>

    $pop$ on the other hand:

    $$
    \begin{alignat}{1}
    min() & = min \\
    &= t \\
    pop() & = top \\
    & = M \\
    \end{alignat}
    $$

    </div>

    </div>

    How do we distinguish between the two cases during $pop$?

    $$
    \begin{alignat}{1}
    m & < t \\
    2m & < t + m \\
    2m -t & < m \\
    \Rightarrow top & < min
    \end{alignat}
    $$

??? "Implementation"

    ```kotlin linenums="1"
    import kotlin.math.max

    class Stack {

      private var underlying = ArrayList<Int>()
      private var minimum = Int.MAX_VALUE

      val empty: Boolean
        get() = underlying.isEmpty()

      val size: Int
        get() = underlying.size

      fun push(value: Int) {
        if (empty) {
          underlying.add(value)
          minimum = value
          return
        }
        if (value >= minimum) {
          underlying.add(value)
          return
        }
        underlying.add(2 * value - minimum)
        minimum = value
      }

      fun pop(): Int? {
        if (empty) return null

        return peek()?.also {
          val top = underlying.removeLast()

          if (minimum > top) {
            minimum = 2 * minimum - top
          }
        }
      }

      fun peek(): Int? {
        if (empty) return null

        val top = underlying.last()
        return max(top, minimum)
      }

      fun min(): Int? = if (empty) {
        null
      } else {
        minimum
      }
    }
    ```

## Unit tests

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
  fun simple_increasing() {
    assertThat(stack.peek()).isNull()
    assertThat(stack.pop()).isNull()

    stack.push(1)
    assertThat(stack.peek()).isEqualTo(1)
    assertThat(stack.min()).isEqualTo(1)

    stack.push(2)
    assertThat(stack.peek()).isEqualTo(2)
    assertThat(stack.min()).isEqualTo(1)

    stack.push(3)
    assertThat(stack.peek()).isEqualTo(3)
    assertThat(stack.min()).isEqualTo(1)

    stack.push(4)
    assertThat(stack.peek()).isEqualTo(4)
    assertThat(stack.min()).isEqualTo(1)

    assertThat(stack.pop()).isEqualTo(4)
    assertThat(stack.peek()).isEqualTo(3)
    assertThat(stack.min()).isEqualTo(1)

    assertThat(stack.pop()).isEqualTo(3)
    assertThat(stack.peek()).isEqualTo(2)
    assertThat(stack.min()).isEqualTo(1)

    assertThat(stack.pop()).isEqualTo(2)
    assertThat(stack.peek()).isEqualTo(1)
    assertThat(stack.min()).isEqualTo(1)

    assertThat(stack.pop()).isEqualTo(1)
    assertThat(stack.peek()).isNull()
    assertThat(stack.min()).isNull()

    assertThat(stack.pop()).isNull()
  }

  @Test
  fun simple_decreasing() {
    assertThat(stack.peek()).isNull()
    assertThat(stack.pop()).isNull()

    stack.push(4)
    assertThat(stack.peek()).isEqualTo(4)
    assertThat(stack.min()).isEqualTo(4)

    stack.push(3)
    assertThat(stack.peek()).isEqualTo(3)
    assertThat(stack.min()).isEqualTo(3)

    stack.push(2)
    assertThat(stack.peek()).isEqualTo(2)
    assertThat(stack.min()).isEqualTo(2)

    stack.push(1)
    assertThat(stack.peek()).isEqualTo(1)
    assertThat(stack.min()).isEqualTo(1)

    assertThat(stack.pop()).isEqualTo(1)
    assertThat(stack.peek()).isEqualTo(2)
    assertThat(stack.min()).isEqualTo(2)

    assertThat(stack.pop()).isEqualTo(2)
    assertThat(stack.peek()).isEqualTo(3)
    assertThat(stack.min()).isEqualTo(3)

    assertThat(stack.pop()).isEqualTo(3)
    assertThat(stack.peek()).isEqualTo(4)
    assertThat(stack.min()).isEqualTo(4)

    assertThat(stack.pop()).isEqualTo(4)
    assertThat(stack.peek()).isNull()
    assertThat(stack.min()).isNull()

    assertThat(stack.pop()).isNull()
  }

  @Test
  fun simple_increasing_decreasing() {
    assertThat(stack.peek()).isNull()
    assertThat(stack.pop()).isNull()

    stack.push(2)
    assertThat(stack.peek()).isEqualTo(2)
    assertThat(stack.min()).isEqualTo(2)

    stack.push(4)
    assertThat(stack.peek()).isEqualTo(4)
    assertThat(stack.min()).isEqualTo(2)

    stack.push(3)
    assertThat(stack.peek()).isEqualTo(3)
    assertThat(stack.min()).isEqualTo(2)

    stack.push(1)
    assertThat(stack.peek()).isEqualTo(1)
    assertThat(stack.min()).isEqualTo(1)

    assertThat(stack.pop()).isEqualTo(1)
    assertThat(stack.peek()).isEqualTo(3)
    assertThat(stack.min()).isEqualTo(2)

    assertThat(stack.pop()).isEqualTo(3)
    assertThat(stack.peek()).isEqualTo(4)
    assertThat(stack.min()).isEqualTo(2)

    assertThat(stack.pop()).isEqualTo(4)
    assertThat(stack.peek()).isEqualTo(2)
    assertThat(stack.min()).isEqualTo(2)

    assertThat(stack.pop()).isEqualTo(2)
    assertThat(stack.peek()).isNull()
    assertThat(stack.min()).isNull()

    assertThat(stack.pop()).isNull()
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
          assertThat(stack.min()).isEqualTo(ctrl.min())
        }
        else -> {
          assertThat(stack.pop()).isEqualTo(ctrl.removeLastOrNull())
          assertThat(stack.min()).isEqualTo(ctrl.minOrNull())
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
