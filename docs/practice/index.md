# Practice

<style>
.md-logo img {
  content: url('/practice/practice-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/practice/practice-dark.png');
}
</style>

| Serial | Description                                                                                                                                             |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1.     | <a target="_blank" href="/practice/list-all-binary-strings-generated-from-wildcard-pattern">List all binary strings generated from wildcard pattern</a> |
| 2.     | <a target="_blank" href="/practice/merge-overlapping-intervals">Merge overlapping intervals</a>                                                         |
| 3.     | <a target="_blank" href="/practice/longest-common-prefix">Longest common prefix</a>                                                                     |
| 4.     | <a target="_blank" href="/practice/generate-pascals-triangle-row">Generate Specified Row of Pascal's Triangle</a>                                       |
| 5.     | <a target="_blank" href="./find-the-only-non-duplicate">Find the only non-duplicate number in an array</a>                                              |

## Learnings from Online Judges

### `LinkedList` vs `ArrayList`

By all accounts, `ArrayList` should be much faster than `LinkedList` as both stack and queue. Yet I've noticed significant time improvements with `LinkedList`.

The rationale behind it is that an online judge consideres the time it took for your solution to execute and not how long it'll subsequently take to use the answer to use in real life programs.

So `LinkedList` can be way faster than `ArrayList`, allocating memory for individual items, as opposed to allocating for larger and larger contiguous blocks.

### Recursion vs Iteration

Conventional wisdom is that iterative algorithms is just going to be faster than recursion. Yet with online judges I can see the opposite. Recursive algorithms are not online faster, they take less memory too, even without tail recursion.

There could be a number of explanation behind it:

- an explicit stack could be an overhead in itself compared to an implicit frame which could be optimized a lot by the compiler or by hardware level instructions.
- branch predicition for recursion could be outperforming those for iteration.

So, don't be hasty. Write first the natural solution (i.e. recursion) and then profile it against an iterative solution. Or in other words, don't just write off recursive solutions as slow.
