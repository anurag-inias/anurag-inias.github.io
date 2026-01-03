# Generating powerset

Given a set $1, 2, 3, \dots, n$, we can generate the power set in two ways.

## Iterative

## Iterative approach
Each subset is the result of the choice "do I include index $i$ in this set?". For example, given the set $\{1, 2, 3\}$, we can list all the subsets as the result of yes/no answers:

1. $\{0, 0, 0\} = \{\}$
2. $\{0, 0, 1\} = \{3\}$
3. $\{0, 1, 0\} = \{2\}$
4. $\{0, 1, 1\} = \{2, 3\}$
5. $\{1, 0, 0\} = \{1\}$
6. $\{1, 0, 1\} = \{1, 3\}$
7. $\{1, 1, 0\} = \{1, 2\}$
8. $\{1, 1, 1\} = \{1, 2, 3\}$

Notice that this just the range $[0, 1, 2, \dots, 2^{n})$. We can leverage this to generate the power set iteratively.

```kotlin
fun powerset(nums: IntArray) {  
  for (n in 0 until (1 shl nums.size)) { // iterate over the power set.  
    
    val set = mutableSetOf<Int>()  
    for (i in nums.indices) {  
      if ((n and (1 shl i)) != 0) {      // index i is included in this set  
        set.add(nums[i])  
      }  
    }  
    println(set)  
    
  }  
}
```

## Backtracking approach

```kotlin
fun powerset(nums: IntArray) {  
  val powerset = mutableSetOf<Set<Int>>()  
  
  fun backtrack(i: Int, set: MutableSet<Int>) {  
    // reached leaf node of backtracking tree.
    if (i >= nums.size) {
      powerset.add(set.toSet()) // copy set.
      return  
    }  
  
    backtrack(i + 1, set.toMutableSet())             // without i
    backtrack(i + 1, (set + nums[i]).toMutableSet()) // with i 
  }  
  
  backtrack(0, mutableSetOf())    
}
```