# Decode increment decrement sequence

## Problem

Given a sequence of `I` and `D`, where `I` requires increasing the sequence and `D` requires decreasing it; decode the this sequence into a number that's as minimum as possible such that no digit is repeated.

## Examples

| sequence | result |
| -------- | ------ |
| `II`     | `123`  |
| `DD`     | `321`  |
| `IDD`    | `1431` |
| `DID`    | `2143` |

## Hint

??? "Expand"

    How can I get `12` from `I` and `21` from `D`? Combine the two.

## Solution

??? "Pseudocode"

    - Start with a stack with just one value $1$, and an empty string `result`.
    - If a `D` is encountered, simply push `peek() + 1`.
    - If an `I` is encountered
         - save `peek() + 1`
         - pop stack until it's empty and append its content to `result`.
         - push the saved `peek() + 1` back on stack.
    - pop stack until it's empty and append its content to `result`
    - return result

??? "Explanation"

    At every point, we want to place the smallest number that is viable, so we start with $1$, and we don't want to repeat no digit, so we keep incrementing the next digit to be placed with `peek() + 1`.

    We start with a solution for homogeneous sequences:

    - We start with `[1` as stack.
    - `D -> 21`, so we push `2` in `[1,`.
    - `DD -> 321`, so we push `3` in `[1,2`.
    - `DDD -> 4321`, so we push `4` in `[1,2,3`.
    - In opposite direction, `I -> 12`, so we pop `1` from the stack and then push `2`.
    - `II -> 123`, so we pop `1` from ths stack, push `2`, and then again pop `2` from the stack only to push `3`.
    - Combine the two, that's our solution.

??? "Example"

    For $I$: we start with `[1` in stack and `result = ""`. Pop out stack until it's empty, which gives us `result = "1"`, and then we push `1+1` to stack. Finally we pop stack until it's empty, which gives `result = "12"`.

    For $D$: we start with `[1` in stack and `result = ""`. We push `1+1` to stack. and then we pop stack until it's empty, which gives `result = "21"`.

    For $DD$: we start with `[1` in stack and `result = ""`. We push `1+1` to stack and then push `2+1` to stack. Finally we pop stack until it's empty, which gives `result = "321"`.

??? "Golang"

    ```golang linenums="1"
    func DecodeSequence(expression string) string {
      result := strings.Builder{}
      stack := NewStack[int]()
      stack.Push(1)

      for _, r := range expression {
        if r == 'D' {
          max, _ := stack.Peek()
          stack.Push(max + 1)
        } else {
          max, _ := stack.Peek()
          stack.PopAll(func(i int) bool {
            result.WriteString(fmt.Sprintf("%d", i))
            return true
          })
          stack.Push(max + 1)
        }
      }
      stack.PopAll(func(i int) bool {
        result.WriteString(fmt.Sprintf("%d", i))
        return true
      })
      return result.String()
    }
    ```

## Unit tests

```golang linenums="1"
func TestDecodeSequence(t *testing.T) {
	type example struct {
		expression, expected string
	}

	examples := []example{
		{"I", "12"},
		{"D", "21"},
		{"ID", "132"},
		{"DI", "213"},
		{"II", "123"},
		{"DD", "321"},
		{"IDD", "1432"},
		{"DID", "2143"},
		{"IDIDII", "1325467"},
		{"IIDDIDID", "125437698"},
	}
	for _, ex := range examples {
		if DecodeSequence(ex.expression) != ex.expected {
			t.Fatalf("DecodeSequence(%q) = %v", ex.expression, ex.expected)
		}
	}
}
```
