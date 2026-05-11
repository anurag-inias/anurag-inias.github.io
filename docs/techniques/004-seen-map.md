# Seen map

Traverse a list in left-to-right or right-to-left direction while saving the elements seen into a map.

$$
seen[a_i] = i
$$

## Variant

Instead of saving the actual elements, save the cumulative sum seen at each index.

$$
seen{\Big [}\sum_{j = 0}^i a_j{\Big ]} = i
$$

This can useful for calculating sum of arbitrary subarrays in $O(1)$ time.