# Evaluate postfix expression

<style>
.md-logo img {
  content: url('/data-structures/stack/stack.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/stack/stack.svg');
}
</style>

## Problem

Given an expression in postfix notation, evaluate its value.

Also known as _Reverse Polish Notation_, it's a notation in which operators follow their operands.

## Example

$$
\begin{alignat}{1}
3 \ 4  \ + &= 7 \\
1 \ 5  \ 7 \ * \ + &= 36 \\
\end{alignat}
$$

## Hint

??? "Expand"

    Not all operators are [commutativity](/maths/arithmetic-laws).

## Solution

??? "Expand"

    ```golang linenums="1"
    func EvaluatePostfix(expression string) int {
      stack := NewStack[int]()
      for _, token := range strings.Split(expression /* sep= */, " ") {
        switch token {
        case "+":
          {
            b, _ := stack.Pop()
            a, _ := stack.Pop()
            stack.Push(a + b)
          }
        case "-":
          {
            b, _ := stack.Pop()
            a, _ := stack.Pop()
            stack.Push(a - b)
          }
        case "*", "x":
          {
            b, _ := stack.Pop()
            a, _ := stack.Pop()
            stack.Push(a * b)
          }
        case "/", "÷":
          {
            b, _ := stack.Pop()
            a, _ := stack.Pop()
            stack.Push(a / b)
          }
        case "^":
          {
            b, _ := stack.Pop()
            a, _ := stack.Pop()
            stack.Push(int(math.Pow(float64(a), float64(b))))
          }
        case "++":
          {
            a, _ := stack.Pop()
            stack.Push(a + 1)
          }
        case "--":
          {
            a, _ := stack.Pop()
            stack.Push(a - 1)
          }
        default:
          {
            if i, err := strconv.Atoi(token); err == nil {
              stack.Push(i)
            }
          }
        }
      }
      result, _ := stack.Pop()
      return result
    }
    ```

## Unit tests

```golang linenums="1"
func TestEvaluatePostfix(t *testing.T) {
	type example struct {
		expression string
		expected   int
	}

	examples := []example{
		{"6 2 +", 8},
		{"6 2 *", 12},
		{"6 2 x", 12},
		{"6 2 /", 3},
		{"6 2 ÷", 3},
		{"6 2 -", 4},
		{"6 2 ^", 36},
		{"3 ++", 4},
		{"3 --", 2},
	}

	for _, ex := range examples {
		if EvaluatePostfix(ex.expression) != ex.expected {
			t.Fatalf("EvaluatePostfix(%q) = %v", ex.expression, ex.expected)
		}
	}
}
```
