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
