# Bit arithmetic

<style>
.md-logo img {
  content: url('/data-structures/numbers/binary-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/numbers/binary-dark.svg');
}
</style>

<div markdown class="grid">

### Unset rightmost $1$

### Set rightmost $0$

```
       x  = aaaa 1000
     x-1  = aaaa 0111
x & (x-1) = aaaa 0000
```

```
       x  = aaaa 0111
     x+1  = aaaa 1000
x | (x+1) = aaaa 1111
```

### Unset trailing $1s$

### Set trailing $0s$

```
       x  = aaaa 0111
     x+1  = aaaa 1000
x & (x+1) = aaaa 0000
```

```
       x  = aaaa 1000
     x-1  = aaaa 0111
x | (x-1) = aaaa 1111
```

### Isolate rightmost $1$

### Isolate rightmost $0$

```
     x = aaaa 1000
    -x = bbbb 1000 (b = ~a)
x & -x = 0000 1000
```

```
        x = aaaa 0111
     x+1  = aaaa 1000
x ^ (x+1) = 0000 1000
```

</div>

## Powers of 2

A number divisible by $2$ will end with $xxx0$. Similarly:

- a number divisible by $4$ will end with $xxx00$.
- a number divisible by $8$ will end with $xxx000$.
- and so on.

So the greatest power of $2$ that divides a number $n$ is $(n \ \& -n)$.

??? "Examples"

    ```
     1 in binary is 1,      divisible by 1
     2 in binary is 10,     divisible by 2
     3 in binary is 11,     divisible by 1
     4 in binary is 100,    divisible by 4
     5 in binary is 101,    divisible by 1
     6 in binary is 110,    divisible by 2
     7 in binary is 111,    divisible by 1
     8 in binary is 1000,   divisible by 8
     9 in binary is 1001,   divisible by 1
    10 in binary is 1010,   divisible by 2
    11 in binary is 1011,   divisible by 1
    12 in binary is 1100,   divisible by 4
    13 in binary is 1101,   divisible by 1
    14 in binary is 1110,   divisible by 2
    15 in binary is 1111,   divisible by 1
    16 in binary is 10000,  divisible by 16
    17 in binary is 10001,  divisible by 1
    18 in binary is 10010,  divisible by 2
    19 in binary is 10011,  divisible by 1
    20 in binary is 10100,  divisible by 4
    21 in binary is 10101,  divisible by 1
    22 in binary is 10110,  divisible by 2
    23 in binary is 10111,  divisible by 1
    24 in binary is 11000,  divisible by 8
    25 in binary is 11001,  divisible by 1
    26 in binary is 11010,  divisible by 2
    27 in binary is 11011,  divisible by 1
    28 in binary is 11100,  divisible by 4
    29 in binary is 11101,  divisible by 1
    30 in binary is 11110,  divisible by 2
    31 in binary is 11111,  divisible by 1
    32 in binary is 100000, divisible by 32
    33 in binary is 100001, divisible by 1
    34 in binary is 100010, divisible by 2
    35 in binary is 100011, divisible by 1
    36 in binary is 100100, divisible by 4
    ```
