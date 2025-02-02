# Dynamic Programming

<style>
.md-logo img {
  content: url('/algorithms/dynamic-programming/logo-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/dynamic-programming/logo-dark.png');
}
</style>

## DP vs Divide-and-conquer

Dynamic problem is like a generalization of divide-and-conquer strategy.

|             | Divide & Conquer | Dynamic Problem |
| ----------- | ---------------- | --------------- |
| subproblems | disjoint         | overlapping     |
| memoization | no               | yes             |

In divide-and-conquer, the subproblem are disjoint and can be solved just once. In DP, the subproblems overlap which results in wasteful calculations if the results are saved.

## DP vs Greedy

Often, a solution will look viable if pick the path of short-term profit (a local maxima if you will) for each subproblem. This can be a red-herring when discretization is involved. See for example the Knapsack problem vs its 0-1 variant.
