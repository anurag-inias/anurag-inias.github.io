# Bubble Sort

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style>
.md-logo img {
  content: url('/algorithms/sort/sort-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/sort/sort-dark.svg');
}
</style>

Also known as _Sinking sort_. Works by repeatedly
swapping adjacent elements that are out of order.

## Implementation

=== "Golang"

    ```golang linenums="1" title="bubblesort.go"
    func BubbleSort(a []int) {
      if len(a) == 0 {
        return
      }

      // ▧ processed element
      // □ ignored element
      // ▣ cursored element (where i is at)
      for i := 0; i < len(a)-1; i++ { // ▧▧▧▧▧□ all but last
        for j := i + 1; j < len(a); j++ { // □▣▧▧▧▧ everything after i
          if a[i] > a[j] {
            a[i], a[j] = a[j], a[i]
          }
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
      BubbleSort(a)
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
        BubbleSort(entry.input)
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
      BubbleSort(treat)

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
