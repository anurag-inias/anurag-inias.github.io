# Insertion Sort

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style>
.md-logo img {
  content: url('/algorithms/sort/sort-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/algorithms/sort/sort-dark.svg');
}
</style>

1. Start with a subarray containing just the very first element of the array. The subarray is sorted by the virtue of containing just one element.

2. Pick the element just right of the subarray and find an appropriate place within the sorted subarray to insert.

3. Shuffle elements to the right to make place.

4. Back to #2.

## Implementation

=== "Golang"

    ```golang linenums="1" title="insertionsort.go"
    package libs

    func InsertionSort(a []int) {
      if len(a) == 0 {
        return
      }
      for e := 1; e < len(a); e++ {
        insert(a, e, a[e])
      }
    }

    // 012e
    // ▧▧▧▣□□□
    // □ not yet processed
    // ▣ element being inserted
    // ▧ elements already sorted
    func insert(a []int, e, value int) {
      i := e - 1
      for i >= 0 {
        if a[i] < value {
          break
        }
        a[i+1], i = a[i], i-1
      }
      a[i+1] = value
    }
    ```

=== "Unit tests"

    ```golang linenums="1" title="sort_tests.go"
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
      InsertionSort(a)
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
        InsertionSort(entry.input)
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
      InsertionSort(treat)

      result := fmt.Sprintf("%v", treat)
      expected := fmt.Sprintf("%v", ctrl)

      if result != expected {
        t.Fatalf("expected %s, but got %s", expected, result)
      }
    }
    ```

## Complexity

| Scenario | Comparisons | Swaps    |
| -------- | ----------- | -------- |
| Worst    | $O(n^2)$    | $O(n^2)$ |
| Average  | $O(n^2)$    | $O(n^2)$ |
| Best     | $O(n)$      | $O(1)$   |

## Properties

- In partially sorted and smaller arrays, insertion sort performs very well.
- In worst case scenario, insertion sort ends up doing too many writes due to the shuffling.
