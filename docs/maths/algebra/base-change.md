# Changing Base

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

## Integral part

- Repeatedly divide number by target base $b$.
- Collect remainders $r$ in reverse order.

Take $277_{10}$ as example:

| $\text{quotient}_2$ | $\text{remainder}_2$ | $\text{quotient}_{16}$ | $\text{remainder}_{16}$ |
| ------------------- | -------------------- | ---------------------- | ----------------------- |
| $277 / 2 = 138$     | $1$                  | $277 / 16 = 17$        | $5$                     |
| $138 / 2 = 69$      | $0$                  | $17 / 16 = 1$          | $1$                     |
| $69 / 2 = 34$       | $1$                  | $1 / 16 = 0$           | $1$                     |
| $34 / 2 = 17$       | $0$                  |                        |                         |
| $17 / 2 = 8$        | $1$                  |                        |                         |
| $8 / 2 = 4$         | $0$                  |                        |                         |
| $4 / 2 = 2$         | $0$                  |                        |                         |
| $2 / 2 = 1$         | $0$                  |                        |                         |
| $1 / 2 = 0$         | $1$                  |                        |                         |

thus $277_{10} = 100010101_2 = 115_{16}$. We can verify it back so:

$$
\begin{alignat}{1}
155_{16} & = 1 \cdot 16^2 + 1 \cdot 16^1 + 5 \cdot 16^0 \\
& = 1 \cdot 256 + 1 \cdot 16 + 5 \cdot 1 \\
& = 256 + 16 + 5 \\
& = 277 \\
\\
100010101_2 & = 1 \cdot 2^8 + 0 \cdot 2^7 + 0 \cdot 2^6 + 0 \cdot 2^5 + 1 \cdot 2^4 + 0 \cdot 2^3 + 1 \cdot 2^2 +  0 \cdot 2^1 + 1 \cdot 2^0 \\
& = 1 \cdot 256 + 1 \cdot 16 + 1 \cdot 4 + 1 \cdot 1 \\
& = 256 + 16 + 4 + 1 \\
& = 277
\end{alignat}
$$

## Fractional part

- Repeatedly multiply number with target base $b$.
- Collect integral part in same order.

Take $0.277_{10}$ as example:

| $\text{fractional part}_2$ | $\text{integral part}_2$ | $\text{fractional part}_{16}$ | $\text{integral part}_{16}$ |
| -------------------------- | ------------------------ | ----------------------------- | --------------------------- |
| $0.277 \cdot 2 = 0.554$    | $0$                      | $0.277 \cdot 16 = 4.432$      | $4$                         |
| $0.544 \cdot 2 = 1.088$    | $1$                      | $0.432 \cdot 16 = 6.912$      | $6$                         |
| $0.088 \cdot 2 = 0.176$    | $0$                      | $0.912 \cdot 16 = 15.592$     | $15 = \text{E}$             |
| $0.176 \cdot 2 = 0.352$    | $0$                      | $0.592 \cdot 16 = 9.472$      | $9$                         |
| $0.352 \cdot 2 = 0.704$    | $0$                      | $0.472 \cdot 16 = 7.552$      | $7$                         |
| $0.704 \cdot 2 = 1.408$    | $1$                      | $0.552 \cdot 16 = 8.832$      | $8$                         |
| $...$                      | $...$                    | $...$                         | $...$                       |

and so $0.277_{10} = 0.010001\ldots_2 = 0.46\text{E}978\ldots_{16}$

## Shortcut

Conversion between binary and hexadecimal is straightforward with the lookup table. This would for any bases that are power of $2$ as well.

$$
\begin{array}
  {|r|r|}
  \hline \text{Decimal} & \text{Hexadecimal} & \text{Binary} \\
  \hline 0 & 0 & 0000 \\
  \hline 1 & 1 & 0001 \\
  \hline 2 & 2 & 0010 \\
  \hline 3 & 3 & 0011 \\
  \hline 4 & 4 & 0100 \\
  \hline 5 & 5 & 0101 \\
  \hline 6 & 6 & 0110 \\
  \hline 7 & 7 & 0111 \\
  \hline 8 & 8 & 1000 \\
  \hline 9 & 9 & 1001 \\
  \hline 10 & A & 1010 \\
  \hline 11 & B & 1011 \\
  \hline 12 & C & 1100 \\
  \hline 13 & D & 1101 \\
  \hline 14 & E & 1110 \\
  \hline 15 & F & 1111 \\
  \hline
\end{array}
$$

### Hexadecimal to binary

Replace each hexadecimal digit with equivalent binary word. See the table below for lookup.

$$
\begin{alignat}{1}
\text{A2EB}_{16} & = 1010 \ 0010 \ 1110 \ 1011_{2}
\end{alignat}
$$

### Binary to hexadecimal

Same approach. Starting from the rightmost bits (lsb), replace groups of 4 bits by their equivalent hexadecimal digit. Pad the leftmost bits (msb) with $0$ if needed.

$$
\begin{alignat}{1}
1010 \ 0010 \ 1110 \ 1011_{2} = \text{A2EB}_{16}
\end{alignat}
$$
