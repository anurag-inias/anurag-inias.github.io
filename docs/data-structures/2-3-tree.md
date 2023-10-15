# 2-3 Tree

## Introduction

Maintaining perfect balance is often too expensive. 2-3 Search tree slightly relaxes the perfect balance requirement to provide guranteed logarithmic performance.

We introduce the idea of _multiple keys_ per node. Specificially, allowing 2 keys per-node (i.e. 3 child nodes). 

```
     2                2,4
   ┌─┴─┐            ┌──┼──┐ 
   1   3            1  3  5
normal 2-node      new 3-node
```

In a 3-node, with keys $p$ and $q$:

- left node points to subtree with keys $<p$.
- middle node points to subtree with keys in interval $[p, q)$.
- right node points to subtree with keys $\ge q$.

## Search

Identical to search in BST.

## Insertion

Insertion in 2-3 Search tree is where differences emerge: 

1. It starts out as conventional insertion in a BST where we first do an unsuccessful search for the key to be inserted. 
2. The new key is never added as a child node, instead the would-be parent absorbs the new key. A 2-node is promoted to 3-node, and a 3-node promoted to 4-node.
3. This being a 2-3 Search tree, the resultant 2-node / 3-node are left as is.
4. The 4-nodes, however, are _unstable_ and are "splintered" (not a standard term).
5. This splinter then traverses upwards to the root.

### Examples

1. Inserting a key into a normal 2-node:
   ```
      2                       2 
    ┌─┴─┐   - Insert 4 ->   ┌─┴──┐ 
    1   3                   1   3,4
   ```

2. Inserting a key into a 3-node:
   ```
     2,4                    4   
   ┌──┼──┐ - Insert 5 ->  ┌─┴─┐
   Ø  Ø  Ø                2   5
   ```
   Key $4$ here becomes the parent of $2$ and $5$. If they already had a parent, then $4$ will be absorbed into that instead.
   ```
    3                      3                          3,4     
   ─┴─┐                   ─┴─┐                      ┌──┼──┐     
     2,4   - Insert 5 ->   2,4,5    - splinter ->   2  Ø  5
   ┌──┼──┐               (unstable)  
   ```
   And we can intuit from here that if the parent itself was on verge of splinter (i.e. a 3-node), then it would've splintered itself, creating a chain reaction upstream.

The source of balance in 2-3 Search tree is this operation:

```
  2,4                    4   
┌──┼──┐ - Insert 5 ->  ┌─┴─┐
Ø  Ø  Ø                2   5
```

it's a way to push a key down, demoting it from parent to child, and thus balancing the tree.
