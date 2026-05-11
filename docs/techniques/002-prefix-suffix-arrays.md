## Prefix/Suffix arrays

This is a powerful technique to efficiently calculate the sum of elements within any subarray while traversing left or right.

```kotlin
val left = IntArray(nums.size)
left[0] = nums[0]

for (i in 1 until nums.size) {
  left[i] = left[i-1] + nums[i]
}
```

## Avoiding extra space

Sometimes it is possible to avoid the auxiliary space allotment. Instead of saving the prefix/suffix sums, you can calculated on the fly:

$$
\begin{align}
S_l + n + S_r &= S \\
S_r &= S - n - S_l
\end{align}
$$

```kotlin
val total = nums.sum()
var left = 0

for (i in nums.indices) {
  val right = total - nums[i] - left

  // You logic goes here.

  left += nums[i]
}
```

## Subarray sums

Prefix sum array can be used to calculate the sum of arbitrary subarrays in $O(1)$ time. However, if you are checking all subarrays, that'll anyway take $O(n^2)$ to enumerate. 


```kotlin
val prefix = IntArray(nums.size)
prefix[0] = nums[0]
for (i in 1 until nums.size) {
  prefix[i] = prefix[i-1] + nums[i]
}

// Arbitrary subarray [start, end].
val prev = if (start == 0) 0 else prefix[start-1]
val sum = prefix[end] - prev
```



```
[1, 2, 3, 4, 5, 6]
nums[0:0] = 1, nums[0:1] = 3, nums[0:2] = 6, nums[0:3] = 10, nums[0:4] = 15, nums[0:5] = 21
nums[1:1] = 2, nums[1:2] = 5, nums[1:3] = 9, nums[1:4] = 14, nums[1:5] = 20
nums[2:2] = 3, nums[2:3] = 7, nums[2:4] = 12, nums[2:5] = 18
nums[3:3] = 4, nums[3:4] = 9, nums[3:5] = 15
nums[4:4] = 5, nums[4:5] = 11
nums[5:5] = 6
```