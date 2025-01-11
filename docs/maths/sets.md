# Sets

<style>
.md-logo img {
  content: url('/maths/maths-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/maths/maths-night.svg');
}
</style>

## Operations

### Union

<div markdown class="grid">

<div markdown>
Given set $A$ and set $B$, the union of the two is $A \cup B$.

$$
A \cup B = \lbrace x \in A \text{ or } x \in B\rbrace
$$

</div>

![](/maths/set-union.png){ width="200" }

</div>

### Intersection

<div markdown class="grid">

<div markdown>
Given set $A$ and set $B$, the intersection of the two is $A \cap B$.

$$
A \cap B = \lbrace x \in A \text{ and } x \in B\rbrace
$$

</div>

![](/maths/set-intersection.png){ width="200" }

</div>

## Difference

<div markdown class="grid">

<div markdown>
Given set $A$ and set $B$, the difference of the two is $A - B$.

$$
A - B = \lbrace x \in A \text{ and } \not \in B\rbrace
$$

</div>

![](/maths/set-difference-light.png#only-light){ width="200" }
![](/maths/set-difference-night.png#only-dark){ width="200" }

</div>

### Complement

<div markdown class="grid">

<div markdown>
Given set $A$ which is a subset of the universal set $U$, the complement of $A$ is $\overline A$.

$$
\begin{alignat}{1}
\overline A & = \lbrace x \in U \text{ and } x \not \in A\rbrace \\
& = U - A
\end{alignat}
$$

</div>

![](/maths/set-complement-light.png#only-light){ width="200" }
![](/maths/set-complement-night.png#only-dark){ width="200" }

</div>

## Propeties

$$
\begin{alignat}{1}
\text{ commutative }A \cup B &= B \cup A\\
A \cap B &= B \cap A \\
\\
\text{ associative }(A \cup B) \cup C &= A \cup (B \cup C) \\
(A \cap B) \cap C &= A \cap (B \cap C) \\
\\
\text{ identity }A \cup \phi &= A \\
A \cap \phi &= \phi \\
\\
\text{ idempotent }A \cup A &= A \\
A \cap A &= A \\
\\
A \cup U &= U \\
A \cap U &= A \\
\\
\text{ distributive }A \cup (B \cap C) &= (A \cup B) \cap (A \cup C) \\
A \cap (B \cup C) &= (A \cap B) \cup (A \cap C) \\
\\
A \cup \overline A &= U \\
A \cap \overline A &= \phi \\
\overline{ (\overline A) } &= A \\
\\
\overline \phi &= U \\
\overline U &= \phi \\
\\
\overline{ A \cup B } &= \overline A \cap \overline B \\
\overline{ A \cap B } &= \overline A \cup \overline B \\
\\
|A - B| &= |A| - |A \cap B| \\
\Rightarrow |A \cap B| &= |A| - |A - B| \\
\Rightarrow |A| &= |A \cap B| + |A - B|
\end{alignat}
$$

## Inclusion–exclusion principle

<div markdown class="grid">

<div markdown>
$$
\begin{alignat}{1}
|A \cup B| &= |A-B| + |B-A| + |A \cap B| \\
&=  (|A| - |A \cap B|) + (|B| - |A \cap B|) + |A \cap B| \\
&= |A| + |B| - |A \cap B|
\end{alignat}
$$
</div>

<div markdown>
![](/maths/set-size-ab-light.png#only-light)
![](/maths/set-size-ab-night.png#only-dark)
</div>

</div>

$$
|A \cup B \cup C| = |A| + |B| + |C| - |A \cap B| - |B \cap C| - |C \cap A| + |A \cap B \cap C|
$$
