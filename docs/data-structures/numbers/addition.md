# Addition

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

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

@Test
fun random() {
  for (n in listOf(100, 200, 500)) {
    val first = generateBigIntegerString(n)
    val second = generateBigIntegerString(n)
    assertThat(add(first, second)).isEqualTo(BigInteger(first).add(BigInteger(second)).toString())
    assertThat(subtract(first, second)).isEqualTo(BigInteger(first).subtract(BigInteger(second)).toString())
  }
}
```

## Benchmark

How does it compare against `BigInt`?

<div id="addition_chart"></div>

<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawAdditionChart);

function drawAdditionChart() {
  var data = google.visualization.arrayToDataTable([
    ['n', 'control', 'treatment'],
    [100, 719.82, 440818.27],
    [1000, 2431.91, 151863.55],
    [10000, 20730.91, 626371.09],
    [20000, 38113.64, 331640.00],
    [50000, 50697.27, 772840.82],
    [100000, 54072.09, 840162.82],
  ]);

  var options = {
    title: 'BigInt vs Custom',
    curveType: 'function',
    legend: { position: 'bottom' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('addition_chart'));

  chart.draw(data, options);
} 

</script>

Oof! There are a whole bunch of optimizations possible here, but I don't quite care about it.

### Setup

```kotlin linenums="1"
@Test
fun benchmark() {
  println("['n', 'control', 'treatment'],")
  for (n in listOf(100, 1000, 10_000, 20_000, 50_000, 100_000)) {
    val control = addLargeNumberControl(n)
    val treatment = addLargeNumberTreat(n)
    println("[$n, %.2f, %.2f],".format(control, treatment))
  }
}

fun addLargeNumberControl(n: Int): Double {
  val diffs = mutableListOf<Long>()
  for (i in 0..10) {
    val first = BigInteger(generateBigIntegerString(n))
    val second = BigInteger(generateBigIntegerString(n))
    val before = System.nanoTime()
    first.add(second)
    diffs.add(System.nanoTime() - before)
  }
  return diffs.average()
}

fun addLargeNumberTreat(n: Int): Double {
  val diffs = mutableListOf<Long>()
  for (i in 0..10) {
    val first = generateBigIntegerString(n)
    val second = generateBigIntegerString(n)
    val before = System.nanoTime()
    add(first, second)
    diffs.add(System.nanoTime() - before)
  }
  return diffs.average()
}

fun generateBigIntegerString(n: Int): String {
  val rand = ThreadLocalRandom.current()
  val sb = StringBuilder().append(rand.nextInt(1, 10)) // [1, 9]

  for (i in 1..<n) {
    sb.append(rand.nextInt(0, 10)) // [0, 9]
  }
  return sb.toString()
}
```
