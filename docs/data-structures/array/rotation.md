# Rotation


## Description

Given an array $a$ of $n$ elements, we are asked to move array elements by $k$ steps to the right.

## Rotation via juggling


### Explanation

With the Juggling algorithm, the core idea is to divide the array into `gcd(n, k)` sets. Each set's elements are rotated among themselves.

=== "$n = 18, k = 12, \ \text{gcd}(12, 18) = 6$"

	The algorithm divides the input array in $6$ sequences, each of which is rotated within itself.

	$$
	\begin{align}
	& \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{11} \ \boxed{12} \ \boxed{13} \ \boxed{14} \  \boxed{15} \ \boxed{16} \ \boxed{17} \\
	\phantom{\text{group = 0 }} &
	\end{align}
	$$

	$$
	\begin{align}
	\text{group = 0 } & \boxed{\phantom 1 \textbf{0}} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{\phantom 1 \textbf{6}} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{11} \ \boxed{\textbf{12}} \ \boxed{13} \ \boxed{14} \  \boxed{15} \ \boxed{16} \ \boxed{17} \\
	& \boxed{\phantom 1 \textbf{6}} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{\textbf{12}} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{11} \ \boxed{\phantom 1 \textbf{0}} \ \boxed{13} \ \boxed{14} \  \boxed{15} \ \boxed{16} \ \boxed{17} \\
	\end{align}
	$$

	$$
	\begin{align}
	\text{group = 1 } & \boxed{\phantom 1 6} \ \boxed{\phantom 1 \textbf 1} \ \boxed{\phantom 1 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{12} \ \boxed{\phantom 1 \textbf 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{11} \ \boxed{\phantom 1 0} \ \boxed{\textbf{13}} \ \boxed{14} \  \boxed{15} \ \boxed{16} \ \boxed{17} \\
	& \boxed{\phantom 1 6} \ \boxed{\phantom 1 \textbf 7} \ \boxed{\phantom 1 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{12} \ \boxed{\textbf{13}} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{11} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 \textbf 1} \ \boxed{14} \  \boxed{15} \ \boxed{16} \ \boxed{17} \\
	\end{align}
	$$

	$$
	\begin{align}
	\text{group = 2 } & \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 \textbf 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{12} \ \boxed{13} \ \boxed{\phantom 1 \textbf 8} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{11} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\textbf{14}} \  \boxed{15} \ \boxed{16} \ \boxed{17} \\
	& \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 \textbf 8} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{12} \ \boxed{13} \ \boxed{\textbf{14}} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{11} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 \textbf 2} \  \boxed{15} \ \boxed{16} \ \boxed{17} \\
	\end{align}
	$$

	$$
	\begin{align}
	\text{group = 3 } & \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 \textbf 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{12} \ \boxed{13} \ \boxed{14} \ \boxed{\phantom 1 \textbf 9} \ \boxed{10} \ \boxed{11} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \  \boxed{\textbf{15}} \ \boxed{16} \ \boxed{17} \\
	& \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 \textbf 9} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{12} \ \boxed{13} \ \boxed{14} \ \boxed{\textbf{15}} \ \boxed{10} \ \boxed{11} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \  \boxed{\phantom 1 \textbf 3} \ \boxed{16} \ \boxed{17} \\
	\end{align}
	$$

	$$
	\begin{align}
	\text{group = 4 } & \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{\phantom 1 \textbf 4} \ \boxed{\phantom 1 5} \ \boxed{12} \ \boxed{13} \ \boxed{14} \ \boxed{15} \ \boxed{\textbf{10}} \ \boxed{11} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \  \boxed{\phantom 1 3} \ \boxed{\textbf{16}} \ \boxed{17} \\
	& \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{\textbf{10}} \ \boxed{\phantom 1 5} \ \boxed{12} \ \boxed{13} \ \boxed{14} \ \boxed{15} \ \boxed{\textbf{16}} \ \boxed{11} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \  \boxed{\phantom 1 3} \ \boxed{\phantom 4 \textbf 4} \ \boxed{17} \\
	\end{align}
	$$

	$$
	\begin{align}
	\text{group = 5 } & \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{\phantom 1 \textbf 5} \ \boxed{12} \ \boxed{13} \ \boxed{14} \ \boxed{15} \ \boxed{16} \ \boxed{\textbf{11}} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \  \boxed{\phantom 1 3} \ \boxed{\phantom 4 4} \ \boxed{\textbf{17}} \\
	& \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{\textbf{11}} \ \boxed{12} \ \boxed{13} \ \boxed{14} \ \boxed{15} \ \boxed{16} \ \boxed{\textbf{17}} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \  \boxed{\phantom 1 3} \ \boxed{\phantom 4 4} \ \boxed{\phantom 1 \textbf{5}} \\
	\end{align}
	$$

	$$
	\begin{align}
	& \boxed{\phantom 1 6} \ \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 9} \ \boxed{10} \ \boxed{11} \ \boxed{12} \ \boxed{13} \ \boxed{14} \ \boxed{15} \ \boxed{16} \ \boxed{17} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \  \boxed{\phantom 1 3} \ \boxed{\phantom 4 4} \ \boxed{\phantom 1 5} \\
	\phantom{\text{group = 0 }} &
	\end{align}
	$$

=== "$n = 7, k = 3, \ \text{gcd}(7, 3) = 1$"

	The algorithm divides the input array in just $1$ sequence. This sequence ends up wrapping around the array, covering all indices.

	$$
	\begin{align}
	& \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{\phantom 1 6} \\
	\phantom{\text{group = 0 }} &
	\end{align}
	$$

	$$
	\begin{align}
	\text{group = 0 } & \boxed{\phantom 1 \textbf 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \ \boxed{\phantom 1 \textbf 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{\phantom 1 \textbf 6} \\
	& \boxed{\phantom 1 7} \ \boxed{\phantom 1 8} \ \boxed{\phantom 1 \textbf 9} \ \boxed{10} \ \boxed{11} \ \boxed{\textbf{12}} \ \boxed{13} = \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 \textbf 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 \textbf 5} \ \boxed{\phantom 1 6} \\
	& \boxed{14} \ \boxed{\textbf {15}} \ \boxed{16} \ \boxed{17} \ \boxed{\textbf{18}} \ \boxed{19} \ \boxed{20} = \boxed{\phantom 1 0} \ \boxed{\phantom 1 \textbf 1} \ \boxed{\phantom 1 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 \textbf 4} \ \boxed{\phantom 1 5} \ \boxed{\phantom 1 6} \\
	& \boxed{\textbf{21}} \ \boxed{22} \ \boxed{23}  \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  \ \ \ \ \ \ = \boxed{\phantom 1 \textbf 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \\
	\phantom{\text{group = 0 }} &
	\end{align}
	$$

	This means that $0$ is overwritten with $3$, which is overwritten with $6$ and so on:

	$$
	\begin{align}
	\phantom 1 0 \leftarrow \phantom 1 3 \leftarrow \phantom 1 6 & \leftarrow \phantom 1 9 (2) \leftarrow 12 (5) \leftarrow 15 (1) \leftarrow 18 (4) \leftarrow 21 (0) \\
	\end{align}
	$$

	$$
	\begin{align}
	& \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \ \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{\phantom 1 6} \\
	& \boxed{\phantom 1 3} \ \boxed{\phantom 1 4} \ \boxed{\phantom 1 5} \ \boxed{\phantom 1 6} \ \boxed{\phantom 1 0} \ \boxed{\phantom 1 1} \ \boxed{\phantom 1 2} \\
	\phantom{\text{group = 0 }} &
	\end{align}
	$$

### Pseudocode

First sanitize the input. $k$ can be greater than `nums.length` or even negative. 

$$
k = (n + k \ \% \ n) \ \% \ n
$$

Next we need divide the array in $g = gcd(n, k)$ groups:

1. First group starts from index $0$.
2. Second ground starts from index $1$.
3. ...
4. Last group starts from $g - 1$.

For each group `i` we do the following:

1. Backup the first element of the group `temp = a[i]`.

2. set `curr = i` and `next = (curr + k) % n`.

3. until we circle back to the beginning of the group (`next != start`), do:
	
	- shuffle elements forward `a[curr] = a[next]` and `curr = next`.

	- update `next = (curr + k) % n`.

4. now that we are back to the beginning, restored the backed up element `a[curr] = temp`.

### Implementation

```kotlin
fun rotateRight(nums: IntArray, k: Int): IntArray {
	val n = nums.size
	val k = (n + k % n) % n

	for (start in 0 until gcd(n, k)) {
		val backup = nums[start]
		var curr = start
		var next = (curr + k) % n

		while (next != start) {
			nums[curr] = nums[next]
			curr = next
			next = (curr + k) % n
		}

		nums[curr] = backup
	}
	return nums
}

fun gcd(a: Int, b: Int): Int {
	var (x, y) = a to b
	while (y != 0) {
		// swap
		x = y.also { y = x % y }
	}
	return x
}
```

## Rotation via reversal

There is a much more straightforward way to achieve rotatation through reversing segments of the array. While previous approach takes just a single pass of the array, this one does two passes. Yet surprisingly, it ends up being way faster.


### Explanation

Rotation to the right by $k$ steps is same as:

1. reversing the whole array $a$.
2. reversing the elements $a_0, a_1, \dots, a_{k-1}$.
3. reversing the elements $a_{k+1}, a_{k+2}, \dots, a_{n-1}$.

![](rotation-1.png)

Rotation to the left by $k$ steps is same as:

1. reversing the elements $a_0, a_1, \dots, a_{k-1}$.
2. reversing the elements $a_{k+1}, a_{k+2}, \dots, a_{n-1}$.
3. reversing the whole array $a$.

![](rotation-2.png)

### Implementation

```kotlin
fun rotateRight(nums: IntArray, k: Int): IntArray {
  val n = nums.size
  val k = (n + k % n) % n // (1)
  nums.reverse(0, n)
  nums.reverse(0, k)
  nums.reverse(k, n)
  return nums
}

private fun IntArray.reverse(start: Int, end: Int) {
  var l = start
  var r = end - 1
  while (l < r) {
    val t = this[l]
    this[l++] = this[r]
    this[r--] = t
  }
}
```

1. Handling negative modulo. Since `-7 % 5 = -2`, i.e., modulo operation carries the sign, we need to pacify `k % n` by `k % n + n`. And to account for positive `k`, we do another `% n` just in case.

## Comparison

By all accounts, juggling algorithm should be faster than the double reversal algorithm. After all, juggling algorithm is doing a single pass on the input whereas double reversal algorithm is doing 2x passes. However, double reversal has several points in its favour:

**Spatial Locality (The Cache Line Factor)**
		 
:	Modern CPUs do not read memory one byte at a time; they read chunks called Cache Lines (typically 64 bytes). Since addresses `i`, `i+1`, `i+2`, ... are next to each other, the CPU loads a cache line once and uses every single byte in that chunk before needing to fetch from main RAM again. This is excellent Spatial Locality.

	Compare this to Juggling algorithm that is **striding** across indices, going from `i` to `i+k`. If `k` is large, CPU ends up fetching a whole cache line just to read a single integer and this causes frequent Cache Misses.

**Hardware prefetching**

: With reversal algorithm, the pattern is incredibly simple (linear walk). The hardware prefetcher easily detects this and pulls data into the cache before your code even asks for it.

	Juggling algorithm's "jump by `k`" is much harder to predict.

**Translation Lookaside Buffer (TLB) Thrashing**

: For very large arrays, the reversal algorithm stays within a specific page of memory for a long time. 

	The Juggling algorithm, by jumping large distances may constantly jump between different memory pages.