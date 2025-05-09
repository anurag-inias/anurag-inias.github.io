# Check if a given expression is balanced or not

## Problem

Given a string made up of parentheses `()`, brackets `[]`, and braces `{}`, see if makes a valid expression.

## Example

| Valid    | Invalid  |
| -------- | -------- |
| `()`     | `(]`     |
| `[]{}()` | `{()}[)` |
| `{{}{}}` | `{(})`   |

## Hint

??? "Expand"

    Really?

## Solution

??? "Expand"

    ```golang linenums="1"
    func isValid(expression string) bool {
      s := NewStack[rune]()
      for _, r := range expression {
        if r == '[' || r == '{' || r == '(' {
          s.Push(r)
          continue
        }
        if p, ok := s.Pop(); !ok || p != opener(r) {
          return false
        }
      }
      return s.IsEmpty()
    }

    func opener(closer rune) rune {
      switch closer {
      case ']':
        return '['
      case '}':
        return '{'
      case ')':
        return '('
      default:
        return '0'
      }
    }
    ```

## Comparison

??? "Expand"

    ![](screenshots/problem-1-light.png#only-light){width=300}
    ![](screenshots/problem-1-dark.png#only-dark){width=300}
