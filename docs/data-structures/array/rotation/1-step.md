# Rotation by $\pm 1$ step

Rotating an array in either direction sounds like a simple problem, but the challenges show up soon after you start to try and implement it. It's easy to miss out on crucial details if you jump to the solution and don't spend time understanding why we do what we do.

## The wrong approach

```kotlin
fun rotateRight(list: MutableList<Int>) {
  val n = list.size
  if (n < 2) return

  val backup = list[0]
  var curr = 0
  var next = 1
  while (next != 0) {
    list[next] = list[curr]
    curr = next
    next = (curr + 1) % n
  }
  list[curr] = backup
}
```

Running this on $1, 2, 3, 4$ gives us $1, 1, 1, 1$ instead of $4, 1, 2, 3$. 

![](1.svg){width=300px}

There are two key mistakes here:

: - **Backing up the element which is anyway going to overwrite its neighbour.**
  - **Propagating the element which itself was overwritten.**

## The correct approach

<div markdown class="grid">

**to left**

**to right**

```kotlin
fun rotateLeft(list: MutableList<Int>) {
	val n = list.size
	if (n < 1) return

	val backup = list[0]
	for (i in 0 until n-1) {
		list[i] = list[i+1]
	}
	list[n-1] = backup
}
```

```kotlin
fun rotateRightq(list: MutableList<Int>) {
  val n = list.size
  if (n < 1) return

  val backup = list[n-1]
  for (i in n - 1 downTo 1) {
    list[i] = list[i-1]
  }
  list[0] = backup
}
```

<div markdown>

First backup $x_0 = a$.

$$
\begin{align}
& \underline a \ \ \ \ \ \ b \ \ \ \ \ \ c \ \ \ \ \ \ d \\
\end{align}
$$

Then starting from the backed up element, traverse left to right, overwriting the element by its right neighbour.

$$
\begin{align}
& a \leftarrow b \ \ \ \ \ \ c \ \ \ \ \ \ d \\
& b \ \ \ \ \ \ b \leftarrow c \ \ \ \ \ \ d \\
& b \ \ \ \ \ \ c \ \ \ \ \ \ c \leftarrow d \\
& b \ \ \ \ \ \ c \ \ \ \ \ \ d \ \ \ \ \ \ d \\
\end{align}
$$

Then restored the backed up element $x_{n-1} = \text{backup} = a$.

$$
\begin{align}
& b \ \ \ \ \ \ c \ \ \ \ \ \ d \ \ \ \ \ \ \underline d \\
& b \ \ \ \ \ \ c \ \ \ \ \ \ d \ \ \ \ \ \ a
\end{align}
$$

</div>

<div markdown>

First backup $x_{n-1} = d$.

$$
\begin{align}
& a \ \ \ \ \ \ b \ \ \ \ \ \ c \ \ \ \ \ \ \underline d \\
\end{align}
$$

Then starting from the backed up element, traverse right to left, overwriting the element by its left neighbour.

$$
\begin{align}
& a \ \ \ \ \ \ b \ \ \ \ \ \ c \rightarrow d \\
& a \ \ \ \ \ \ b \rightarrow c \ \ \ \ \ \ c \\
& a \rightarrow b \ \ \ \ \ \ b \ \ \ \ \ \ c \\
& a  \ \ \ \ \ \ a \ \ \ \ \ \ b \ \ \ \ \ \ c \\
\end{align}
$$

Then restored the backed up element $x_0 = \text{backup} = d$.

$$
\begin{align}
& \underline a  \ \ \ \ \ \ a \ \ \ \ \ \ b \ \ \ \ \ \ c \\
& d \ \ \ \ \ \ a \ \ \ \ \ \ b \ \ \ \ \ \ c
\end{align}
$$

</div>

</div>