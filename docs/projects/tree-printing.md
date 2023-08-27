---
tags:
  - projects
  - binary tree
---

# Tree Printing

## Motivation
Being able to see a binary tree proves very helpful in visualizing various algorithm running on it. I could not find any libraries that'd print a tree top-down fashion, but quite a few which print them horizontally.

## End result

Here is what the end result looks like.
```bash
             ╭-------------1013-------------╮
       ╭----77--------╮                ╭----77--------╮
  ╭----5-╮       ╭----5-╮         ╭----5-╮       ╭----5-╮
171-╮    19    171-╮    19      171-╮    19    171-╮    19
    51             51               51             51
```

## Baby steps

### 1/ Leaf node

Let's start with printing a leaf node, say `root`:

```
root
```

That's pretty straightforward, we just print out the content of the node.

### 2/ Left child

Add left child to this node now: 

```
    ╭-root
child
```

Whelp, it's already a headache now. It's intuitive to print the root first, but we'd then have to go back and add a left-padding of whitespaces to the line containing `"root"`. So:

1. we print the left node first.
2. print the root next.
3. pad the root line with `len("child") - 1` whitespaces.

What happens when the left child has a left child?

```
               ╭-root
         ╭-child
grandchild
```

hmm, seems `len("child")` is too simplistic. It doesn't account for the fact that child nodes can be trees in themselves, i.e. multilevel. So we print the left child, and split it by lines. And substitute `len("child") - 1` with `len(first line of child) - 1`?

```
    ╭------------root
child-╮
      grandchild
```

No. The left whitespace padding is determined by the position of `chil[d]`, i.e. last character to left root `<-->╭-`.  From here use `len(first line of child) - 1` to find the dash `-` padding on the right. 


### 3/ Right child

Let's now take a step back and add just a right child to a leaf node:

```
root-╮
     child
```

Notice the pattern again. `root` must be printed first so we can account for the necessary padding while printing the right child.

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 507.2639754615383 232.67978764025492" height="280">
  <g stroke-linecap="round" transform="translate(291.5104875665344 14.866764907892787) rotate(0 28 23.5)"><path d="M11.75 0 M11.75 0 C19.75 1.33, 31.81 2.1, 44.25 0 M11.75 0 C21.99 1.13, 31.14 -0.19, 44.25 0 M44.25 0 C53.52 -1.16, 57.69 5.26, 56 11.75 M44.25 0 C50.51 0.08, 54.28 3.34, 56 11.75 M56 11.75 C57.81 18.01, 54.1 21.76, 56 35.25 M56 11.75 C56.53 19.99, 55.46 26.21, 56 35.25 M56 35.25 C57.06 44.94, 52.94 45.08, 44.25 47 M56 35.25 C54.54 45.29, 50.93 47.87, 44.25 47 M44.25 47 C35.69 45.97, 27.86 48.07, 11.75 47 M44.25 47 C36.12 46.09, 28.84 47.28, 11.75 47 M11.75 47 C1.95 45.31, 0.62 42.99, 0 35.25 M11.75 47 C5.56 46.31, -2.24 41.79, 0 35.25 M0 35.25 C1.84 29.17, -1.67 19.38, 0 11.75 M0 35.25 C0.65 29.63, 1.06 22.54, 0 11.75 M0 11.75 C-1.51 3.85, 2.83 1.93, 11.75 0 M0 11.75 C1.81 2.69, 2.18 1.76, 11.75 0" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(298.4805116754211 25.866764907892787) rotate(0 21.02997589111328 12.5)"><text x="21.02997589111328" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">root</text></g><g stroke-linecap="round" transform="translate(29.01048756653438 92.86676490789279) rotate(0 28 23.5)"><path d="M11.75 0 M11.75 0 C17.76 -1.94, 23.66 -1.25, 44.25 0 M11.75 0 C22.4 0.44, 31.82 -0.52, 44.25 0 M44.25 0 C53.35 1.38, 55.98 4, 56 11.75 M44.25 0 C54.05 -0.13, 56.3 4.45, 56 11.75 M56 11.75 C57.39 16.45, 56.14 21.81, 56 35.25 M56 11.75 C56.44 18.5, 56.74 24.73, 56 35.25 M56 35.25 C56.41 41.45, 51.61 48.34, 44.25 47 M56 35.25 C56.09 41.88, 49.86 47.23, 44.25 47 M44.25 47 C32.32 45.38, 23.66 47.88, 11.75 47 M44.25 47 C31.78 46.23, 18.35 46.27, 11.75 47 M11.75 47 C3.17 48.14, -0.15 43.1, 0 35.25 M11.75 47 C5.78 48.81, 0.67 42.32, 0 35.25 M0 35.25 C-2.07 27.68, -1.55 23.23, 0 11.75 M0 35.25 C-0.96 25.51, 0.75 17.44, 0 11.75 M0 11.75 C1.23 2.21, 4.5 1.76, 11.75 0 M0 11.75 C0.11 3.41, 3.48 -1.24, 11.75 0" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(38.40050984436641 103.86676490789279) rotate(0 18.60997772216797 12.5)"><text x="18.60997772216797" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">left</text></g><g stroke-linecap="round"><g transform="translate(92.51048756653438 69.36676490789279) rotate(294.70630171217715 -25.954681926593196 -15.566407312982378)"><path d="M0.09 -0.03 C-3 -5.14, -9.16 -27.71, -17.84 -30.68 C-26.52 -33.65, -46.55 -19.83, -51.99 -17.87 M-1.33 -1.1 C-4.1 -6.06, -7.52 -26.94, -15.57 -29.5 C-23.62 -32.07, -43.89 -18.35, -49.62 -16.48" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(92.51048756653438 69.36676490789279) rotate(294.70630171217715 -25.954681926593196 -15.566407312982378)"><path d="M-37.2 -30.77 C-42.62 -26.35, -45.84 -19.46, -50.98 -16.94 M-37.91 -29.16 C-40.78 -25.13, -45.01 -21.11, -50.48 -16.93" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(92.51048756653438 69.36676490789279) rotate(294.70630171217715 -25.954681926593196 -15.566407312982378)"><path d="M-31.75 -19.7 C-39.11 -19.22, -44.27 -16.28, -50.98 -16.94 M-32.46 -18.1 C-37.02 -17.27, -42.84 -16.48, -50.48 -16.93" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(103.01048756653438 35.86676490789279) rotate(0 13.853767395392083 1.3862236824072909)"><path d="M-0.64 0.95 C4.04 1.09, 23.66 0.82, 28.35 1.06 M1.22 0.4 C5.71 0.69, 22.55 2.35, 27.32 2.37" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(95.07343150155623 111.95867776494475) rotate(0 14.632332391105592 0.7668510580435282)"><path d="M0.57 0.65 C5.36 0.74, 22.82 0.22, 27.61 0.55 M-0.58 -0.05 C4.67 0.15, 24.93 1.43, 29.85 1.58" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(137.73386958662218 142.83617891083628) rotate(53.617429319916795 29.4840166084212 -14.733688498153896)"><path d="M0.79 1.14 C5.3 -3.47, 16.41 -26.88, 26.15 -28.61 C35.88 -30.34, 53.73 -12.59, 59.22 -9.25 M-0.25 0.69 C4.72 -4.21, 18.59 -29.06, 28.41 -30.53 C38.24 -32, 53.52 -12.01, 58.7 -8.14" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(137.73386958662218 142.83617891083628) rotate(53.617429319916795 29.4840166084212 -14.733688498153896)"><path d="M43.37 -17.23 C46 -13.5, 48.62 -11.95, 59.14 -8.87 M41.6 -15.75 C47.64 -14.02, 53.27 -10.3, 57.97 -7.37" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(137.73386958662218 142.83617891083628) rotate(53.617429319916795 29.4840166084212 -14.733688498153896)"><path d="M52.35 -26.42 C52.88 -20.56, 53.48 -16.94, 59.14 -8.87 M50.59 -24.95 C53.57 -20.05, 56.17 -13.24, 57.97 -7.37" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(169.9271988969482 161.84490144735202) rotate(0 53.5 30)"><path d="M15 0 M15 0 C42.47 1.24, 72.41 -0.9, 92 0 M15 0 C40 -0.21, 66.27 -0.33, 92 0 M92 0 C103.71 -1.11, 106.27 3.32, 107 15 M92 0 C100.28 -0.08, 108.78 6.96, 107 15 M107 15 C108 23.92, 105.33 35.4, 107 45 M107 15 C105.76 20.93, 106.47 27.36, 107 45 M107 45 C108.75 54.51, 102.38 59.28, 92 60 M107 45 C106.66 52.85, 101.64 61.34, 92 60 M92 60 C65.24 62.33, 41.8 58.71, 15 60 M92 60 C67.07 60.04, 44.13 59.16, 15 60 M15 60 C5.5 61.77, -0.35 54.7, 0 45 M15 60 C3.31 59.11, -2.15 55.49, 0 45 M0 45 C-0.45 36, -1.84 27.69, 0 15 M0 45 C0.6 39.29, -0.26 31.84, 0 15 M0 15 C-0.86 5.43, 4.84 -0.03, 15 0 M0 15 C0.46 6.39, 5.01 1.11, 15 0" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(178.61725474411617 179.34490144735202) rotate(0 44.80994415283203 12.5)"><text x="44.80994415283203" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">left-right</text></g><g stroke-linecap="round"><g transform="translate(417.4021139311237 69.51802187168005) rotate(53.617429319916795 29.781376106745427 -14.79291228735272)"><path d="M-0.99 -0.95 C3.56 -5.59, 17.82 -26.89, 28.07 -28.66 C38.33 -30.43, 55.27 -14.52, 60.55 -11.57 M0.69 1.16 C5.11 -3.78, 17.87 -28.64, 27.69 -30.6 C37.51 -32.56, 54.29 -14.04, 59.59 -10.59" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(417.4021139311237 69.51802187168005) rotate(53.617429319916795 29.781376106745427 -14.79291228735272)"><path d="M40.01 -15.49 C48.62 -15.26, 53.62 -14.05, 59.49 -11.52 M41.3 -16.84 C45.6 -14.55, 50.69 -13.86, 60.08 -9.78" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(417.4021139311237 69.51802187168005) rotate(53.617429319916795 29.781376106745427 -14.79291228735272)"><path d="M48.49 -25.54 C53.94 -21.72, 55.84 -16.85, 59.49 -11.52 M49.78 -26.89 C52.1 -22.22, 55.13 -19.08, 60.08 -9.78" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(368.8966206943801 37.07805038930843) rotate(0 14.176301582520807 0.6718294914811906)"><path d="M0.75 -0.93 C5.35 -0.61, 23.87 2.03, 28.68 2.28 M-0.32 1.19 C4.04 1.15, 22.87 0.54, 27.82 0.56" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(437.5289530854858 95.84490144735202) rotate(0 28 23.5)"><path d="M11.75 0 M11.75 0 C20.02 1, 26.48 1.29, 44.25 0 M11.75 0 C23.02 0.19, 32.46 1.21, 44.25 0 M44.25 0 C53.55 1.13, 57.28 4.96, 56 11.75 M44.25 0 C51.28 -0.72, 56.32 4.4, 56 11.75 M56 11.75 C55.57 19.77, 57.57 24.68, 56 35.25 M56 11.75 C56.49 19.85, 55.43 29.39, 56 35.25 M56 35.25 C56.58 42.68, 51.19 48.06, 44.25 47 M56 35.25 C58.01 43.28, 52.17 46.94, 44.25 47 M44.25 47 C35.98 45.82, 29.34 46.8, 11.75 47 M44.25 47 C37.29 46.51, 30.52 46.59, 11.75 47 M11.75 47 C3.37 45.57, -1.55 42.67, 0 35.25 M11.75 47 C3.51 46.03, -0.85 40.96, 0 35.25 M0 35.25 C-0.86 26.62, 0.05 16.05, 0 11.75 M0 35.25 C0.89 26.99, 0.64 17.49, 0 11.75 M0 11.75 C-1.06 4.83, 3.87 -1.02, 11.75 0 M0 11.75 C-0.69 2.98, 6.14 1.74, 11.75 0" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(443.43897963577876 106.84490144735202) rotate(0 22.08997344970703 12.5)"><text x="22.08997344970703" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">right</text></g><g stroke-linecap="round"><g transform="translate(149.67518569009383 36.45867776494475) rotate(0 14.634716674927631 1.5794772544875713)"><path d="M0.81 0.76 C5.7 0.88, 25 1.41, 29.49 1.51 M-0.22 0.11 C4.58 0.37, 23.99 2.64, 29.06 3.05" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(197.17518569009383 36.95867776494475) rotate(0 14.01239147001877 0.9967891738191241)"><path d="M0.08 0.61 C5.12 0.57, 24.7 0.7, 29.36 0.89 M-1.33 -0.11 C3.69 0.51, 24.13 1.56, 28.86 2.1" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(242.67518569009383 36.45867776494475) rotate(0 14.270401542400919 1.3428532358352072)"><path d="M0.29 0.89 C5.2 1.27, 24.83 2.31, 29.56 2.37 M-1.02 0.31 C3.81 0.36, 24.33 0.36, 29.17 0.71" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(147.5289530854858 222.34490144735202) rotate(0 -41.65800566995517 -36.3533677700907)"><path d="M-0.94 0.33 C-2.84 -9.67, 1.66 -48.35, -12.11 -60.58 C-25.88 -72.81, -71.74 -70.98, -83.56 -73.04 M0.77 -0.53 C-0.72 -10.86, 4.17 -50.57, -9.98 -62.48 C-24.12 -74.39, -72.04 -70.4, -84.09 -72.01" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(147.5289530854858 222.34490144735202) rotate(0 -41.65800566995517 -36.3533677700907)"><path d="M-55.07 -83.33 C-61.96 -78.64, -70.56 -75.42, -84.88 -70.7 M-55.56 -82.19 C-65.49 -78.56, -75.65 -75.48, -84.28 -71.94" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(147.5289530854858 222.34490144735202) rotate(0 -41.65800566995517 -36.3533677700907)"><path d="M-55.64 -62.82 C-62.3 -63.16, -70.75 -64.98, -84.88 -70.7 M-56.13 -61.67 C-65.82 -65.25, -75.78 -69.38, -84.28 -71.94" stroke="#f08c00" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(10.028953085485796 86.34490144735202) rotate(0 132.21396016291345 -35.34260145160894)"><path d="M0.94 1.03 C6.05 -9.89, -12.39 -55.74, 31.53 -66.1 C75.45 -76.47, 225.65 -61.79, 264.46 -61.16 M-0.03 0.53 C4.94 -10.67, -12.78 -57.11, 31.13 -67.75 C75.03 -78.39, 224.54 -64.35, 263.41 -63.33" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(10.028953085485796 86.34490144735202) rotate(0 132.21396016291345 -35.34260145160894)"><path d="M236.39 -53 C246.86 -59.04, 256.57 -62.37, 262.03 -62.4 M235.4 -53.96 C242.74 -57.4, 250.33 -60.4, 262.71 -62.6" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(10.028953085485796 86.34490144735202) rotate(0 132.21396016291345 -35.34260145160894)"><path d="M237.57 -73.48 C247.51 -71.92, 256.78 -67.66, 262.03 -62.4 M236.59 -74.45 C243.53 -72.12, 250.78 -69.35, 262.71 -62.6" stroke="#f08c00" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(370.5289530854858 9.344901447352015) rotate(0 62.99674877476116 34.83099021131173)"><path d="M0.47 1.12 C20 2.7, 95.7 -0.6, 116.03 10.6 C136.36 21.8, 121.26 58.34, 122.46 68.31 M-0.74 0.66 C18.78 2.87, 94.96 0.27, 115.36 11.66 C135.76 23.05, 120.26 59.56, 121.67 69.01" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(370.5289530854858 9.344901447352015) rotate(0 62.99674877476116 34.83099021131173)"><path d="M117.16 41.39 C115.36 46.23, 116.19 53.32, 123.22 71 M116.15 39.76 C117.93 51.65, 120.53 62.8, 122.06 69.95" stroke="#f08c00" stroke-width="1" fill="none"></path></g><g transform="translate(370.5289530854858 9.344901447352015) rotate(0 62.99674877476116 34.83099021131173)"><path d="M136.97 43.96 C131.1 48.36, 127.88 54.92, 123.22 71 M135.96 42.34 C130.08 53.37, 125.01 63.52, 122.06 69.95" stroke="#f08c00" stroke-width="1" fill="none"></path></g></g><mask></mask></svg>

???+ note 
    We are actually performing an in-order walk while printing the tree!

What about a right-right child?

```
root-╮
     child-╮
           grandchild
```

No paddings to worry about in this case. What about a right-left child?

```
root------------╮
              ╭-child
     grandchild
```

Nothing to worry about when printing `root`. But we need to find the position of the first character in the first right line. That about covers the cases to think about when printing the right child. But as usual, the devil is in the details. 


## Implementation

=== "`BinaryTreeNode` interface"

    Let's first create an interface which any binary-tree like object can support:

    ```java
    public interface BinaryTreeNode {
      String valueAsText();

      Optional<BinaryTreeNode> left();

      Optional<BinaryTreeNode> right();

      BinaryTreeNode left(BinaryTreeNode left);

      BinaryTreeNode right(BinaryTreeNode right);

      boolean leaf();
    }
    ```

=== "`Line` class"

    Now, this is going to be a recursive algorithm. We need to quickly jump between lines and append text.

    ```java
    // Utility class to hold each line and indices.
    private static class Line {
      // Holds the content of this line.
      StringBuilder sb;
      // Holds the index where in this line the content of node's value.
      int valueStartIndex;
      // Holds the length of node's value.
      int valueLength;

      public Line() {
        this.sb = new StringBuilder();
        valueStartIndex = -1;
        valueLength = -1;
      }

      void setValueText(String content) {
        valueStartIndex = sb.length();
        valueLength = content.length();
        sb.append(content);
      }

      Line append(CharSequence content) {
        sb.append(content);
        return this;
      }

      Line append(char c) {
        sb.append(c);
        return this;
      }

      int length() {
        return sb.length();
      }
    }

    public static List<Line> printLines(BinaryTreeNode root) {
      ...
    }
    ```

Take care of the base cases first.

```java
public static List<Line> printLines(BinaryTreeNode root) {
  Line rootLine = new Line();
  List<Line> outLines = new ArrayList<>();
  outLines.add(rootLine);

  if (root == null) {
    rootLine.setValueText("null");
    return outLines;
  }
  if (root.leaf()) {
    rootLine.setValueText(root.valueAsText());
    return outLines;
  }
  ...
}
```

Next, we print the left child (in-order walk):

```java
public static List<Line> printLines(BinaryTreeNode root) {
  ...

  root.left()
      .map(BinaryTreePrint::printLines)
      .ifPresent(leftLines -> processLeftLines(leftLines, outLines, rootLine));

  ...
}

// Appends the prefix of root's value in rootLine (i.e. ╭---).
// Adds all the leftLines to outLines.
private static void processLeftLines(List<Line> leftLines, List<Line> outLines, Line rootLine) {
  // canonical example:
  // <-->╭------------root   <- need to find this padding of whitespaces.
  // child-╮
  //       grandchild
  int endIndexOfLeftRoot = leftLines.get(0).valueStartIndex + leftLines.get(0).valueLength - 1;
  rootLine.append(" ".repeat(endIndexOfLeftRoot)).append("╭-");

  //       <--------->       <- now find this right padding of dashes.
  //     ╭------------root
  // child-╮
  //       grandchild
  int longestLeftLineLength =
      leftLines.stream().map(Line::length).mapToInt(l -> l).max().getAsInt();
  rootLine.append("-".repeat(longestLeftLineLength - (endIndexOfLeftRoot + 1)));

  // rootLine already added in outLines, add left lines below that.
  outLines.addAll(leftLines);
}
```

After this take care of an edge-case when there is no left child:

```java
public static List<Line> printLines(BinaryTreeNode root) {
  ...
  rootLine.setValueText(root.valueAsText());
  ...
}
```

Finally, we move on to printing the right child.

```java
public static List<Line> printLines(BinaryTreeNode root) {
  ...
  root.right()
      .map(BinaryTreePrint::printLines)
      .ifPresent(rightLines -> processRightLines(rightLines, outLines, rootLine));
  return outLines;
}

// Appends the suffix of root's value in rootLine (i.e. ---╮).
// Adds all the leftLines to outLines.
private static void processRightLines(List<Line> rightLines, List<Line> outLines, Line rootLine) {
  // normalize lines so they all have same width. this ensures
  // that when we stitch the lines of right child, they have
  // correct indentation.
  //
  // This turns the following tree into:
  // ···············╭-root
  // ·········╭-child
  // grandchild
  // ->
  // ···············╭-root
  // ·········╭-child·····
  // grandchild···········
  int longestOutLineLength =
      outLines.stream().map(Line::length).mapToInt(l -> l).max().getAsInt();
  outLines.stream()
      .filter(l -> l.length() < longestOutLineLength)
      .forEach(l -> l.append(" ".repeat(longestOutLineLength - l.length())));

  // canonical example:
  // root------------╮
  //      <------->╭-child   <- find this padding of dashes.
  //      grandchild
  int startIndexOfRightRoot = rightLines.get(0).valueStartIndex;
  rootLine.append("-".repeat(startIndexOfRightRoot)).append("-╮");

  // Make sure the list where we placed lines of root and left child has
  // enough lines to accommodate lines of right child.
  while (outLines.size() < rightLines.size() + 1)
    outLines.add(new Line().append(" ".repeat(longestOutLineLength)));

  // Stitch the left and right side.
  //
  // ···············╭-root     -╮
  // ·········╭-child······     child-╮            <- i = 0, also note right lines
  // grandchild············     ······grandchild      need one extra white space.
  //
  //
  // ···············╭-root-╮
  // ·········╭-child······child-╮
  // grandchild··················grandchild
  for (int i = 0; i < rightLines.size(); i++) {
    outLines.get(i + 1).append(' ').append(rightLines.get(i).sb);
  }
}
```


## Full solution

=== "Implementation"

    ```java linenums="1"
    package dev.justanotherblog.tree;

    import java.util.ArrayList;
    import java.util.Comparator;
    import java.util.List;
    import java.util.stream.Collectors;

    public class BinaryTreePrint {

      private static class Line {
        // Holds the content of this line.
        StringBuilder sb;
        // Holds the index where in this line the content of node's value.
        int valueStartIndex;
        // Holds the length of node's value.
        int valueLength;

        public Line() {
          this.sb = new StringBuilder();
          valueStartIndex = -1;
          valueLength = -1;
        }

        void setValueText(String content) {
          valueStartIndex = sb.length();
          valueLength = content.length();
          sb.append(content);
        }

        Line append(CharSequence content) {
          sb.append(content);
          return this;
        }

        Line append(char c) {
          sb.append(c);
          return this;
        }

        int length() {
          return sb.length();
        }
      }

      public static String print(BinaryTreeNode root) {
        List<Line> lines = printLines(root);
        return lines.stream()
            .map(l -> l.sb)
            .reduce((f, b) -> f.append('\n').append(b))
            .map(StringBuilder::toString)
            .get();
      }

      public static List<Line> printLines(BinaryTreeNode root) {
        Line rootLine = new Line();
        List<Line> outLines = new ArrayList<>();
        outLines.add(rootLine);

        if (root == null) {
          rootLine.setValueText("null");
          return outLines;
        }
        if (root.leaf()) {
          rootLine.setValueText(root.valueAsText());
          return outLines;
        }

        root.left()
            .map(BinaryTreePrint::printLines)
            .ifPresent(leftLines -> processLeftLines(leftLines, outLines, rootLine));

        rootLine.setValueText(root.valueAsText());

        root.right()
            .map(BinaryTreePrint::printLines)
            .ifPresent(rightLines -> processRightLines(rightLines, outLines, rootLine));

        return outLines;
      }

      // Appends the prefix of root's value in rootLine (i.e. ╭---).
      // Adds all the leftLines to outLines.
      private static void processLeftLines(List<Line> leftLines, List<Line> outLines, Line rootLine) {
        // canonical example:
        // <-->╭------------root   <- need to find this padding of whitespaces.
        // child-╮
        //       grandchild
        int endIndexOfLeftRoot = leftLines.get(0).valueStartIndex + leftLines.get(0).valueLength - 1;
        rootLine.append(" ".repeat(endIndexOfLeftRoot)).append("╭-");

        //       <--------->       <- now find this right padding of dashes.
        //     ╭------------root
        // child-╮
        //       grandchild
        int longestLeftLineLength =
            leftLines.stream().map(Line::length).mapToInt(l -> l).max().getAsInt();
        rootLine.append("-".repeat(longestLeftLineLength - (endIndexOfLeftRoot + 1)));

        // rootLine already added in outLines, add left lines below that.
        outLines.addAll(leftLines);
      }

      // Appends the suffix of root's value in rootLine (i.e. ---╮).
      // Adds all the leftLines to outLines.
      private static void processRightLines(List<Line> rightLines, List<Line> outLines, Line rootLine) {
        // normalize lines so they all have same width. this ensures
        // that when we stitch the lines of right child, they have
        // correct indentation.
        //
        // This turns the following tree into:
        // ···············╭-root
        // ·········╭-child
        // grandchild
        // ->
        // ···············╭-root
        // ·········╭-child·····
        // grandchild···········
        int longestOutLineLength =
            outLines.stream().map(Line::length).mapToInt(l -> l).max().getAsInt();
        outLines.stream()
            .filter(l -> l.length() < longestOutLineLength)
            .forEach(l -> l.append(" ".repeat(longestOutLineLength - l.length())));

        // canonical example:
        // root------------╮
        //      <------->╭-child   <- find this padding of dashes.
        //      grandchild
        int startIndexOfRightRoot = rightLines.get(0).valueStartIndex;
        rootLine.append("-".repeat(startIndexOfRightRoot)).append("-╮");

        // Make sure the list where we placed lines of root and left child has
        // enough lines to accommodate lines of right child.
        while (outLines.size() < rightLines.size() + 1)
          outLines.add(new Line().append(" ".repeat(longestOutLineLength)));

        // Stitch the left and right side.
        //
        // ···············╭-root     -╮
        // ·········╭-child······     child-╮            <- i = 0, also note right lines
        // grandchild············     ······grandchild      need one extra white space.
        //
        //
        // ···············╭-root-╮
        // ·········╭-child······child-╮
        // grandchild··················grandchild
        for (int i = 0; i < rightLines.size(); i++) {
          outLines.get(i + 1).append(' ').append(rightLines.get(i).sb);
        }
      }
    }

    ```

=== "Unit tests"

    ```java linenums="1"
    package dev.justanotherblog.tree;

    import org.junit.jupiter.api.Test;

    import static org.junit.jupiter.api.Assertions.*;

    class BinaryTreePrintTest {

      @Test
      public void testNull() {
        assertEquals("null", BinaryTreePrint.print(null));
      }

      @Test
      public void testLeaf() {
        assertEquals("5", BinaryTreePrint.print(IntBinaryTree.of(5)));
      }

      @Test
      public void testSingleLeftChild() {
        String expected = """
                            ╭-5
                            9""";
        assertEquals(expected, BinaryTreePrint.print(IntBinaryTree.of(5).left(IntBinaryTree.of(9))));
      }

      @Test
      public void testSingleRightChild() {
        String expected = """
                            5-╮
                              19""";
        assertEquals(expected, BinaryTreePrint.print(IntBinaryTree.of(5).right(IntBinaryTree.of(19))));
      }

      @Test
      public void testTwoChildren() {
        String expected = """
                              ╭-5-╮
                            171   19""";
        assertEquals(
            expected,
            BinaryTreePrint.print(
                IntBinaryTree.of(5).left(IntBinaryTree.of(171)).right(IntBinaryTree.of(19))));
      }

      @Test
      public void testLeftRightChildren() {
        String expected = """
                                ╭----5-╮
                              171-╮    19
                                  51 \s""";
        assertEquals(
            expected,
            BinaryTreePrint.print(
                IntBinaryTree.of(5)
                    .left(IntBinaryTree.of(171).right(IntBinaryTree.of(51)))
                    .right(IntBinaryTree.of(19))));
      }

      @Test
      public void testLeftLeftChildren() {
        String expected = """
                                  ╭-5-╮
                              ╭-171   19
                              51     \s""";
        assertEquals(
            expected,
            BinaryTreePrint.print(
                IntBinaryTree.of(5)
                    .left(IntBinaryTree.of(171).left(IntBinaryTree.of(51)))
                    .right(IntBinaryTree.of(19))));
      }

      @Test
      public void testRightLeftChildren() {
        String expected = """
                                ╭-5----╮
                              171    ╭-19
                                    51""";
        assertEquals(
            expected,
            BinaryTreePrint.print(
                IntBinaryTree.of(5)
                    .left(IntBinaryTree.of(171))
                    .right(IntBinaryTree.of(19).left(IntBinaryTree.of(51)))));
      }

      @Test
      public void testRightRightChildren() {
        String expected = """
                                ╭-5-╮
                              171   19-╮
                                      51""";
        assertEquals(
            expected,
            BinaryTreePrint.print(
                IntBinaryTree.of(5)
                    .left(IntBinaryTree.of(171))
                    .right(IntBinaryTree.of(19).right(IntBinaryTree.of(51)))));
      }

      @Test
      public void testRightRightLeftLeftChildren() {
        String expected =
            """
                                    ╭----77--------╮
                                ╭----5-╮       ╭----5-╮
                              171-╮    19    171-╮    19
                                  51             51 \s""";

        BinaryTreeNode left = IntBinaryTree.of(5)
            .left(IntBinaryTree.of(171).right(IntBinaryTree.of(51)))
            .right(IntBinaryTree.of(19));
        BinaryTreeNode root = IntBinaryTree.of(77, left, left);
        assertEquals(
            expected,
            BinaryTreePrint.print(root));
      }

      @Test
      public void testNestAgain() {
        String expected =
            """
                                          ╭-------------1013-------------╮
                                    ╭----77--------╮                ╭----77--------╮
                                ╭----5-╮       ╭----5-╮         ╭----5-╮       ╭----5-╮
                              171-╮    19    171-╮    19      171-╮    19    171-╮    19
                                  51             51               51             51 \s""";

        BinaryTreeNode left = IntBinaryTree.of(5)
            .left(IntBinaryTree.of(171).right(IntBinaryTree.of(51)))
            .right(IntBinaryTree.of(19));
        BinaryTreeNode root = IntBinaryTree.of(77, left, left);
        assertEquals(
            expected,
            BinaryTreePrint.print(IntBinaryTree.of(1013, root, root)));
      }
    }
    ```
