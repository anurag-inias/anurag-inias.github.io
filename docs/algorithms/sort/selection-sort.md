# Selection Sort

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style>
.md-logo img {
  content: url('/algorithms/sort/sort-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/sort/sort-dark.svg');
}
</style>

- Finds the smallest element in the array and swaps it to position $0$.
- Then finds the second smallest element in the array and swaps it to position $1$.
- $\dots$
- Profit

## Implementation

=== "Golang"

    ```golang linenums="1" title="selectionsort.go"
    func SelectionSort(a []int) {
      if len(a) == 0 {
        return
      }

      // c = where to place the smallest number next found
      for c := 0; c < len(a)-1; c++ { // ▧▧▧▧▧□ last number will be the largest anyway
        minIndex := c
        for i := c + 1; i < len(a); i++ { // □▣▧▧▧▧ find the next smallest element in subarray to the right of c
          if a[i] < a[minIndex] {
            minIndex = i
          }
        }
        if minIndex != c {
          a[minIndex], a[c] = a[c], a[minIndex]
        }
      }
    }
    ```

=== "Unit tests"

    ```golang linenums="1" title="sort_test.go"
    package libs

    import (
      "fmt"
      rand2 "math/rand"
      "slices"
      "testing"
    )

    type Suite struct {
      input, expected []int
    }

    func TestEmpty(t *testing.T) {
      var a []int
      SelectionSort(a)
      if fmt.Sprintf("%v", a) != "[]" {
        t.Fatalf("Expected an empty slice")
      }
    }

    func TestSimple(t *testing.T) {
      suite := []Suite{
        {input: []int{}, expected: []int{}},
        {input: []int{1}, expected: []int{1}},
        {input: []int{1, 2}, expected: []int{1, 2}},
        {input: []int{2, 1}, expected: []int{1, 2}},
        {input: []int{1, 2, 3}, expected: []int{1, 2, 3}},
        {input: []int{1, 3, 2}, expected: []int{1, 2, 3}},
        {input: []int{2, 1, 3}, expected: []int{1, 2, 3}},
        {input: []int{2, 3, 1}, expected: []int{1, 2, 3}},
        {input: []int{3, 1, 2}, expected: []int{1, 2, 3}},
        {input: []int{3, 2, 1}, expected: []int{1, 2, 3}},
        {input: []int{1, 2, 3, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 2, 4, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 3, 2, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 3, 4, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 4, 2, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{1, 4, 3, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 1, 3, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 1, 4, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 3, 1, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 3, 4, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 4, 1, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{2, 4, 3, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 1, 2, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 1, 4, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 2, 1, 4}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 2, 4, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 4, 1, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{3, 4, 2, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 1, 2, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 1, 3, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 2, 1, 3}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 2, 3, 1}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 3, 1, 2}, expected: []int{1, 2, 3, 4}},
        {input: []int{4, 3, 2, 1}, expected: []int{1, 2, 3, 4}},
      }

      for _, entry := range suite {
        before := fmt.Sprintf("%v", entry.input)
        SelectionSort(entry.input)
        result := fmt.Sprintf("%v", entry.input)
        expected := fmt.Sprintf("%v", entry.expected)

        if result != expected {
          t.Fatalf("With %v expected %s, but got %s", before, expected, result)
        }
      }
    }

    func TestFuzzy(t *testing.T) {
      var treat, ctrl []int
      rand := rand2.New(rand2.NewSource(100))

      for i := 0; i < 100; i++ {
        value := rand.Intn(50)
        treat = append(treat, value)
        ctrl = append(ctrl, value)
      }

      slices.Sort(ctrl)
      SelectionSort(treat)

      result := fmt.Sprintf("%v", treat)
      expected := fmt.Sprintf("%v", ctrl)

      if result != expected {
        t.Fatalf("expected %s, but got %s", expected, result)
      }
    }
    ```

## Complexity

The outermost loop has size $n-1$. The inner loop performs $n-1$ iterations in first loop, $n-2$ in second loop, $n-3$ in third loop and so on.

$$
\begin{alignat}{1}
(n-1) + (n-2) + (n-3) + \dots + 1 &= \text{sum of first }n-1\text{ natural numbers} \\
&= (n-1) \cdot \dfrac{1 + (n-1)}{2} \\
&= O(n^2)
\end{alignat}
$$

| Scenario | Comparisons | Swaps  |
| -------- | ----------- | ------ |
| Worst    | $O(n^2)$    | $O(n)$ |
| Average  | $O(n^2)$    | $O(n)$ |
| Best     | $O(n^2)$    | $O(1)$ |

## Optimization

Notice that in each inner loop is spent finding the next smallest number, and we haven't made use of any of previous searches.

_Heap sort_ is the implementation of selection sort with the right data structure.
