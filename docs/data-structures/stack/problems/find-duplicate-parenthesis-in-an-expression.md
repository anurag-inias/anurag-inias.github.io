# Find duplicate parenthesis in an expression

<style>
.md-logo img {
  content: url('/data-structures/stack/stack.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/stack/stack.svg');
}
</style>

## Problem

Given an expression, find out whether there are redundant parenthesis.

## Example

- `(x+y)` no redundant parenthesis.
- `((x+y))` has redundant parenthesis.
- `((x+y)+z)` no redundant parenthesis.
- `(((x+y))+z)` no redundant parenthesis.

## Hint

??? "First"

    What's the difference between these two?

    $$
    \begin{alignat}{1}
    & \hspace{3.1em} \downarrow \\
    & ((x+y)) \\
    & \hspace{2em} \text{vs}\\
    & ((x+y)+z) \\
    & \hspace{3.6em} \uparrow \\
    \end{alignat}
    $$

??? "Second"

    It's not just the parenthesis that can go in the stack.

## Solution

??? "Expand"

    ```golang linenums="1"
    func HasDuplicateParenthesis(expression string) bool {
      s := NewStack[rune]()

      for _, r := range expression {
        if r == ')' {
          nonempty := false
          for p, ok := s.Pop(); ok; p, ok = s.Pop() {
            nonempty = nonempty || p != '('
          }
          if !nonempty {
            return true
          }
        } else {
          s.Push(r)
        }
      }

      return false
    }
    ```

## Unit tests

```golang linenums="1"
import "testing"

type example struct {
	expression   string
	hasDuplicate bool
}

func TestHasDuplicateParenthesis(t *testing.T) {
	examples := []example{
		example{"(x+y)", false},
		example{"((x+y))", true},
		example{"(z)", false},
		example{"((z))", true},
		example{"((x+y)+z)", false},
		example{"(((x+y))+z)", true},
	}
	for _, ex := range examples {
		if HasDuplicateParenthesis(ex.expression) != ex.hasDuplicate {
			t.Fatalf("HasDuplicateParenthesis(%q) = %v", ex.expression, ex.hasDuplicate)
		}
	}
}
```
