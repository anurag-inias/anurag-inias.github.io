# Addition

<style>
.md-logo img {
  content: url('/data-structures/numbers/binary-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/numbers/binary-dark.svg');
}
</style>

## Addition

```
carry     1 1              1 1
          1 2 3            9 9 5
        + 7 8 9          + 6 7 9
        -------          -------
          9 1 2          1 6 7 4
```

carry will always be $0$ or $1$.

## Addition

```
carry     1 1              1 1
          4 5 6            9 9 5
        + 7 8 9          + 6 7 9
        -------          -------
          9 1 2          1 6 7 4
```

carry will always be $0$ or $1$.

```kotlin linenums="1"
fun add(a: String, b: String): String {
  if (!a.isInt || !b.isInt) throw IllegalArgumentException("both arguments must be valid integers")
  if (a == "0") return b
  if (b == "0") return a
  if (a.negative && b.negative) return add(a.abs, b.abs).negate   // -a + (-b) = -(a + b)
  if (a.negative) return subtract(b, a.abs)                       // -a + b = b - a
  if (b.negative) return subtract(a, b.abs)                       // a + (-b) = a - b

  val sb = StringBuilder()
  var carry = 0
  var i = a.length - 1
  var j = b.length - 1

  while (i >= 0 && j >= 0) {
    val s = (a[i--] - '0') + (b[j--] - '0') + carry
    sb.append((s % 10).digitToChar())
    carry = s / 10
  }
  while (i >= 0) {
    val s = (a[i--] - '0') + carry
    sb.append((s % 10).digitToChar())
    carry = s / 10
  }
  while (j >= 0) {
    val s = (b[j--] - '0') + carry
    sb.append((s % 10).digitToChar())
    carry = s / 10
  }
  if (carry > 0) {
    sb.append(carry.digitToChar())
  }

  return sb.reverse().toString()
}
```

## Subtraction

Subtracting a smaller number from a larger number is simple. We keep borrowing $10$ when needed.

```
borrow         10 10
             9  1  2
           - 2  4  5
           ---------
             6  6  7
```

but what happens when subtracting larger number from a smaller number?

```
borrow       10 10 10 10 10
              0  0  2  4  1           9  7  2
            - 0  0  9  7  2         - 2  4  1
        -------------------         ---------
        .  .  9  9  2  6  9           7  3  1
```

we are left with $10's$ complement format for a negative number, which is an infinite sequence of $9s$ to the left. This is same as $1000-731=\overline{\dots999}269$.

```kotlin linenums="1"
fun subtract(a: String, b: String): String {
  if (!a.isInt || !b.isInt) throw IllegalArgumentException("both arguments must be valid integers")
  if (a == "0") return b.negate // 0 - (-b) = b
  if (b == "0") return a        // a - 0 = a
  if (a.negative && b.negative) return subtract(b.abs, a.abs) // -a - (-b) = b - a
  if (a.negative) return add(a.abs, b).negate                 // -a - b = - (a + b)
  if (b.negative) return add(a, b.abs)                        // a - (-b) = a + b
  if (greater(b, a)) return subtract(b, a).negate             // a - bb = - (bb - a)

  val sb = StringBuilder()
  var carry = 0
  var i = a.length - 1
  var j = b.length - 1

  while (i >= 0 && j >= 0) {
    val p = a[i--].digitToInt() - carry
    val q = b[j--].digitToInt()

    val d = if (p >= q) {
      carry = 0
      p - q
    } else {
      carry = 1
      p + 10 - q
    }
    sb.append(d.digitToChar())
  }
  while (i >= 0) {
    val p = a[i--].digitToInt() - carry
    val d = if (p >= 0) {
      carry = 0
      p
    } else {
      carry = 1
      10 + p
    }
    sb.append(d.digitToChar())
  }
  while (sb.last() == '0' && sb.length > 1) {
    sb.setLength(sb.length - 1)
  }
  return sb.reverse().toString()
}
```

## Helpers

```kotlin linenums="1"
fun greater(a: String, b: String): Boolean {
  if (!a.isInt || !b.isInt) throw IllegalArgumentException("both arguments must be valid integers")
  if (a == "0") return b.negative
  if (b == "0") return !a.negative
  if (a.negative && b.negative) return !greater(a.abs, b.abs)  // -a > -b  => b > a
  if (a.negative) return false                                 // -a < b
  if (b.negative) return true                                  // a > -b
  if (a.length > b.length) return true                         // aa > b
  if (a.length < b.length) return false                        // a < bb

  for (i in 0..a.length) {
    when {
      a[i] > b[i] -> return true
      a[i] < b[i] -> return false
    }
  }

  return false
}

private val String.isInt: Boolean
  get() = this.matches(Regex("-?\\d+"))

private val String.negative: Boolean
  get() = first() == '-'

private val String.negate: String
  get() = if (negative) abs else "-$this"

private val String.abs: String
  get() = if (negative) substring(1) else this // drop - if negative
```

## Unit test

```kotlin linenums="1"
@Test
fun add() {
  val rand = ThreadLocalRandom.current()
  for (i in 0..10_000) {
    val a = rand.nextInt(-10_0000, 10_0000)
    val b = rand.nextInt(-10_0000, 10_0000)
    assertThat(add(a.toString(), b.toString())).isEqualTo((a + b).toString())
  }
}

@Test
fun subtract() {
  val rand = ThreadLocalRandom.current()
  for (i in 0..10_000) {
    val a = rand.nextInt(-10_0000, 10_0000)
    val b = rand.nextInt(-10_0000, 10_0000)
    assertThat(subtract(a.toString(), b.toString())).isEqualTo((a - b).toString())
  }
}
```
