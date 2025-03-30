# Practice

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
