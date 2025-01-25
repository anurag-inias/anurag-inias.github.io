# Probability

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

## Sample space

universal set for all questions concerned with the experiment. For example, consider the experiment of tossing two coins:

| Event description                | Subsets of $S$                   |
| -------------------------------- | -------------------------------- |
| Number of tails is atleast 1     | $\lbrace HT, TH, TT\rbrace$      |
| Second toss is not head          | $\lbrace HT, TT\rbrace$          |
| Number of tails is more than two | $\phi$                           |
| Number of tails is at most two   | $\lbrace HH, HT, TH, TT \rbrace$ |

## Event

Any subset $E$ of a sample space $S$ is called an _event_. The types of events are as follows:

### Simple event

an event with only one sample point. For example, in experiment of tossing two coins, the simple events are:

$$
E_1 = \lbrace HH\rbrace, E_2 = \lbrace HT\rbrace, E_3 = \lbrace TH\rbrace, E_4 = \lbrace TT\rbrace
$$

### Compound event

Conversely, an event with more than one sample point is called a _Compound event_. Consider the experiment of tossing a coin thrice:

- _Exactly one head appeared_: $\lbrace HTT, THT, TTH\rbrace$
- _Atmost one head appeared_: $\lbrace TTT, HTT, THT, TTH\rbrace$

## Probability

$$
\begin{alignat}{1}
P(E) &= \dfrac{\text{Number of trials in which the event happened}}{\text{Total number of trials}} \\
&= \dfrac{|E|}{|S|}
\end{alignat}
$$

Let $S$ be the sample space of a random experiment. The probability $P$ is a real valued function whose domain is the power set of $S$ and range is $[0, 1]$ satisfying the following axioms:

1. For any real event $E$, $P(E) \ge 0$.
2. $P(S) = 1$.
3. If $E$ and $F$ are mutually exclusive, then $P(E \cup F) = P(E) + P(F)$.

### Probability algebra

$$
\begin{alignat}{1}
P(A \text{ and } B) &= P(A \cap B) \\
\\
P(A \text{ or } B) &= P(A \cup B) = P(A) + P(B) - P(A \cap B)\\
\\
P(\text{not } A) &= P(\overline A) = 1 - P(A) \\
\end{alignat}
$$

## Independent events

Two events $A$ and $B$ are independent if their joint probability is:

$$
P(A \text{ and } B) = P(A \cap B) = P(A)P(B)
$$

## Mutually exclusive events

Two events $A$ and $B$ are _mutually exclusive_ if the occurence of any one of them excludes the occurence of the other event. i.e. they cannot occur simultaneously.

Consider the example of rolling a die, $S = \lbrace 1, 2, 3, 4, 5, 6\rbrace$. $A$ `an odd number appears` $\lbrace 1, 3, 5\rbrace$ and $B$ `an even number appears` $\lbrace 2, 4, 6\rbrace$ are disjoint sets, and thus are mutually exclusive.

$$
P(A \text{ and } B) = P(A \cap B) = 0
$$

## Exhaustive events

Events $E_1, E_2, E_3, \dots, E_n$ are called exhaustive events if:

$$
\begin{alignat}{1}
E_1 \cup E_2 \cup E_3 \cup \dots \cup E_n &= S \\
P(E_1) + P(E_2) + P(E_3) + \dots + P(E_n) &= 1
\end{alignat}
$$

## Conditional probability

is the probability of some event $A$, given the occurence of some other event $B$, written as $P(A|B)$.

$$
P(A|B) = \dfrac{P(A \cap B)}{P(B)} = \dfrac{P(B|A)P(A)}{P(B)}
$$

- If $A$ and $B$ are independent, then $P(A|B) = P(A)$ simply.
- If $P(B) = 0$, then $P(A|B)$ is undefined.

## Summary

| Event                | Probability                                                               |
| -------------------- | ------------------------------------------------------------------------- |
| $E$                  | $P(E) \in [0, 1]$                                                         |
| $\overline E$        | $P(\overline E) = 1 - P(E)$                                               |
| $A \text{ or } B$    | $P(A\cup B) = P(A) + P(B) - P(A \cap B)$                                  |
|                      | $P(A\cup B) = P(A) + P(B)$ if $A$ and $B$ are mutually exclusive          |
| $A \text{ and } B$   | $P(A\cap B) = P(A\vert B)P(B)= P(B\vert A)P(A)$                           |
|                      | $P(A\cap B) = P(A)P(B)$ if $A$ and $B$ are independent                    |
| $A \text{ given } B$ | $P(A\vert B) = \dfrac{P(A \cap B)}{P(B)} = \dfrac{P(B\vert A)P(A)}{P(B)}$ |
