# Reservoir Sampling

Reservoir sampling is a family of randomized algorithms for choosing a random sample, of $k$ items from a population of unknown size.

## Context

We discussed the partial Fisher-Yates shuffle in previous document. Given an input of size $n$, we are asked to come up with a random subset of size $k$.

But what happens when $n \to \infty$? How do we create a uniformly random subset from an ongoing (**live**) stream?

## Algorithm

- Create a reservoir $r$ of size $k$.

- Copy first $k$ elements into $r$ unconditionally.

- Now from $(k+1)^{th}$ elements onwards, we do the following:

	- generate a random index $i = \text{rand}(0, n)$ from range $[0, n)$ where $n$ is the number of elements in the stream so far.

	- If $i$ falls in range $[0, k)$, replace $r[i]$ with the incoming element.