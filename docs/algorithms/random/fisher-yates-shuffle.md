# Fisher-Yates Shuffle

Also known as Knuth shuffle algorithm, is an algorithm for shuffling a finite sequence.

## Pseudocode

Consider an array $num$ of $n$ elements, indexed $[0, n)$.

$\textbf{for } i \in n-1 \textbf{ down to } 1:$ <br>
&nbsp; &nbsp; $j = \text{random}(0, i)$ <br>
&nbsp; &nbsp; $\text{swap}(i, j)$

## Explanation

1. Split the array in two parts: first part is unshuffled (i.e. being processed) and the second part that's already shuffled. Much like an insertion sort run.
2. In the beginning, the first part is the whole array, and the second part is empty.
3. Then, in each iteration, pick a random number from the first part and insert it into the second part.
4. As the algorithm runs, the first part shrinks and the second part grows.

## Partial Fisher-Yates

Let's say we are given $n$ numbers and are asked to come up with a random subset of size $k$. 

```kotlin
// Shuffles `A` such that the first `k` elements are a random subset of the original input `A`
fun randomSampling(k: Int, A: MutableList<Int>) {
	val rand = ThreadLocalRandom.current()

	for (i in 0 until k) {
		val j = rand.nextInt(i, A.size)
		A.swap(i, j)
	}
}
```

For index $i \in [0, k)$, replace it with a random pick from $[i, n)$.

- for index $0$, replace it with a random pick from $[0, n)$
- for index $1$, replace it with a random pick from $[1, n)$
- for index $2$, replace it with a random pick from $[2, n)$
- for index $3$, replace it with a random pick from $[3, n)$
- and so on.

i.e. once an element of the $k$ sized subset is fixed, we leave it be and don't consider for future draws.