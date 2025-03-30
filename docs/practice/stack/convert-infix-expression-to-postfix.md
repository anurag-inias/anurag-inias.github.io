# Convert infix expression to postfix

## Problem

Convert a given infix expression to a postfix expression

## Examples

| Infix            | Postfix              |
| ---------------- | -------------------- |
| $a+b$            | $a \ b \ +$          |
| $a \times b + c$ | $a \ b \times c \ +$ |
| $a + b \times c$ | $a \ b \ c \times +$ |

## Hint

??? "First"

    Operands come out first in postfix notation. We need to delay operators from being appended in postfix expression somehow.

    $$
    \begin{alignat}{1}
    \fbox a + b & \rightarrow \fbox a \ b \ + \\
    \dots \\
    a + \fbox b & \rightarrow a \ \fbox b \ +
    \end{alignat}
    $$

??? "Second"

    In the first expression we put $+$ on hold. In second, we need to expedite $\times$ instead. How do we do that?

    $$
    \begin{alignat}{1}
    a + b & \ \fbox{$\times$} \ c \\
    a \times b & \ \fbox + \ c \\
    \end{alignat}
    $$

## Solution

??? "Pseudocode"

    Process the expression token-by-token. If the token is:

    1. `(` push it on stack.
    2. `)` pop stack's content on `postfix` expression until `(` is encountered.
    3. _Operand_ then simply append it to `postfix` expression.
    4. _Operator_ then remove all operators from stack with higher precedence. This is how we delay addition in $a + b \ \times \ c$.

    After this, empty the stack and append its content to `postfix` expression.

??? "Code"

    ```kotlin linenums="1"
    fun infixToPostfix(expression: String): String {
      val postfix = ArrayList<String>()
      val stack = ArrayDeque<String>()

      for (token in expression.split(" ")) {
        when {
          token.isOpeningParenthesis -> stack.addLast(token)
          token.isClosingParenthesis -> {
            while (!stack.last().isOpeningParenthesis) {
              postfix.add(stack.removeLast())
            }
            stack.removeLast() // also remove (
          }
          token.isOperand -> postfix.add(token)
          token.isOperator -> {
            while (stack.isNotEmpty()
              && stack.last().precedence >= token.precedence) {
              postfix.add(stack.removeLast())
            }
            stack.addLast(token)
          }
        }
      }

      while (stack.isNotEmpty()) {
        postfix.add(stack.removeLast())
      }

      return postfix.joinToString(" ")
    }

    private val String.precedence: Int
      get() = when(this) {
        "*","/" -> 2
        "+","-" -> 1
        else -> Int.MIN_VALUE // (
      }

    private val String.isOpeningParenthesis: Boolean
      get() = this == "("

    private val String.isClosingParenthesis: Boolean
      get() = this == ")"

    private val String.isOperator: Boolean
      get() = this in listOf("+", "-", "*", "/")

    private val String.isOperand: Boolean
      get() = !isOperator && !isOpeningParenthesis && !isClosingParenthesis
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun simple() {
  assertThat(infixToPostfix("A + B")).isEqualTo("A B +")
  assertThat(infixToPostfix("( A / B )")).isEqualTo("A B /")

  assertThat(infixToPostfix("A + B + C")).isEqualTo("A B + C +")
  assertThat(infixToPostfix("A * B + C")).isEqualTo("A B * C +")
  assertThat(infixToPostfix("A + B * C")).isEqualTo("A B C * +")

  assertThat(infixToPostfix("( A + B ) * ( C / D )")).isEqualTo("A B + C D / *")
  assertThat(infixToPostfix("( A + B ) * C + ( D - E ) / F + G"))
    .isEqualTo("A B + C * D E - F / + G +")
}
```
