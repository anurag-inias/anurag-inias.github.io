# Min/Max Stack

We can implement a stack that can support `min`/`max` operation alongside the usual stack methods.

## Explanation

Let $m < M$ and let

<div markdown class="grid">

<div markdown>
$$
\begin{align}
min\_stack &= [\dots, M) \\
min &= M \\
\end{align}
$$
</div>

<div markdown>
$$
\begin{align}
max\_stack &= [\dots, m) \\
max &= m \\
\end{align}
$$
</div>

<div markdown>Pushing $e \ge min$ is straightforward.</div>

<div markdown>Pushing $e \le max$ is straightforward.</div>

<div markdown>
$$
\begin{align}
min\_stack &= [\dots, M, e) \\
min &= M \\
\end{align}
$$
</div>

<div markdown>
$$
\begin{align}
max\_stack &= [\dots, m, e) \\
max &= m \\
\end{align}
$$
</div>

<div markdown>Pushing $e < min$ requires encoding $e$ such that the raw $top$ appears to violate the contract.</div>

<div markdown>Pushing $e > max$ requires encoding $e$ such that the raw $top$ appears to violate the contract.</div>

<div markdown>
$$
\begin{align}
m &< M \\
m + m &< M + m \\
2m - M &< m \\
top &< min
\end{align}
$$
</div>

<div markdown>
$$
\begin{align}
m &< M \\
m + M &< M + M \\
M &< 2M - m \\
max &< top
\end{align}
$$
</div>

</div>

This is our cue that the $top$ is an encoded element.

<div markdown class="grid">

<div markdown>
$$
\begin{align}
min\_stack &= [\dots, M, 2m - M) \\
min &= m
\end{align}
$$
</div>

<div markdown>
$$
\begin{align}
max\_stack &= [\dots, m, 2M - m) \\
max &= M
\end{align}
$$
</div>

The real $top$ is $min$ and when we pop it, we need to recover the previous $min$.

The real $top$ is $max$ and when we pop it, we need to recover the previous $max$.

<div markdown>
$$
\begin{align}
pop &= min \\
min &= 2 \cdot min - top \\
&= 2m - (2m - M) \\
&= M
\end{align}
$$
</div>

<div markdown>
$$
\begin{align}
pop &= max \\
max &= 2 \cdot max - top \\
&= 2M - (2M - m) \\
&= m
\end{align}
$$
</div>

</div>

## Implementation

<div markdown class="grid">

<div markdown>
```kotlin title="MinStack.kt" hl_lines="11 19 29"
private var min = 0
private val stack = ArrayDeque<Int>()

fun min(): Int? {
  if (stack.isEmpty()) return null
  return min
}

fun peek(): Int? {
  if (stack.isEmpty()) return null
  if (stack.last() < min) return min
  return stack.last()
}

fun push(e: Int) {
  if (stack.isEmpty()) {
    stack.addLast(e)
    min = e
  } else if (e < min) {
    stack.addLast(2 * e - min)
    min = e
  } else {
    stack.addLast(e)
  }
}

fun pop(): Int? {
  if (stack.isEmpty()) return null
  if (stack.last() < min) {
    return min.also {
      min = 2 * min - stack.removeLast()
    }
  }
  return stack.removeLast()
}
```

</div>

<div markdown>
```kotlin title="MaxStack.kt" hl_lines="11 19 29"
private var max = 0
private val stack = ArrayDeque<Int>()

fun max(): Int? {
  if (stack.isEmpty()) return null
  return max
}

fun peek(): Int? {
  if (stack.isEmpty()) return null
  if (stack.last() > max) return max
  return stack.last()
}

fun push(e: Int) {
  if (stack.isEmpty()) {
    stack.addLast(e)
    max = e
  } else if (e > max) {
    stack.addLast(2 * e - max)
    max = e
  } else {
    stack.addLast(e)
  }
}

fun pop(): Int? {
  if (stack.isEmpty()) return null
  if (stack.last() > max) {
    return max.also {
      max = 2 * max - stack.removeLast()
    }
  }
  return stack.removeLast()
}
```
</div>

</div>

## Unit tests

??? "Expand"

    <div markdown class="grid">

    ```kotlin
    import org.assertj.core.api.Assertions.assertThat
    import org.junit.jupiter.api.Test

    class MinStackTest {

      @Test
      fun `empty stack`() {
        val stack = MinStack()

        assertThat(stack.isEmpty()).isTrue()
        assertThat(stack.size()).isEqualTo(0)
        assertThat(stack.peek()).isNull()
        assertThat(stack.min()).isNull()
        assertThat(stack.pop()).isNull()
      }

      @Test
      fun `single element`() {
        val stack = MinStack()

        stack.push(1)

        assertThat(stack.isEmpty()).isFalse()
        assertThat(stack.size()).isEqualTo(1)
        assertThat(stack.peek()).isEqualTo(1)
        assertThat(stack.min()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(1)

        assertThat(stack.isEmpty()).isTrue()
        assertThat(stack.size()).isEqualTo(0)
        assertThat(stack.peek()).isNull()
        assertThat(stack.min()).isNull()
        assertThat(stack.pop()).isNull()
      }

      @Test
      fun `three element descending`() {
        val stack = MinStack()

        stack.push(3)
        stack.push(2)
        stack.push(1)

        assertThat(stack.min()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(1)
        assertThat(stack.min()).isEqualTo(2)
        assertThat(stack.pop()).isEqualTo(2)
        assertThat(stack.min()).isEqualTo(3)
        assertThat(stack.pop()).isEqualTo(3)
        assertThat(stack.min()).isNull()
        assertThat(stack.pop()).isNull()
      }

      @Test
      fun `three element ascending`() {
        val stack = MinStack()

        stack.push(1)
        stack.push(2)
        stack.push(3)

        assertThat(stack.min()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(3)
        assertThat(stack.min()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(2)
        assertThat(stack.min()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(1)
        assertThat(stack.min()).isNull()
        assertThat(stack.pop()).isNull()
      }

      @Test
      fun `three element mixed`() {
        val stack = MinStack()

        stack.push(1)
        stack.push(3)
        stack.push(2)

        assertThat(stack.min()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(2)
        assertThat(stack.min()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(3)
        assertThat(stack.min()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(1)
        assertThat(stack.min()).isNull()
        assertThat(stack.pop()).isNull()
      }
    }
    ```

    ```kotlin
    import org.assertj.core.api.Assertions.assertThat
    import org.junit.jupiter.api.Test

    class MaxStackTest {

      @Test
      fun `empty stack`() {
        val stack = MaxStack()

        assertThat(stack.isEmpty()).isTrue()
        assertThat(stack.size()).isEqualTo(0)
        assertThat(stack.peek()).isNull()
        assertThat(stack.max()).isNull()
        assertThat(stack.pop()).isNull()
      }

      @Test
      fun `single element`() {
        val stack = MaxStack()

        stack.push(1)

        assertThat(stack.isEmpty()).isFalse()
        assertThat(stack.size()).isEqualTo(1)
        assertThat(stack.peek()).isEqualTo(1)
        assertThat(stack.max()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(1)

        assertThat(stack.isEmpty()).isTrue()
        assertThat(stack.size()).isEqualTo(0)
        assertThat(stack.peek()).isNull()
        assertThat(stack.max()).isNull()
        assertThat(stack.pop()).isNull()
      }

      @Test
      fun `three element descending`() {
        val stack = MaxStack()

        stack.push(3)
        stack.push(2)
        stack.push(1)

        assertThat(stack.max()).isEqualTo(3)
        assertThat(stack.pop()).isEqualTo(1)
        assertThat(stack.max()).isEqualTo(3)
        assertThat(stack.pop()).isEqualTo(2)
        assertThat(stack.max()).isEqualTo(3)
        assertThat(stack.pop()).isEqualTo(3)
        assertThat(stack.max()).isNull()
        assertThat(stack.pop()).isNull()
      }

      @Test
      fun `three element ascending`() {
        val stack = MaxStack()

        stack.push(1)
        stack.push(2)
        stack.push(3)

        assertThat(stack.max()).isEqualTo(3)
        assertThat(stack.pop()).isEqualTo(3)
        assertThat(stack.max()).isEqualTo(2)
        assertThat(stack.pop()).isEqualTo(2)
        assertThat(stack.max()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(1)
        assertThat(stack.max()).isNull()
        assertThat(stack.pop()).isNull()
      }

      @Test
      fun `three element mixed`() {
        val stack = MaxStack()

        stack.push(1)
        stack.push(3)
        stack.push(2)

        assertThat(stack.max()).isEqualTo(3)
        assertThat(stack.pop()).isEqualTo(2)
        assertThat(stack.max()).isEqualTo(3)
        assertThat(stack.pop()).isEqualTo(3)
        assertThat(stack.max()).isEqualTo(1)
        assertThat(stack.pop()).isEqualTo(1)
        assertThat(stack.max()).isNull()
        assertThat(stack.pop()).isNull()
      }
    }
    ```

    </div>