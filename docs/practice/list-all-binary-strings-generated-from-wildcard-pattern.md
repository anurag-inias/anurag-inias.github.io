# List all binary strings generated from wildcard pattern

<style>
.md-logo img {
  content: url('/practice/practice-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/practice/practice-dark.png');
}
</style>

## Problem

Given a binary string with random wildcard placements, generate all unique binary strings.

## Example

```
1?

10
11
```

```
1?01?

10010
10011
11010
11011
```

## Hint

??? "Expand"

    Recursion.

## Solution

??? "Expand"

    ```kotlin linenums="1"
    fun wildcardBinary(
      pattern: String,
    ): List<String> {
      return helper(0, pattern.toCharArray())
        .map { b -> b.reverse().toString() }
    }

    private fun helper(
      startIndex: Int,
      pattern: CharArray,
    ): List<StringBuilder> {
      if (startIndex >= pattern.size) {
        return mutableListOf(StringBuilder())
      }
      val remaining = helper(startIndex + 1, pattern)

      if (pattern[startIndex] == '?') {
        // Duplicate the list.
        return remaining.map { b -> StringBuilder(b).append('0') } +
            remaining.map { b -> b.append('1') }
      } else {
        return remaining.map { b -> b.append(pattern[startIndex]) }
      }
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun wildcardBinary_empty() {
  assertThat(wildcardBinary("")).containsOnly("")
}

@Test
fun wildcardBinary_single() {
  assertThat(wildcardBinary("1")).containsOnly("1")
  assertThat(wildcardBinary("0")).containsOnly("0")
  assertThat(wildcardBinary("?")).containsOnly("0", "1")
}

@Test
fun wildcardBinary_double() {
  assertThat(wildcardBinary("00")).containsOnly("00")
  assertThat(wildcardBinary("01")).containsOnly("01")
  assertThat(wildcardBinary("10")).containsOnly("10")
  assertThat(wildcardBinary("11")).containsOnly("11")
  assertThat(wildcardBinary("0?")).containsOnly("00", "01")
  assertThat(wildcardBinary("?0")).containsOnly("00", "10")
  assertThat(wildcardBinary("1?")).containsOnly("10", "11")
  assertThat(wildcardBinary("?1")).containsOnly("01", "11")
}

@Test
fun wildcardBinary_triple() {
  assertThat(wildcardBinary("00?")).containsOnly("000", "001")
  assertThat(wildcardBinary("0?0")).containsOnly("000", "010")
  assertThat(wildcardBinary("?00")).containsOnly("000", "100")
  assertThat(wildcardBinary("0??")).containsOnly("000", "001", "010", "011")
}

@Test
fun wildcardBinary_example() {
  assertThat(wildcardBinary("1?11?00?1?")).containsOnly(
    "1011000010",
    "1011000011",
    "1011000110",
    "1011000111",
    "1011100010",
    "1011100011",
    "1011100110",
    "1011100111",
    "1111000010",
    "1111000011",
    "1111000110",
    "1111000111",
    "1111100010",
    "1111100011",
    "1111100110",
    "1111100111",
  )
}
```
