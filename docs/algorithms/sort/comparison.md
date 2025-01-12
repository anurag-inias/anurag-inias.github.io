# Comparison Sorts

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style>
.md-logo img {
  content: url('/algorithms/sort/sort-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/sort/sort-dark.svg');
}

.green {
  background-color: #e2f6d3;
  color: rgb(32, 33, 36);
}

.yellow {
  background-color: #fff8b8;
  color: rgb(32, 33, 36);
}

.red {
  background-color: #f6e2dd;
  color: rgb(32, 33, 36);
}
</style>

| Algorithm      | Best                  | Average               | Worst                 | Memory                | Stable                       |
| -------------- | --------------------- | --------------------- | --------------------- | --------------------- | ---------------------------- |
| Bubble sort    | $O(n)$ {.green}       | $O(n^2)$ {.red}       | $O(n^2)$ {.red}       | $O(1)$ {.green}       | :octicons-check-16: {.green} |
| Insertion sort | $O(n)$ {.green}       | $O(n^2)$ {.red}       | $O(n^2)$ {.red}       | $O(1)$ {.green}       | :octicons-check-16: {.green} |
| Selection sort | $O(n^2)$ {.red}       | $O(n^2)$ {.red}       | $O(n^2)$ {.red}       | $O(1)$ {.green}       | :octicons-x-16: {.red}       |
| Heapsort       | $O(n\log n)$ {.green} | $O(n\log n)$ {.green} | $O(n\log n)$ {.green} | $O(1)$ {.green}       | :octicons-x-16: {.red}       |
| Quicksort      | $O(n\log n)$ {.green} | $O(n\log n)$ {.green} | $O(n^2)$ {.red}       | $O(\log n)$ {.yellow} | :octicons-x-16: {.red}       |
| Merge sort     | $O(n\log n)$ {.green} | $O(n\log n)$ {.green} | $O(n\log n)$ {.green} | $O(n)$ {.red}         | :octicons-check-16: {.green} |

## Recommendation

- Use _Insertion sort_ for small and partially sorted arrays. `Arrays.sort` in Java does so for arrays of size $<7$.
- Use _Heapsort_ when there is a risk of malicious inputs for a guaranteed $O(n\log n)$ performance.
- Use _Merge sort_ when stable sorting is needed.
- _Quicksort_ as default fallback.
