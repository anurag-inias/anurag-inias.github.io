## Converging pointers

Useful for sorted inputs. Start with pointers, one on each end and start moving them inwards depending on the conditions.

## Example

```kotlin
fun findPair(nums: IntArray, target: Int): IntArray {
  var l = 0
  var r = nums.lastIndex

  while (l < r) {
    val sum = nums[l] + nums[r]

    when(sum.compareTo(target)) {
      -1 -> l++ // (1)
       0 -> return intArrayOf(nums[l], nums[r])
       1 -> r-- // (2)
    }
  }

  return intArrayOf()
}
```

1. $sum < target$
2. $sum > target$