# Binary Search Tree

## Search

A search in BST is pretty straighforward. However, a common patten that emerges when searching a BST is that the searched node is good for nothing if we don't know its parent.

=== "Search"

    ```java
    public static SearchPair search(BinaryTreeNode root, int key) {
      BinaryTreeNode parent = null, cursor = root;
      while (cursor != null) {
        // return both the node and its parent when found.
        if (key == cursor.key) return SearchPair.found(cursor, parent);

        parent = cursor;
        if (key < cursor.key) cursor = cursor.left;
        else cursor = cursor.right;
      }
      return SearchPair.absent(parent);
    }
    ```


=== "`SearchPair` definition"

    ```java
    public static class SearchPair {
      private BinaryTreeNode node, parent;
      private SearchPair(){}

      public Optional<BinaryTreeNode> node() {
        return Optional.ofNullable(node);
      }

      public Optional<BinaryTreeNode> parent() {
        return Optional.ofNullable(parent);
      }

      public static SearchPair found(BinaryTreeNode node, BinaryTreeNode parent) {
        SearchPair pair = new SearchPair();
        pair.node = node;
        pair.parent = parent;
        return pair;
      }

      public static SearchPair absent(BinaryTreeNode parent) {
        SearchPair pair = new SearchPair();
        pair.parent = parent;
        return pair;
      }

      public boolean found() {
        return node != null;
      }
    }
    ```

=== "Unit test"

    ```java
    import static org.junit.jupiter.api.Assertions.*;

    import dev.justanotherblog.tree.BinaryTreeNode.SearchPair;
    import org.junit.jupiter.api.BeforeEach;
    import org.junit.jupiter.api.Test;

    class BinaryTreeNodeSearchTest {
      BinaryTreeNode root;

      @BeforeEach
      public void setup() {
        /*
              ╭---10----╮
            ╭-8-╮     ╭-16-╮
            1   9    12    20
        */
        root = new BinaryTreeNode(10);
        BinaryTreeNode.insertExternal(root, 16);
        BinaryTreeNode.insertExternal(root, 12);
        BinaryTreeNode.insertExternal(root, 20);
        BinaryTreeNode.insertExternal(root, 8);
        BinaryTreeNode.insertExternal(root, 1);
        BinaryTreeNode.insertExternal(root, 9);
      }

      @Test
      public void testSearchRoot() {
        SearchPair pair = BinaryTreeNode.search(root, 10);
        assertTrue(pair.found());
        assertTrue(pair.parent().isEmpty());
        assertTrue(pair.node().isPresent());
        assertEquals("10", pair.node().get().valueAsText());
      }

      @Test
      public void testSearch_missing() {
        SearchPair pair = BinaryTreeNode.search(root, 101);
        assertFalse(pair.found());
        assertEquals("20", pair.parent().get().valueAsText());
      }

      @Test
      public void testSearch_present() {
        SearchPair pair = BinaryTreeNode.search(root, 12);
        assertTrue(pair.found());
        assertEquals("12", pair.node().get().valueAsText());
        assertEquals("16", pair.parent().get().valueAsText());
      }
    }
    ```

## Insert

Bit more interesting than mere search. There are two, equally valid preferences when inserting duplicate keys in a BST.

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 770.5937972351802 310.5574430899411" width="770.5937972351802" height="310.5574430899411">
  <g stroke-linecap="round" transform="translate(35.37060672287453 176.06279751413635) rotate(0 25 24.5)"><path d="M14.05 3.32 C18.38 0.83, 24.46 -0.12, 29.55 0.73 C34.64 1.59, 41.27 4.47, 44.59 8.45 C47.91 12.43, 49.65 19.09, 49.48 24.64 C49.32 30.19, 47.03 37.59, 43.6 41.75 C40.17 45.9, 34.35 49.15, 28.9 49.58 C23.44 50.02, 15.41 47.29, 10.87 44.37 C6.33 41.46, 3.02 36.94, 1.67 32.1 C0.32 27.27, 0.12 20.68, 2.78 15.39 C5.44 10.1, 14.45 2.94, 17.63 0.36 C20.82 -2.22, 21.64 -0.67, 21.89 -0.09 M17.57 2.02 C22.65 -0.08, 30.82 -0.55, 35.88 1.25 C40.94 3.06, 45.56 7.92, 47.92 12.87 C50.28 17.81, 51.11 25.75, 50.05 30.95 C48.99 36.15, 45.8 41.15, 41.54 44.08 C37.27 47, 30.19 48.71, 24.47 48.49 C18.75 48.28, 11.25 46.44, 7.23 42.79 C3.21 39.14, 0.98 31.76, 0.35 26.58 C-0.28 21.4, 0.52 15.88, 3.47 11.71 C6.43 7.53, 15.53 3.01, 18.07 1.51 C20.62 0, 18.87 2.46, 18.72 2.68" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(57.48293810873815 188.2386813750659) rotate(0 2.7099990844726562 12.5)"><text x="2.7099990844726562" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">1</text></g><g stroke-linecap="round" transform="translate(137.89384761141412 79.84019288416334) rotate(0 25 24.5)"><path d="M23.17 -0.64 C28.24 -1.24, 36.23 2.28, 40.65 5.39 C45.07 8.5, 48.44 12.9, 49.69 18.03 C50.93 23.16, 50.51 31.26, 48.11 36.17 C45.72 41.09, 40.3 45.57, 35.32 47.53 C30.34 49.48, 23.3 49.59, 18.23 47.89 C13.16 46.19, 8.07 41.64, 4.9 37.31 C1.74 32.99, -1.33 26.92, -0.77 21.94 C-0.2 16.96, 4.03 11.26, 8.28 7.44 C12.52 3.62, 21.81 0.32, 24.71 -0.96 C27.6 -2.25, 25.82 -0.98, 25.63 -0.26 M33.08 1.83 C37.65 3.01, 43.15 6.85, 45.82 11.58 C48.48 16.32, 49.99 24.89, 49.07 30.22 C48.15 35.55, 44.45 40.33, 40.28 43.57 C36.12 46.82, 29.17 50.02, 24.08 49.7 C18.99 49.38, 13.57 45.4, 9.77 41.63 C5.96 37.87, 2.04 31.91, 1.24 27.12 C0.43 22.32, 2.57 17.07, 4.93 12.87 C7.29 8.68, 10.64 3.65, 15.41 1.95 C20.18 0.26, 30.33 2.78, 33.55 2.71 C36.76 2.63, 34.8 1.51, 34.72 1.51" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(155.5961829645629 92.01607674509293) rotate(0 7.1199951171875 12.5)"><text x="7.1199951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">2</text></g><g stroke-linecap="round" transform="translate(268.9881578223983 171.0557398455405) rotate(0 25 24.5)"><path d="M23.02 -0.83 C28.22 -1.37, 35.64 2, 39.98 5.43 C44.32 8.86, 47.89 14.68, 49.06 19.76 C50.23 24.85, 49.41 31.21, 47 35.92 C44.59 40.63, 39.33 46.03, 34.61 48 C29.9 49.97, 23.85 49.31, 18.69 47.75 C13.54 46.18, 6.75 42.97, 3.68 38.64 C0.62 34.3, -0.57 26.99, 0.3 21.74 C1.17 16.5, 4.02 10.69, 8.9 7.15 C13.78 3.6, 25.12 1.16, 29.58 0.47 C34.03 -0.23, 35.48 2.44, 35.64 2.98 M31.79 0.5 C36.71 1.49, 42.31 5.96, 45.31 10.35 C48.31 14.75, 50.19 21.63, 49.78 26.86 C49.36 32.08, 46.86 37.79, 42.82 41.69 C38.78 45.6, 31.14 49.97, 25.52 50.27 C19.91 50.58, 13.04 46.76, 9.12 43.52 C5.21 40.28, 3.1 36, 2.01 30.84 C0.91 25.67, 0.45 17.45, 2.54 12.51 C4.64 7.58, 9.6 3.15, 14.56 1.22 C19.52 -0.72, 29.4 0.92, 32.28 0.89 C35.17 0.87, 32.08 0.88, 31.88 1.07" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(287.00049073414084 183.23162370647006) rotate(0 6.80999755859375 12.5)"><text x="6.80999755859375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">3</text></g><g stroke-linecap="round" transform="translate(205.30101544886315 251.55744308994107) rotate(0 25 24.5)"><path d="M24.05 -0.62 C29.03 -1.11, 35.43 2.21, 39.56 5.46 C43.68 8.7, 47.66 14, 48.8 18.87 C49.94 23.75, 48.59 29.89, 46.38 34.71 C44.18 39.53, 40.27 45.59, 35.6 47.79 C30.92 49.99, 23.48 49.55, 18.35 47.92 C13.22 46.3, 7.86 42.37, 4.81 38.07 C1.76 33.76, -0.38 27.4, 0.05 22.12 C0.49 16.84, 3.21 10.14, 7.42 6.37 C11.62 2.61, 22.01 0.45, 25.28 -0.5 C28.55 -1.44, 27.19 0.12, 27.05 0.71 M36.91 3.68 C41.91 5.46, 46.18 9.93, 48.31 14.56 C50.45 19.2, 51.34 26.6, 49.72 31.5 C48.09 36.4, 42.91 40.91, 38.57 43.94 C34.24 46.97, 28.88 50.26, 23.73 49.66 C18.58 49.06, 11.56 44.11, 7.68 40.34 C3.8 36.57, 1.12 32.23, 0.43 27.04 C-0.27 21.84, 0.27 13.39, 3.5 9.19 C6.73 4.99, 14.38 2.93, 19.83 1.85 C25.27 0.77, 33.75 2.5, 36.18 2.71 C38.61 2.92, 34.54 2.75, 34.41 3.1" stroke="#2f9e44" stroke-width="1" fill="none"></path></g><g transform="translate(223.00335080201194 263.7333269508706) rotate(0 7.1199951171875 12.5)"><text x="7.1199951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">2</text></g><g stroke-linecap="round"><g transform="translate(278.8103979836608 217.13197018369507) rotate(0 -15.434850032917154 21.090351297456493)"><path d="M0.12 0.59 C-4.98 7.31, -24.84 34.33, -29.94 41.3 M-1.28 -0.15 C-6.6 6.61, -26.54 35.02, -30.99 42.33" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(142.50802669321126 120.70848929278134) rotate(0 -31.166328135694243 31.400907576942828)"><path d="M0.66 0.94 C-9.75 10.99, -51.3 51.09, -61.79 61.23 M-0.45 0.39 C-11.12 10.51, -53.08 51.98, -63 62.41" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(184.76767235768614 117.13719745796175) rotate(0 44.528483203997155 31.10282733395762)"><path d="M-0.55 0.56 C13.86 10.89, 72.61 51.3, 87.31 61.43 M1.36 -0.2 C16.08 10.29, 75.39 52.04, 89.61 62.4" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(10 10) rotate(0 176.62986755371094 25)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">                 #1 </text><text x="0" y="25" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">Always insert as an "external" node</text></g><g stroke-linecap="round" transform="translate(432.9309386600306 172.0450981733994) rotate(0 25 24.5)"><path d="M35.97 1.85 C40.78 3.73, 45.2 9.78, 47.29 14.69 C49.38 19.6, 49.77 26.52, 48.5 31.33 C47.23 36.13, 43.73 40.56, 39.67 43.51 C35.62 46.46, 29.42 49.09, 24.16 49.02 C18.9 48.95, 12.05 46.62, 8.1 43.08 C4.15 39.53, 0.94 33.13, 0.46 27.75 C-0.01 22.38, 2.41 15.31, 5.24 10.84 C8.07 6.37, 11.7 1.98, 17.45 0.93 C23.2 -0.12, 35.4 3.55, 39.75 4.54 C44.09 5.53, 43.69 6.42, 43.53 6.88 M16.14 0.95 C21.21 -1.13, 29.81 -1.9, 34.74 0.22 C39.67 2.34, 43.25 8.66, 45.73 13.67 C48.21 18.68, 50.23 25.31, 49.65 30.29 C49.07 35.27, 46.41 40.52, 42.24 43.53 C38.07 46.54, 30.35 48.31, 24.62 48.35 C18.89 48.39, 11.8 47.24, 7.88 43.78 C3.97 40.32, 2.03 32.82, 1.15 27.58 C0.28 22.35, 0.1 16.83, 2.63 12.37 C5.17 7.92, 14.21 2.44, 16.36 0.85 C18.52 -0.74, 15.52 2.23, 15.54 2.83" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(455.04327004589425 184.220982034329) rotate(0 2.7099990844726562 12.5)"><text x="2.7099990844726562" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">1</text></g><g stroke-linecap="round" transform="translate(532.4780447425034 73.44173827848732) rotate(0 25 24.5)"><path d="M21.08 1.13 C26.1 -0.1, 33.69 0.41, 38.47 3.11 C43.25 5.8, 48.07 12.01, 49.74 17.31 C51.41 22.61, 50.66 29.96, 48.49 34.9 C46.33 39.84, 41.44 44.69, 36.77 46.94 C32.1 49.19, 25.86 49.68, 20.47 48.4 C15.09 47.13, 7.8 43.46, 4.48 39.3 C1.15 35.15, -0.02 28.86, 0.5 23.48 C1.03 18.1, 2.94 10.75, 7.64 7.01 C12.33 3.27, 24.53 2.04, 28.7 1.04 C32.87 0.04, 32.91 0.82, 32.65 1 M20.55 1.3 C25.43 0.75, 33.52 2.32, 38.47 4.95 C43.43 7.58, 48.69 12.38, 50.3 17.09 C51.91 21.79, 50.55 28.19, 48.14 33.17 C45.74 38.15, 40.47 44.55, 35.86 46.97 C31.25 49.38, 25.76 48.82, 20.49 47.65 C15.23 46.47, 7.78 44.03, 4.29 39.93 C0.8 35.82, -0.57 28.15, -0.44 23 C-0.31 17.85, 1.59 12.68, 5.07 9.02 C8.56 5.35, 17.55 2.37, 20.49 1.01 C23.43 -0.36, 22.27 0.67, 22.71 0.85" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(550.1803800956521 85.61762213941691) rotate(0 7.1199951171875 12.5)"><text x="7.1199951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">2</text></g><g stroke-linecap="round" transform="translate(710.5937972351802 234.2965382881226) rotate(0 25 24.5)"><path d="M37.14 2.71 C41.91 4.96, 46.4 10.86, 48.42 15.78 C50.44 20.7, 50.71 27.37, 49.25 32.24 C47.8 37.11, 44.32 42.25, 39.68 45.01 C35.04 47.77, 26.82 49.4, 21.41 48.8 C16.01 48.2, 10.65 45.39, 7.25 41.43 C3.85 37.46, 1.25 30.13, 1.03 25.01 C0.81 19.89, 3.01 14.92, 5.94 10.71 C8.87 6.5, 13.37 1.02, 18.63 -0.27 C23.89 -1.55, 34.15 2.08, 37.51 3.01 C40.86 3.95, 39.08 5.06, 38.77 5.36 M35.29 1.59 C40.15 2.75, 44.55 7.14, 46.8 11.84 C49.06 16.53, 49.68 24.65, 48.83 29.78 C47.98 34.92, 45.87 39.37, 41.7 42.65 C37.53 45.93, 29.38 49.47, 23.81 49.46 C18.24 49.45, 12.42 45.92, 8.26 42.6 C4.11 39.28, -0.12 34.48, -1.11 29.51 C-2.11 24.55, -0.82 17.47, 2.31 12.81 C5.44 8.14, 12.24 3.5, 17.68 1.53 C23.11 -0.44, 32.19 0.84, 34.91 0.97 C37.63 1.11, 34.41 1.94, 33.99 2.34" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(728.6061301469227 246.47242214905222) rotate(0 6.80999755859375 12.5)"><text x="6.80999755859375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">3</text></g><g stroke-linecap="round" transform="translate(630.8361117985552 164.2107982652419) rotate(0 25 24.5)"><path d="M26.27 0.67 C31.46 0.4, 38.96 2.94, 42.78 6.35 C46.59 9.76, 48.5 15.91, 49.14 21.14 C49.79 26.37, 49.22 33.4, 46.64 37.7 C44.05 42.01, 38.67 45.24, 33.65 46.97 C28.63 48.7, 21.76 50.07, 16.52 48.08 C11.28 46.09, 4.94 39.89, 2.22 35.02 C-0.49 30.15, -0.96 23.76, 0.24 18.87 C1.44 13.98, 4.64 8.89, 9.4 5.69 C14.17 2.5, 24.73 0.32, 28.83 -0.3 C32.93 -0.92, 33.79 1.28, 34 1.97 M24.39 0.76 C29.62 0.46, 37.96 1.69, 42.01 5.03 C46.07 8.38, 48.04 15.62, 48.73 20.84 C49.41 26.06, 48.91 31.75, 46.12 36.37 C43.33 41, 37.14 46.61, 31.97 48.59 C26.81 50.57, 19.76 50.23, 15.14 48.26 C10.52 46.29, 6.52 41.57, 4.25 36.77 C1.98 31.98, 0.65 24.65, 1.51 19.51 C2.36 14.38, 5.54 9.29, 9.4 5.95 C13.26 2.61, 22.12 0.41, 24.66 -0.53 C27.19 -1.48, 24.72 -0.37, 24.62 0.27" stroke="#2f9e44" stroke-width="1" fill="none"></path></g><g transform="translate(648.538447151704 176.3866821261714) rotate(0 7.1199951171875 12.5)"><text x="7.1199951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">2</text></g><g stroke-linecap="round"><g transform="translate(537.0922238243005 114.31003468710531) rotate(0 -30.726953685249043 31.530055461788564)"><path d="M0.79 1.19 C-9.62 11.32, -50.94 50.94, -61.3 61.15 M-0.26 0.77 C-10.92 11, -51.93 52.35, -62.24 62.29" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(579.3518694887754 110.73874285228572) rotate(0 28.426657041766077 28.777749265069232)"><path d="M0.01 -0.75 C9.59 8.77, 48.55 48.36, 58.3 58.31 M-1.45 1.47 C7.91 11.14, 47.45 47.19, 57.33 56.48" stroke="#2f9e44" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(675.6273655223248 204.48387407014295) rotate(0 20.79453461828996 17.980020528152693)"><path d="M-0.28 0.95 C6.55 6.59, 35.05 28.62, 41.87 34.39 M1.77 0.41 C8.38 6.13, 34.15 30.04, 41.03 35.55" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(474.966034294785 16.2483346893095) rotate(0 128.08987426757818 25)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">            #2 </text><text x="0" y="25" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">Duplicates clump together</text></g></svg>


=== "External insert"

    ```java
    public static BinaryTreeNode insertExternal(BinaryTreeNode root, int key) {
      BinaryTreeNode newNode = new BinaryTreeNode(key);
      if (root == null) return newNode;

      // "Fall off the edge" strategy.
      BinaryTreeNode parent = null, cursor = root;
      while (cursor != null) {
        parent = cursor;
        if (key < cursor.key) cursor = cursor.left;
        else cursor = cursor.right;
      }

      if (key < parent.key) parent.left = newNode;
      else parent.right = newNode;
      return root;
    }
    ```

=== "Duplicates together"

    ```java
    public static BinaryTreeNode insert(BinaryTreeNode root, int key) {
      BinaryTreeNode newNode = new BinaryTreeNode(key);
      if (root == null) return newNode;

      SearchPair pair = search(root, key);
      if (pair.found()) {
        newNode.right = pair.node.right;
        pair.node.right = newNode;
      } else {
        if (key < pair.parent.key) pair.parent.left = newNode;
        else pair.parent.right = newNode;
      }
      return root;
    }
    ```

=== "Unit tests"

    ```java
    import static org.junit.jupiter.api.Assertions.assertEquals;

    import org.junit.jupiter.api.BeforeEach;
    import org.junit.jupiter.api.Test;

    class BinaryTreeNodeInsertTest {

      BinaryTreeNode root;

      @BeforeEach
      public void setup() {
        root = new BinaryTreeNode(10);
      }

      @Test
      public void testLeaf() {
        assertEquals("10", root.toString());
      }

      @Test
      public void testInsertRoot() {
        root = BinaryTreeNode.insert(null, 6);
        assertEquals("6", root.toString());
      }

      @Test
      public void testInsert_leftLeaf() {
        BinaryTreeNode.insert(root, 6);
        String expected = """
            ╭-10
            6""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void testInsert_rightLeaf() {
        BinaryTreeNode.insert(root, 16);
        String expected = """
            10-╮
              16""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void testInsert_properTree() {
        BinaryTreeNode.insert(root, 16);
        BinaryTreeNode.insert(root, 12);
        BinaryTreeNode.insert(root, 20);
        BinaryTreeNode.insert(root, 8);
        BinaryTreeNode.insert(root, 1);
        BinaryTreeNode.insert(root, 9);
        String expected = """
              ╭---10----╮
            ╭-8-╮     ╭-16-╮
            1   9    12    20""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void testInsert_properTree_external() {
        BinaryTreeNode.insert(root, 16);
        BinaryTreeNode.insert(root, 12);
        BinaryTreeNode.insert(root, 20);
        BinaryTreeNode.insert(root, 8);
        BinaryTreeNode.insert(root, 1);
        BinaryTreeNode.insert(root, 9);
        BinaryTreeNode.insert(root, 10);
        String expected = """
              ╭---10-╮
            ╭-8-╮    10----╮
            1   9        ╭-16-╮
                        12    20""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void testInsert_withDuplicates_asInternal() {
        BinaryTreeNode.insert(root, 16);
        BinaryTreeNode.insert(root, 10);
        String expected = """
            10-╮
              10-╮
                  16""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void testInsertExternalRoot() {
        root = BinaryTreeNode.insertExternal(null, 6);
        assertEquals("6", root.toString());
      }

      @Test
      public void testInsertExternal_leftLeaf() {
        BinaryTreeNode.insertExternal(root, 6);
        String expected = """
            ╭-10
            6""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void testInsertExternal_rightLeaf() {
        BinaryTreeNode.insertExternal(root, 16);
        String expected = """
            10-╮
              16""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void testInsertExternal_withDuplicates_onlyExternal() {
        BinaryTreeNode.insertExternal(root, 16);
        BinaryTreeNode.insertExternal(root, 10);
        String expected = """
            10----╮
                ╭-16
              10""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void testInsertExternal_properTree() {
        BinaryTreeNode.insertExternal(root, 16);
        BinaryTreeNode.insertExternal(root, 12);
        BinaryTreeNode.insertExternal(root, 20);
        BinaryTreeNode.insertExternal(root, 8);
        BinaryTreeNode.insertExternal(root, 1);
        BinaryTreeNode.insertExternal(root, 9);
        String expected = """
              ╭---10----╮
            ╭-8-╮     ╭-16-╮
            1   9    12    20""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void testInsertExternal_properTree_external() {
        BinaryTreeNode.insertExternal(root, 16);
        BinaryTreeNode.insertExternal(root, 12);
        BinaryTreeNode.insertExternal(root, 20);
        BinaryTreeNode.insertExternal(root, 8);
        BinaryTreeNode.insertExternal(root, 1);
        BinaryTreeNode.insertExternal(root, 9);
        BinaryTreeNode.insertExternal(root, 10);
        String expected = """
              ╭---10-------╮
            ╭-8-╮        ╭-16-╮
            1   9     ╭-12    20
                    10     \s""";
        assertEquals(expected, root.toString());
      }
    }
    ```

## Successor

Successor of a node is the next node in inorder traversal.

A given node can have two possible values for successor:

1. if the node has a right subtree, then the successor is the leftmost child in this subtree.
2. otherwise, it's the parent of the node.

```java
public static BinaryTreeNode successor(BinaryTreeNode node, BinaryTreeNode parent) {
  if (node.right == null)
    return parent;

  BinaryTreeNode successor = node, scout = node.right;
  while (scout != null) {
    successor = scout;
    scout = scout.left;
  }
  return successor;
}
```

## Deletion

Most interesting method. There are a couple of edge cases to consider:

1. deleting _root_
    - is leaf: simply delete the tree.
    - has one child: child becomes the new root.
    - has both children: swap with successor.
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 739.6079013229646 245.0028123455979" width="739.6079013229646" height="245.0028123455979">
  <g stroke-linecap="round" transform="translate(94.29743015547592 96.63229505099312) rotate(0 25 24.5)"><path d="M14.05 3.32 C18.38 0.83, 24.46 -0.12, 29.55 0.73 C34.64 1.59, 41.27 4.47, 44.59 8.45 C47.91 12.43, 49.65 19.09, 49.48 24.64 C49.32 30.19, 47.03 37.59, 43.6 41.75 C40.17 45.9, 34.35 49.15, 28.9 49.58 C23.44 50.02, 15.41 47.29, 10.87 44.37 C6.33 41.46, 3.02 36.94, 1.67 32.1 C0.32 27.27, 0.12 20.68, 2.78 15.39 C5.44 10.1, 14.45 2.94, 17.63 0.36 C20.82 -2.22, 21.64 -0.67, 21.89 -0.09 M17.57 2.02 C22.65 -0.08, 30.82 -0.55, 35.88 1.25 C40.94 3.06, 45.56 7.92, 47.92 12.87 C50.28 17.81, 51.11 25.75, 50.05 30.95 C48.99 36.15, 45.8 41.15, 41.54 44.08 C37.27 47, 30.19 48.71, 24.47 48.49 C18.75 48.28, 11.25 46.44, 7.23 42.79 C3.21 39.14, 0.98 31.76, 0.35 26.58 C-0.28 21.4, 0.52 15.88, 3.47 11.71 C6.43 7.53, 15.53 3.01, 18.07 1.51 C20.62 0, 18.87 2.46, 18.72 2.68" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(111.9997655086247 108.80817891192268) rotate(0 7.1199951171875 12.5)"><text x="7.1199951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">2</text></g><g stroke-linecap="round" transform="translate(178.36927735354016 16.480328846556347) rotate(0 25 24.5)"><path d="M23.17 -0.64 C28.24 -1.24, 36.23 2.28, 40.65 5.39 C45.07 8.5, 48.44 12.9, 49.69 18.03 C50.93 23.16, 50.51 31.26, 48.11 36.17 C45.72 41.09, 40.3 45.57, 35.32 47.53 C30.34 49.48, 23.3 49.59, 18.23 47.89 C13.16 46.19, 8.07 41.64, 4.9 37.31 C1.74 32.99, -1.33 26.92, -0.77 21.94 C-0.2 16.96, 4.03 11.26, 8.28 7.44 C12.52 3.62, 21.81 0.32, 24.71 -0.96 C27.6 -2.25, 25.82 -0.98, 25.63 -0.26 M33.08 1.83 C37.65 3.01, 43.15 6.85, 45.82 11.58 C48.48 16.32, 49.99 24.89, 49.07 30.22 C48.15 35.55, 44.45 40.33, 40.28 43.57 C36.12 46.82, 29.17 50.02, 24.08 49.7 C18.99 49.38, 13.57 45.4, 9.77 41.63 C5.96 37.87, 2.04 31.91, 1.24 27.12 C0.43 22.32, 2.57 17.07, 4.93 12.87 C7.29 8.68, 10.64 3.65, 15.41 1.95 C20.18 0.26, 30.33 2.78, 33.55 2.71 C36.76 2.63, 34.8 1.51, 34.72 1.51" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(196.79161392739206 28.656212707485935) rotate(0 6.399993896484375 12.5)"><text x="6.399993896484375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">4</text></g><g transform="translate(281.8992984411043 96.14880744711954) rotate(0 56.409942626953125 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">delete root</text></g><g stroke-linecap="round"><g transform="translate(312.7576511740068 86.62540493757692) rotate(0 -40.201551383963135 -17.198121275461816)"><path d="M0.41 1.18 C-4.8 -2.54, -17.21 -16.85, -30.64 -22.97 C-44.07 -29.1, -71.84 -33.66, -80.16 -35.58 M-0.83 0.75 C-5.73 -2.79, -15.05 -16.01, -28.38 -21.94 C-41.72 -27.86, -72.14 -32.91, -80.82 -34.81" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(312.7576511740068 86.62540493757692) rotate(0 -40.201551383963135 -17.198121275461816)"><path d="M-53.1 -40.24 C-65.8 -36.95, -75.1 -36.21, -80.75 -35.93 M-55.84 -38.01 C-59.73 -37.97, -65.9 -36.51, -80.55 -34.9" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(312.7576511740068 86.62540493757692) rotate(0 -40.201551383963135 -17.198121275461816)"><path d="M-56.56 -22.75 C-67.94 -25.67, -76.02 -31.13, -80.75 -35.93 M-59.3 -20.53 C-62.59 -24.3, -68 -26.67, -80.55 -34.9" stroke="#e03131" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(291.0133576489451 166.4575525511954) rotate(0 43.33995819091797 25)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">becomes </text><text x="0" y="25" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">new root</text></g><g stroke-linecap="round"><g transform="translate(184.48430015308486 60.52255988608621) rotate(0 -21.719640468584117 21.004133892171907)"><path d="M-0.76 0.95 C-8.24 7.87, -36.61 34.75, -43.95 41.6 M1.04 0.41 C-6.61 6.97, -36.7 33.16, -44.48 39.82" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(10 175.7355509656904) rotate(0 25 24.5)"><path d="M29.01 1.03 C34.04 1.58, 40.75 4.26, 44.11 8.06 C47.46 11.86, 49.3 18.49, 49.13 23.84 C48.96 29.19, 46.34 36.07, 43.09 40.16 C39.83 44.26, 34.9 47.55, 29.62 48.41 C24.33 49.26, 15.92 47.84, 11.38 45.28 C6.83 42.72, 3.94 38.06, 2.33 33.04 C0.73 28.02, -0.1 20.02, 1.76 15.15 C3.61 10.29, 8.58 6.19, 13.45 3.87 C18.31 1.55, 27.83 1.6, 30.93 1.24 C34.03 0.88, 32 1.55, 32.06 1.72 M30.32 -1.13 C35.64 -0.47, 41.96 3.58, 45.01 8.03 C48.07 12.47, 48.81 20.46, 48.67 25.55 C48.52 30.64, 47.54 34.64, 44.16 38.56 C40.79 42.48, 33.66 47.68, 28.41 49.05 C23.16 50.41, 17.09 49.18, 12.66 46.75 C8.23 44.32, 3.88 39.78, 1.84 34.48 C-0.2 29.18, -1.53 20.3, 0.43 14.97 C2.39 9.64, 8.72 4.88, 13.59 2.5 C18.47 0.13, 27.08 1.06, 29.68 0.72 C32.27 0.38, 29.53 0.31, 29.17 0.47" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(32.11233138586368 187.91143482661997) rotate(0 2.7099990844726562 12.5)"><text x="2.7099990844726562" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">1</text></g><g stroke-linecap="round" transform="translate(153.14726121608953 186.0028123455979) rotate(0 25 24.5)"><path d="M35.08 1.41 C39.92 3.39, 45.31 9.64, 47.71 14.32 C50.12 18.99, 50.69 24.55, 49.51 29.45 C48.33 34.36, 45.13 40.37, 40.63 43.75 C36.14 47.13, 27.93 49.99, 22.54 49.72 C17.16 49.45, 12.17 45.98, 8.33 42.14 C4.48 38.3, 0.06 32.01, -0.51 26.69 C-1.08 21.36, 1.9 14.48, 4.89 10.16 C7.89 5.85, 12 1.93, 17.44 0.8 C22.88 -0.33, 33.94 2.75, 37.54 3.38 C41.14 4.02, 39.29 4.43, 39.04 4.61 M35.34 3 C39.94 4.86, 46.43 10.1, 48.76 14.75 C51.1 19.41, 50.92 25.85, 49.34 30.93 C47.76 36.02, 43.8 42.26, 39.28 45.26 C34.76 48.26, 27.71 49.8, 22.21 48.94 C16.7 48.08, 9.98 44.06, 6.26 40.11 C2.54 36.15, 0.1 30.43, -0.1 25.22 C-0.3 20.02, 1.52 13.09, 5.05 8.89 C8.57 4.69, 15.84 1.02, 21.05 0.04 C26.25 -0.94, 33.62 2.32, 36.29 3 C38.96 3.68, 37.27 3.67, 37.06 4.12" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(171.15959412783207 198.17869620652746) rotate(0 6.80999755859375 12.5)"><text x="6.80999755859375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">3</text></g><g stroke-linecap="round"><g transform="translate(97.79440285697092 139.07796106115316) rotate(0 -22.62533293237803 20.250587511990034)"><path d="M0.75 -0.84 C-6.6 5.94, -37.38 34.45, -44.91 41.34 M-0.32 1.34 C-7.77 7.72, -38.54 32.89, -46 39.63" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(134.67621696196596 142.80777723797135) rotate(0 16.237456958005737 21.597282953003287)"><path d="M-0.54 0.41 C4.77 7.31, 27.55 35.26, 33.01 42.4 M1.38 -0.42 C6.44 7.15, 27.17 36.1, 32.13 43.62" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(543.9391057652733 10) rotate(0 25 24.5)"><path d="M14.5 1.55 C18.8 -0.8, 25.25 -0.07, 30.51 1.36 C35.76 2.79, 42.97 5.93, 46.05 10.15 C49.14 14.37, 49.65 21.59, 49.03 26.68 C48.41 31.76, 45.75 37, 42.32 40.66 C38.89 44.33, 33.54 47.8, 28.45 48.66 C23.35 49.51, 16.38 48.61, 11.73 45.79 C7.08 42.98, 2.28 37.01, 0.52 31.77 C-1.23 26.53, -1.63 19.44, 1.22 14.36 C4.06 9.28, 14.11 3.6, 17.58 1.3 C21.06 -1, 21.82 0.37, 22.09 0.56 M22.39 0.39 C27.64 -0.68, 35.06 1.53, 39.28 4.35 C43.49 7.17, 46.14 12.43, 47.69 17.32 C49.25 22.22, 50.27 29.04, 48.61 33.72 C46.94 38.39, 42.34 43.05, 37.7 45.36 C33.06 47.68, 26.1 48.76, 20.75 47.62 C15.39 46.47, 9.21 42.33, 5.59 38.47 C1.98 34.61, -1.24 29.36, -0.96 24.45 C-0.69 19.55, 3.21 13.02, 7.22 9.04 C11.24 5.07, 20.83 2.26, 23.13 0.62 C25.43 -1.03, 21.09 -1.03, 21 -0.8" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(561.6414411184221 22.175883860929588) rotate(0 7.1199951171875 12.5)"><text x="7.1199951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">2</text></g><g stroke-linecap="round" transform="translate(453.0943880391453 92.67438881210651) rotate(0 25 24.5)"><path d="M14.19 2.97 C18.46 0.35, 24.36 0.16, 29.33 1.11 C34.29 2.05, 40.43 4.65, 43.99 8.66 C47.56 12.68, 50.69 19.67, 50.72 25.2 C50.75 30.73, 47.97 37.86, 44.18 41.86 C40.39 45.85, 33.53 48.67, 27.97 49.19 C22.4 49.72, 15.32 47.8, 10.81 44.99 C6.3 42.18, 2.39 37.29, 0.89 32.33 C-0.61 27.36, -1.07 20.54, 1.81 15.18 C4.68 9.83, 14.8 2.7, 18.15 0.2 C21.49 -2.31, 21.7 -0.43, 21.87 0.16 M25.48 0.03 C30.57 -0.07, 38.64 2.99, 42.93 6.48 C47.22 9.96, 50.52 15.77, 51.22 20.92 C51.92 26.08, 50.25 33.02, 47.13 37.41 C44.01 41.81, 38.04 45.49, 32.5 47.28 C26.96 49.07, 18.78 49.94, 13.87 48.15 C8.96 46.36, 5.04 41.39, 3.04 36.54 C1.05 31.69, 0.86 24.6, 1.89 19.05 C2.93 13.5, 5.05 6.51, 9.24 3.24 C13.42 -0.03, 24.18 -0.33, 27 -0.57 C29.83 -0.81, 26.18 1.39, 26.2 1.8" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(475.20671942500894 104.85027267303613) rotate(0 2.7099990844726562 12.5)"><text x="2.7099990844726562" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">1</text></g><g stroke-linecap="round" transform="translate(609.3361886356215 94.01362722359923) rotate(0 25 24.5)"><path d="M25.82 -0.74 C31.2 -0.87, 38.86 2.65, 42.97 6.55 C47.08 10.46, 50.07 17.37, 50.47 22.69 C50.87 28.01, 48.58 34.3, 45.36 38.47 C42.14 42.65, 36.28 46.27, 31.17 47.74 C26.05 49.2, 19.45 49.32, 14.68 47.25 C9.92 45.18, 4.82 40.21, 2.58 35.3 C0.35 30.4, 0.07 23.01, 1.29 17.84 C2.51 12.67, 4.35 6.95, 9.91 4.29 C15.47 1.62, 29.62 1.58, 34.65 1.85 C39.68 2.12, 40.33 5.71, 40.09 5.91 M26.13 -0.97 C31.35 -1.4, 38.27 1.46, 42.27 4.83 C46.28 8.2, 49.56 13.76, 50.15 19.26 C50.73 24.75, 48.41 32.89, 45.77 37.8 C43.12 42.71, 38.92 47, 34.27 48.71 C29.61 50.41, 23.14 50.24, 17.83 48.04 C12.53 45.83, 5.3 40.18, 2.44 35.48 C-0.43 30.78, -0.33 24.57, 0.64 19.84 C1.62 15.12, 4.17 10.54, 8.28 7.14 C12.4 3.73, 22.68 0.45, 25.34 -0.58 C28 -1.62, 24.34 0.3, 24.22 0.93" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(627.7585252094732 106.18951108452873) rotate(0 6.399993896484375 12.5)"><text x="6.399993896484375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">4</text></g><g stroke-linecap="round"><g transform="translate(549.8168337317074 50.0648471702566) rotate(0 -26.622471388143595 23.512832958092503)"><path d="M0.67 -0.88 C-8.34 7.29, -44.94 39.8, -53.92 47.91 M-0.43 1.27 C-9.09 9.21, -42.76 38.82, -51.7 46.25" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(586.1244058494052 54.82645160918608) rotate(0 17.26464735820133 20.468377314099754)"><path d="M-0.95 0.88 C4.85 7.8, 29.18 34.23, 35.48 40.63 M0.76 0.3 C6.32 6.96, 28.42 32.24, 34.4 38.91" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(543.7519534321727 172.8338783366169) rotate(0 25 24.5)"><path d="M28.78 -0.62 C33.82 -0.66, 40.11 2.86, 43.68 6.83 C47.25 10.8, 49.99 17.65, 50.2 23.18 C50.4 28.7, 48.16 35.79, 44.91 40 C41.65 44.2, 35.96 47.24, 30.67 48.39 C25.39 49.54, 18.06 49.31, 13.22 46.88 C8.37 44.46, 3.78 38.75, 1.61 33.83 C-0.56 28.91, -1.47 22.48, 0.2 17.37 C1.87 12.26, 6.69 5.84, 11.64 3.17 C16.58 0.49, 26.52 1.8, 29.87 1.32 C33.23 0.83, 31.97 0.06, 31.75 0.24 M26.87 -1.2 C32.24 -0.83, 40.47 4.45, 44.21 8.31 C47.94 12.17, 49.11 16.62, 49.28 21.96 C49.46 27.3, 48.5 35.99, 45.26 40.34 C42.03 44.7, 35.26 47.01, 29.87 48.1 C24.49 49.18, 17.62 48.91, 12.93 46.84 C8.24 44.76, 3.73 40.77, 1.73 35.64 C-0.27 30.51, -0.53 21.35, 0.95 16.06 C2.42 10.77, 5.85 6.41, 10.58 3.89 C15.31 1.38, 26.59 1.67, 29.31 0.96 C32.03 0.24, 27.31 -0.54, 26.9 -0.4" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(561.7642863439153 185.0097621975465) rotate(0 6.80999755859375 12.5)"><text x="6.80999755859375" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">3</text></g><g stroke-linecap="round" transform="translate(679.6079013229646 169.7090416889378) rotate(0 25 24.5)"><path d="M30.22 1.31 C35.37 2.1, 42.2 5.99, 45.35 9.96 C48.5 13.93, 49.56 19.88, 49.15 25.13 C48.74 30.38, 46.38 37.44, 42.88 41.44 C39.38 45.44, 33.31 48.53, 28.15 49.13 C22.98 49.73, 16.33 47.89, 11.87 45.05 C7.42 42.2, 3.18 36.92, 1.41 32.06 C-0.37 27.21, -0.7 20.94, 1.22 15.94 C3.15 10.95, 7.79 4.73, 12.96 2.09 C18.14 -0.55, 28.8 -0.02, 32.26 0.09 C35.72 0.21, 33.96 2.12, 33.72 2.77 M33.88 2.79 C38.26 4.52, 43.79 8.05, 46.18 12.74 C48.58 17.43, 49.02 25.79, 48.24 30.93 C47.47 36.07, 45.46 40.35, 41.55 43.57 C37.65 46.79, 30.18 50.26, 24.81 50.26 C19.44 50.26, 13.47 47.16, 9.31 43.59 C5.14 40.01, 0.94 34.25, -0.19 28.81 C-1.32 23.37, -0.31 15.56, 2.54 10.95 C5.38 6.34, 11.36 2.71, 16.88 1.16 C22.4 -0.4, 32.67 1.47, 35.68 1.61 C38.69 1.75, 35.22 1.74, 34.93 1.99" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(698.2502391175194 181.8849255498674) rotate(0 6.17999267578125 12.5)"><text x="6.17999267578125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">5</text></g><g stroke-linecap="round"><g transform="translate(615.3269087392426 136.62277540670235) rotate(0 -15.73459379145163 19.5019153763522)"><path d="M1.19 0.5 C-4.21 6.68, -26.11 31.79, -31.65 38.28 M0.35 -0.29 C-5.28 6.52, -27.07 32.44, -32.66 39.29" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(653.4201373276283 137.21802779790144) rotate(0 16.180828116999464 16.84954934443104)"><path d="M0.82 -1.09 C6.35 4.55, 27.55 28.68, 32.58 34.79 M-0.22 0.95 C5.26 6.12, 26.29 27.34, 31.86 32.81" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(399.9930905020567 86.03021612134208) rotate(0 67.78639991391515 -26.850108603368795)"><path d="M0 -1.15 C10.94 -8.6, 43.58 -34.78, 66.42 -43.68 C89.26 -52.58, 125.28 -52.68, 137.03 -54.56 M-1.46 0.86 C9.27 -6.99, 42.61 -36.31, 65.55 -45.3 C88.49 -54.3, 124.27 -51.69, 136.18 -53.12" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(399.9930905020567 86.03021612134208) rotate(0 67.78639991391515 -26.850108603368795)"><path d="M106.48 -41.54 C120.05 -46.21, 128.98 -50.54, 135.95 -52.08 M108.54 -41.51 C119.22 -45.62, 130.02 -50.71, 136.29 -53.09" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(399.9930905020567 86.03021612134208) rotate(0 67.78639991391515 -26.850108603368795)"><path d="M105.69 -62.04 C119.72 -59.23, 128.93 -56.07, 135.95 -52.08 M107.75 -62.02 C118.58 -58.42, 129.69 -55.8, 136.29 -53.09" stroke="#e03131" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(279.02345105236395 187.99890091683014) rotate(0 -63.22508794401489 -30.578925693011882)"><path d="M-1.16 0.22 C-6.62 -5.05, -10.79 -21.53, -31.57 -31.79 C-52.35 -42.06, -110.06 -56.59, -125.86 -61.38 M0.43 -0.71 C-5.26 -6.35, -11.19 -23.81, -32.4 -33.79 C-53.62 -43.77, -111.17 -56.31, -126.88 -60.6" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(279.02345105236395 187.99890091683014) rotate(0 -63.22508794401489 -30.578925693011882)"><path d="M-96.68 -63.39 C-108.47 -63.61, -122.37 -63.22, -127.14 -60.76 M-96.14 -63.08 C-107.03 -63.68, -118.01 -61.75, -126.36 -60.94" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(279.02345105236395 187.99890091683014) rotate(0 -63.22508794401489 -30.578925693011882)"><path d="M-101.62 -43.47 C-111.42 -51.53, -123.37 -59.03, -127.14 -60.76 M-101.09 -43.16 C-110.37 -50.5, -119.68 -55.32, -126.36 -60.94" stroke="#1971c2" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(389.110496257646 192.4837123703908) rotate(0 72.8054009706882 -7.804379001713528)"><path d="M0.97 0.98 C11.45 -1.34, 37.9 -12.91, 62.01 -14.48 C86.11 -16.05, 131.38 -9.28, 145.58 -8.43 M0.03 0.45 C10.95 -2.18, 40.18 -14.5, 64.26 -16.28 C88.35 -18.06, 131.2 -11.57, 144.55 -10.24" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(389.110496257646 192.4837123703908) rotate(0 72.8054009706882 -7.804379001713528)"><path d="M116.97 -4.83 C123.11 -6.05, 130.53 -4.91, 144.66 -11.57 M114.41 -3.37 C123.13 -4.74, 131.65 -6.4, 145.39 -9.31" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(389.110496257646 192.4837123703908) rotate(0 72.8054009706882 -7.804379001713528)"><path d="M119.41 -25.21 C124.89 -21.72, 131.75 -15.89, 144.66 -11.57 M116.84 -23.75 C124.84 -19.3, 132.66 -15.13, 145.39 -9.31" stroke="#1971c2" stroke-width="1" fill="none"></path></g></g><mask></mask><g mask="url(#mask-5XhIc6xzEFMQdbX4fIBkh)" stroke-linecap="round"><g transform="translate(564.7714295518399 165.4903389373317) rotate(0 0.07070197866539729 -52.147533584121845)"><path d="M-0.81 -0.53 C-0.84 -17.85, 0.57 -86.69, 0.95 -103.77" stroke="#2f9e44" stroke-width="1.5" fill="none" stroke-dasharray="8 9"></path></g><g transform="translate(564.7714295518399 165.4903389373317) rotate(0 0.07070197866539729 -52.147533584121845)"><path d="M9.74 -75.77 C5.43 -86.23, 2.87 -96.58, 1.85 -101.77" stroke="#2f9e44" stroke-width="1.5" fill="none"></path></g><g transform="translate(564.7714295518399 165.4903389373317) rotate(0 0.07070197866539729 -52.147533584121845)"><path d="M-10.78 -76.2 C-6.98 -86.35, -1.41 -96.53, 1.85 -101.77" stroke="#2f9e44" stroke-width="1.5" fill="none"></path></g></g><mask id="mask-5XhIc6xzEFMQdbX4fIBkh"><rect x="0" y="0" fill="#fff" width="665.961870759274" height="368.4611828941677"></rect><rect x="516.916698983682" y="101.50491695891367" fill="#000" width="96.89990234375" height="25" opacity="1"></rect></mask><g transform="translate(516.916698983682 101.50491695891367) rotate(0 47.925432546823345 11.837888394296158)"><text x="48.449951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">promoted </text></g></svg>

2. deleting any other node
    - is leaf: delete link from parent.
    - has one child: parent now points to this child.
    - has both children: swap with successor.
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1071.3798156528055 311.3979326919063" width="1071.3798156528055" height="311.3979326919063">
  <g stroke-linecap="round" transform="translate(209.22959937027417 84.99608749117044) rotate(0 25 24.5)"><path d="M30.22 1.31 C35.37 2.1, 42.2 5.99, 45.35 9.96 C48.5 13.93, 49.56 19.88, 49.15 25.13 C48.74 30.38, 46.38 37.44, 42.88 41.44 C39.38 45.44, 33.31 48.53, 28.15 49.13 C22.98 49.73, 16.33 47.89, 11.87 45.05 C7.42 42.2, 3.18 36.92, 1.41 32.06 C-0.37 27.21, -0.7 20.94, 1.22 15.94 C3.15 10.95, 7.79 4.73, 12.96 2.09 C18.14 -0.55, 28.8 -0.02, 32.26 0.09 C35.72 0.21, 33.96 2.12, 33.72 2.77 M33.88 2.79 C38.26 4.52, 43.79 8.05, 46.18 12.74 C48.58 17.43, 49.02 25.79, 48.24 30.93 C47.47 36.07, 45.46 40.35, 41.55 43.57 C37.65 46.79, 30.18 50.26, 24.81 50.26 C19.44 50.26, 13.47 47.16, 9.31 43.59 C5.14 40.01, 0.94 34.25, -0.19 28.81 C-1.32 23.37, -0.31 15.56, 2.54 10.95 C5.38 6.34, 11.36 2.71, 16.88 1.16 C22.4 -0.4, 32.67 1.47, 35.68 1.61 C38.69 1.75, 35.22 1.74, 34.93 1.99" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(229.1219371648292 97.17197135210003) rotate(0 4.92999267578125 12.5)"><text x="4.92999267578125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">p</text></g><g stroke-linecap="round" transform="translate(118.75813379163719 168.47376660422725) rotate(0 25 24.5)"><path d="M29.22 1.25 C34.14 2.03, 40.44 5.92, 44.05 9.84 C47.66 13.77, 50.94 19.69, 50.87 24.81 C50.8 29.93, 47.32 36.53, 43.62 40.54 C39.93 44.56, 33.98 47.95, 28.71 48.9 C23.43 49.85, 16.46 48.92, 11.99 46.24 C7.51 43.55, 3.53 37.9, 1.86 32.79 C0.2 27.68, 0.09 20.52, 2 15.58 C3.92 10.64, 7.55 5.14, 13.36 3.13 C19.17 1.13, 32.08 3.04, 36.85 3.56 C41.61 4.08, 42.39 6.01, 41.96 6.26 M14.9 3.4 C19.43 1.11, 28.08 -0.86, 33.49 0.6 C38.89 2.07, 44.62 7.6, 47.3 12.2 C49.99 16.8, 50.51 23.23, 49.59 28.19 C48.68 33.15, 45.42 38.59, 41.83 41.97 C38.24 45.34, 33.42 47.95, 28.05 48.44 C22.67 48.92, 13.9 47.96, 9.59 44.88 C5.27 41.8, 3.47 35.39, 2.14 29.96 C0.8 24.53, -0.46 16.96, 1.56 12.29 C3.58 7.61, 11.82 3.49, 14.25 1.89 C16.68 0.28, 15.96 2.1, 16.14 2.65" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(138.91046609302816 180.6496504651568) rotate(0 4.6699981689453125 12.5)"><text x="4.6699981689453125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">n</text></g><g stroke-linecap="round"><g transform="translate(215.77820567979904 126.60830634511768) rotate(0 -26.032750436520644 22.954731361436785)"><path d="M0.5 -0.21 C-7.93 7.6, -42.96 39.22, -51.47 47.28 M-0.7 -1.37 C-9.23 6.03, -44.18 37.33, -52.56 45.29" stroke="#e03131" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(81.85668501673524 261.12501582441627) rotate(0 81.37992858886719 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">delete leaf node</text></g><g stroke-linecap="round"><g transform="translate(150.5571561887034 253.98259109218793) rotate(0 -1.4792600071012316 -15.161028148833736)"><path d="M0.91 -0.61 C0.56 -5.82, -2.18 -26.65, -2.71 -32 M-0.07 1.68 C-0.57 -3.28, -3.38 -24.99, -3.87 -30.57" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(150.5571561887034 253.98259109218793) rotate(0 -1.4792600071012316 -15.161028148833736)"><path d="M2.38 -16.84 C1.23 -19.79, -1.46 -23.56, -2.75 -30.61 M3.71 -16.38 C1.3 -22.41, -2.34 -27.85, -3.48 -30.94" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(150.5571561887034 253.98259109218793) rotate(0 -1.4792600071012316 -15.161028148833736)"><path d="M-8.45 -15.63 C-6.88 -18.97, -6.84 -23.04, -2.75 -30.61 M-7.13 -15.18 C-5.38 -21.63, -4.87 -27.52, -3.48 -30.94" stroke="#e03131" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(10 94.3176106681853) rotate(0 57.719947814941406 25)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">delete link </text><text x="0" y="25" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">from parent</text></g><g stroke-linecap="round"><g transform="translate(131.8540078046376 106.96647144720833) rotate(0 30.19601026989986 13.515458909854118)"><path d="M-0.55 -0.53 C3.97 0.1, 16.3 -1.44, 26.55 3.12 C36.8 7.69, 55.43 22.79, 60.94 26.84 M1.36 1.8 C5.76 2.6, 15.6 -0.18, 25.47 4.11 C35.35 8.41, 54.92 23.54, 60.61 27.57" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(131.8540078046376 106.96647144720833) rotate(0 30.19601026989986 13.515458909854118)"><path d="M40.06 21.45 C44.08 24.75, 48.83 24.01, 59.7 26.22 M40.23 22.34 C45.62 24.24, 51.99 24.4, 59.96 28.08" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(131.8540078046376 106.96647144720833) rotate(0 30.19601026989986 13.515458909854118)"><path d="M48.33 10.15 C50.23 16.22, 52.91 18.3, 59.7 26.22 M48.5 11.03 C51.65 16, 55.74 19.27, 59.96 28.08" stroke="#e03131" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(434.5155595612206 40.504277147181085) rotate(0 25 24.5)"><path d="M34.51 1.45 C39.28 3.13, 43.76 8.2, 46.24 12.91 C48.72 17.63, 50.28 24.58, 49.4 29.75 C48.52 34.92, 45.13 40.6, 40.93 43.95 C36.74 47.31, 29.8 50.04, 24.23 49.88 C18.66 49.71, 11.45 46.53, 7.51 42.97 C3.57 39.4, 1.21 33.7, 0.6 28.49 C-0.02 23.28, 1.14 16.41, 3.84 11.71 C6.54 7.01, 10.85 1.5, 16.79 0.29 C22.73 -0.91, 35.26 3.23, 39.47 4.47 C43.67 5.72, 42.29 7.45, 42.01 7.77 M19.95 1.27 C24.34 0.12, 29.38 1.37, 34.11 3.73 C38.85 6.09, 46.03 11, 48.39 15.45 C50.75 19.91, 49.72 25.69, 48.27 30.43 C46.82 35.18, 44.11 41.05, 39.7 43.93 C35.29 46.8, 27.05 47.92, 21.82 47.68 C16.58 47.45, 12.07 45.82, 8.29 42.51 C4.5 39.19, -0.13 33.28, -0.91 27.78 C-1.69 22.27, 0.55 14.04, 3.6 9.48 C6.65 4.92, 15.03 1.78, 17.39 0.42 C19.75 -0.95, 17.45 1.02, 17.77 1.29" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(454.4078973557756 52.68016100811067) rotate(0 4.92999267578125 12.5)"><text x="4.92999267578125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">p</text></g><g stroke-linecap="round" transform="translate(362.1977025400482 118.77403822444228) rotate(0 25 24.5)"><path d="M33.5 2 C38.62 3.57, 44.53 7.76, 47.16 12.33 C49.8 16.9, 50.41 24.21, 49.31 29.44 C48.2 34.67, 44.7 40.4, 40.54 43.69 C36.37 46.99, 29.49 49.39, 24.32 49.23 C19.15 49.07, 13.36 46.22, 9.5 42.75 C5.63 39.28, 2.16 33.51, 1.13 28.41 C0.11 23.3, 0.9 16.52, 3.37 12.13 C5.84 7.75, 10.51 3.82, 15.94 2.12 C21.37 0.42, 32.04 1.59, 35.95 1.96 C39.86 2.33, 39.65 3.8, 39.41 4.35 M24.74 0.55 C29.96 0.08, 37.07 1.87, 41.02 5.42 C44.97 8.96, 47.68 16.36, 48.44 21.84 C49.2 27.32, 48.09 34.16, 45.57 38.28 C43.05 42.4, 38.15 45.28, 33.33 46.57 C28.51 47.86, 21.54 47.56, 16.64 46.02 C11.74 44.48, 6.74 41.67, 3.93 37.31 C1.12 32.96, -1.34 25.26, -0.22 19.87 C0.91 14.49, 6.33 8.19, 10.66 5.01 C14.99 1.84, 23.1 1.53, 25.75 0.85 C28.41 0.18, 26.81 0.59, 26.57 0.98" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(382.3500348414392 130.94992208537184) rotate(0 4.6699981689453125 12.5)"><text x="4.6699981689453125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">n</text></g><g stroke-linecap="round"><g transform="translate(440.7664761001813 83.15815589824456) rotate(0 -19.003524547059556 20.111153968410946)"><path d="M0.84 0.48 C-5.44 7.07, -31.67 32.8, -38.38 39.51 M-0.17 -0.32 C-6.47 6.39, -32.17 33.45, -38.85 40.54" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(432.729770600141 193.1748018025787) rotate(0 25 24.5)"><path d="M14.25 1.72 C18.86 -0.84, 26.9 -1.2, 32.04 0.31 C37.18 1.82, 41.98 6.35, 45.08 10.77 C48.17 15.18, 51.09 21.6, 50.61 26.8 C50.13 32, 46.26 38.17, 42.22 41.98 C38.19 45.78, 31.68 49.2, 26.4 49.62 C21.12 50.04, 14.75 47.65, 10.53 44.5 C6.32 41.35, 2.57 35.96, 1.11 30.74 C-0.35 25.51, -1.05 18.03, 1.77 13.16 C4.6 8.28, 14.89 3.54, 18.07 1.48 C21.24 -0.58, 20.55 0.54, 20.8 0.79 M17.77 0.81 C22.36 -0.78, 30.56 0.05, 35.42 2.41 C40.28 4.76, 44.87 10.07, 46.93 14.94 C48.99 19.8, 49.26 26.72, 47.79 31.59 C46.32 36.45, 42.17 41.22, 38.1 44.14 C34.03 47.06, 28.56 49.61, 23.39 49.1 C18.21 48.59, 11.06 45.06, 7.04 41.09 C3.02 37.12, -0.43 30.58, -0.73 25.26 C-1.04 19.93, 2.09 13.06, 5.23 9.15 C8.36 5.24, 15.85 2.89, 18.07 1.8 C20.28 0.72, 18.26 2.61, 18.52 2.62" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(450.882102901532 205.35068566350827) rotate(0 6.6699981689453125 12.5)"><text x="6.6699981689453125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">a</text></g><g stroke-linecap="round"><g transform="translate(403.8636569317482 162.32065251863463) rotate(0 18.580672926163288 17.907691490069908)"><path d="M1.11 1.15 C7.42 6.92, 30.77 29.61, 36.92 35.1 M0.24 0.71 C6.42 6.09, 29.46 27.54, 35.67 33.29" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(428.26719308442875 64.11158928527544) rotate(0 -37.926224534371045 51.36012660123397)"><path d="M-0.21 -0.1 C-12.12 10.82, -61.34 49.52, -72.08 66.68 C-82.82 83.83, -65.96 96.6, -64.65 102.82" stroke="#1971c2" stroke-width="1.5" fill="none" stroke-dasharray="8 9"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(365.1751123772001 167.6774154397121) rotate(0 30.99970888059437 23.385769639398518)"><path d="M-0.23 0.45 C10.06 8.26, 51.69 38.93, 62.23 46.32" stroke="#1971c2" stroke-width="1.5" fill="none" stroke-dasharray="8 9"></path></g></g><mask></mask><g transform="translate(459.82768006174115 115.00102599450554) rotate(0 85.61992645263672 25)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">delete node with </text><text x="0" y="25" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">just one child</text></g><g stroke-linecap="round"><g transform="translate(453.86107508209705 142.4650061793921) rotate(0 -18.885884568086112 -0.2855177181042734)"><path d="M0.77 -0.79 C-5.45 -1.05, -31.48 -0.34, -37.97 -0.48 M-0.29 1.41 C-6.54 1.36, -32.14 -1.69, -38.54 -1.99" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(453.86107508209705 142.4650061793921) rotate(0 -18.885884568086112 -0.2855177181042734)"><path d="M-21.11 -5.86 C-22.49 -4.87, -28.99 -5.89, -37.03 -0.5 M-20.55 -6.55 C-25.15 -4.94, -29.96 -3.8, -37.93 -2.19" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(453.86107508209705 142.4650061793921) rotate(0 -18.885884568086112 -0.2855177181042734)"><path d="M-22.25 7.34 C-23.47 5.07, -29.68 0.81, -37.03 -0.5 M-21.69 6.65 C-25.94 4.94, -30.47 2.77, -37.93 -2.19" stroke="#e03131" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(328.8672913001087 273.0290782364516) rotate(0 136.9198760986328 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">promoted grandchild to child</text></g><g stroke-linecap="round"><g transform="translate(395.5307592046038 267.672283527892) rotate(0 18.301646194684622 -16.142914588965567)"><path d="M-0.06 0.36 C6.48 -4.92, 31.58 -25.52, 38.16 -31.08 M-1.56 -0.49 C4.89 -6.15, 30.16 -27.38, 36.93 -32.65" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(395.5307592046038 267.672283527892) rotate(0 18.301646194684622 -16.142914588965567)"><path d="M24.64 -11.94 C28.34 -14.26, 27.81 -18.02, 36.4 -32.79 M24.7 -11.46 C26.72 -16.62, 29.19 -19.89, 36.62 -32.63" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(395.5307592046038 267.672283527892) rotate(0 18.301646194684622 -16.142914588965567)"><path d="M13.78 -25.29 C19.79 -24.85, 21.5 -25.85, 36.4 -32.79 M13.85 -24.8 C18.42 -26.88, 23.34 -27.12, 36.62 -32.63" stroke="#1971c2" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(828.2909186865144 10) rotate(0 25 24.5)"><path d="M30.9 0.42 C36.12 1.29, 42.51 6.37, 45.61 10.64 C48.71 14.9, 49.75 20.99, 49.49 26.01 C49.23 31.03, 47.7 37.03, 44.07 40.75 C40.45 44.46, 33.32 47.7, 27.74 48.3 C22.17 48.9, 14.98 47.04, 10.63 44.33 C6.27 41.61, 3.21 36.92, 1.64 32.01 C0.07 27.1, -0.75 19.63, 1.22 14.87 C3.18 10.11, 7.8 5.47, 13.43 3.44 C19.06 1.41, 30.59 2.48, 34.99 2.7 C39.39 2.92, 39.97 4.53, 39.83 4.76 M16.52 1.4 C20.93 -1.05, 27.32 -0.94, 32.33 0.5 C37.35 1.95, 43.47 5.65, 46.62 10.08 C49.76 14.5, 51.87 21.5, 51.2 27.05 C50.54 32.6, 46.93 39.52, 42.64 43.36 C38.35 47.2, 30.92 49.94, 25.46 50.11 C20 50.29, 13.82 47.54, 9.88 44.39 C5.94 41.25, 3.18 36.28, 1.83 31.25 C0.48 26.21, -0.28 19.12, 1.76 14.17 C3.81 9.22, 11.86 3.61, 14.11 1.57 C16.36 -0.47, 14.87 1.27, 15.28 1.94" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(848.1832564810694 22.175883860929588) rotate(0 4.92999267578125 12.5)"><text x="4.92999267578125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">p</text></g><g stroke-linecap="round" transform="translate(755.9730616653422 88.26976107726114) rotate(0 25 24.5)"><path d="M22.11 0.38 C27.16 -0.63, 35.47 1.03, 39.91 3.87 C44.34 6.71, 47.56 12.42, 48.74 17.42 C49.91 22.43, 49.03 28.99, 46.96 33.9 C44.89 38.81, 41.14 44.54, 36.31 46.91 C31.49 49.28, 23.31 49.36, 18 48.13 C12.7 46.89, 7.47 43.64, 4.47 39.49 C1.47 35.34, -0.59 28.58, 0.02 23.23 C0.62 17.88, 3.45 11.26, 8.11 7.38 C12.77 3.49, 24 0.77, 27.98 -0.07 C31.96 -0.92, 31.99 1.74, 32 2.31 M21.43 -0.83 C26.64 -1.96, 34.42 -0.17, 39.06 2.83 C43.69 5.83, 47.78 11.93, 49.22 17.16 C50.66 22.38, 49.66 29.35, 47.69 34.19 C45.71 39.03, 41.69 43.57, 37.36 46.19 C33.02 48.82, 27.13 50.8, 21.69 49.94 C16.25 49.07, 8.54 45.33, 4.72 41 C0.9 36.68, -1.39 29.45, -1.22 23.99 C-1.05 18.52, 2 11.9, 5.72 8.2 C9.44 4.5, 18.52 3.1, 21.09 1.77 C23.66 0.44, 21.01 0.11, 21.16 0.23" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(776.1253939667332 100.4456449381907) rotate(0 4.6699981689453125 12.5)"><text x="4.6699981689453125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">n</text></g><g stroke-linecap="round"><g transform="translate(834.541835225475 52.65387875106342) rotate(0 -19.320108339626813 20.404923762340474)"><path d="M1.1 -0.57 C-5.35 6.19, -32.15 34.61, -38.96 41.38 M0.22 1.74 C-6.34 8.1, -32.9 33.17, -39.74 39.74" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(842.5757363634888 166.24168934028847) rotate(0 25 24.5)"><path d="M18.88 -0.18 C23.93 -1.42, 32.41 0.57, 37.16 3.11 C41.91 5.66, 45.47 10.17, 47.38 15.11 C49.29 20.04, 50.14 27.58, 48.63 32.7 C47.12 37.82, 42.64 43.16, 38.3 45.85 C33.96 48.53, 27.87 49.67, 22.6 48.82 C17.33 47.97, 10.55 44.55, 6.66 40.76 C2.76 36.96, -0.62 31.13, -0.77 26.06 C-0.92 20.98, 1.4 14.66, 5.76 10.31 C10.12 5.96, 21.15 1.38, 25.39 -0.04 C29.63 -1.47, 31.29 1.2, 31.2 1.77 M19.76 1.54 C24.6 0.26, 32.4 0.97, 37.38 3.6 C42.36 6.23, 47.96 12.31, 49.65 17.32 C51.34 22.32, 49.74 28.96, 47.53 33.62 C45.33 38.29, 40.91 42.87, 36.41 45.3 C31.92 47.74, 25.6 48.82, 20.57 48.23 C15.53 47.65, 9.59 45.82, 6.2 41.79 C2.82 37.76, 0.2 29.59, 0.24 24.05 C0.28 18.51, 3.05 12.49, 6.46 8.55 C9.86 4.61, 18.31 1.81, 20.66 0.4 C23.02 -1.01, 20.38 -0.46, 20.59 0.07" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(862.3180726321649 178.41757320121803) rotate(0 5.079994201660156 12.5)"><text x="5.079994201660156" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">b</text></g><g stroke-linecap="round"><g transform="translate(799.2255000437284 130.92984934289694) rotate(0 25.613886106556606 19.938221619139853)"><path d="M-0.62 -0.96 C7.74 5.92, 41.02 34.12, 49.6 40.83 M1.26 1.16 C10.03 7.72, 43.67 32.55, 51.84 39.05" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(853.6030391870348 84.4967488473244) rotate(0 85.61992645263672 25)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">delete node with </text><text x="0" y="25" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#e03131" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">both children</text></g><g stroke-linecap="round" transform="translate(674.4209642539912 170.7057246651076) rotate(0 25 24.5)"><path d="M30.67 0.78 C35.58 1.94, 41.25 6.63, 44.42 10.72 C47.59 14.81, 49.91 20.1, 49.68 25.32 C49.44 30.54, 46.56 38.08, 43.03 42.02 C39.51 45.96, 33.95 48.64, 28.53 48.96 C23.12 49.28, 15.18 46.82, 10.54 43.94 C5.91 41.06, 2.01 36.58, 0.73 31.67 C-0.55 26.77, 0.49 19.27, 2.85 14.52 C5.2 9.77, 9.49 5.3, 14.86 3.16 C20.22 1.01, 31.18 1.39, 35.03 1.63 C38.88 1.88, 38.22 4.1, 37.94 4.63 M34.69 1.58 C39.56 3.12, 45.47 9.11, 47.75 14.1 C50.04 19.09, 49.92 26.51, 48.4 31.55 C46.89 36.58, 43.05 41.41, 38.65 44.29 C34.25 47.18, 27.31 49.15, 22.01 48.84 C16.71 48.52, 10.65 45.95, 6.86 42.4 C3.07 38.85, -0.42 32.74, -0.71 27.55 C-1 22.36, 1.89 15.48, 5.11 11.27 C8.33 7.06, 13.65 3.83, 18.61 2.28 C23.58 0.74, 32.38 1.74, 34.89 2 C37.4 2.26, 33.96 3.25, 33.68 3.83" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(692.5732965553822 182.88160852603716) rotate(0 6.6699981689453125 12.5)"><text x="6.6699981689453125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">a</text></g><g stroke-linecap="round" transform="translate(766.3803700857328 252.3979326919063) rotate(0 25 24.5)"><path d="M34.26 0.73 C39.36 2.36, 44.98 7.73, 47.46 12.62 C49.95 17.51, 50.34 24.81, 49.18 30.07 C48.03 35.34, 44.65 40.99, 40.52 44.21 C36.39 47.44, 29.61 49.65, 24.41 49.44 C19.2 49.22, 13.14 46.45, 9.27 42.9 C5.39 39.36, 2.06 33.28, 1.16 28.15 C0.25 23.01, 1.27 16.41, 3.86 12.09 C6.45 7.78, 11.37 3.96, 16.7 2.26 C22.02 0.56, 32.81 1.87, 35.83 1.89 C38.84 1.91, 35.09 2.14, 34.78 2.39 M29.28 0.56 C34.36 0.9, 39.72 3.53, 43.15 7.62 C46.58 11.72, 49.45 19.65, 49.84 25.13 C50.23 30.6, 48.73 36.5, 45.48 40.46 C42.23 44.41, 36.08 48.21, 30.36 48.83 C24.63 49.46, 16 46.93, 11.15 44.19 C6.3 41.45, 2.67 37.25, 1.27 32.4 C-0.14 27.55, 0.71 19.78, 2.71 15.09 C4.71 10.4, 8.7 6.77, 13.25 4.26 C17.8 1.75, 27.45 0.68, 30.01 0.02 C32.56 -0.65, 28.64 -0.16, 28.57 0.27" stroke="#1971c2" stroke-width="1" fill="none"></path></g><g transform="translate(786.1827039130027 264.57381655283586) rotate(0 5.019996643066406 12.5)"><text x="5.019996643066406" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">c</text></g><g stroke-linecap="round"><g transform="translate(849.3074638085362 210.27244974699244) rotate(0 -20.96223600105816 22.82803888988306)"><path d="M0.56 -1.1 C-6.21 6.63, -34.41 37.55, -41.27 45.67 M-0.6 0.94 C-7.52 8.86, -35.7 39.28, -42.49 46.75" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g mask="url(#mask-auYJAYSWU0Y4nqaNVj4Vr)" stroke-linecap="round"><g transform="translate(788.2555334380539 252.9408835138483) rotate(0 -1.255712092951967 -55.85221663337887)"><path d="M0.89 -0.06 C0.34 -18.82, -2.64 -93.1, -3.41 -111.64" stroke="#2f9e44" stroke-width="1.5" fill="none" stroke-dasharray="8 9"></path></g><g transform="translate(788.2555334380539 252.9408835138483) rotate(0 -1.255712092951967 -55.85221663337887)"><path d="M7.88 -83.61 C3.86 -92.24, 1.03 -100.28, -1.91 -109.75" stroke="#2f9e44" stroke-width="1.5" fill="none"></path></g><g transform="translate(788.2555334380539 252.9408835138483) rotate(0 -1.255712092951967 -55.85221663337887)"><path d="M-12.62 -82.78 C-10.61 -91.8, -7.39 -100.09, -1.91 -109.75" stroke="#2f9e44" stroke-width="1.5" fill="none"></path></g></g><mask id="mask-auYJAYSWU0Y4nqaNVj4Vr"><rect x="0" y="0" fill="#fff" width="891.8266663354626" height="464.2445298353822"></rect><rect x="743.0200158174746" y="184.78906035308137" fill="#000" width="86.89990234375" height="25" opacity="1"></rect></mask><g transform="translate(743.0200158174746 184.7890603530813) rotate(0 43.97980552762749 12.299606527388107)"><text x="43.449951171875" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#2f9e44" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">promoted</text></g><g stroke-linecap="round"><g transform="translate(758.6520827987885 126.07391848998896) rotate(0 -22.563896785000225 23.61814002298985)"><path d="M0.12 -0.43 C-7.42 7.77, -36.71 40.73, -44.07 48.94 M-1.28 -1.71 C-9.12 6.19, -37.97 39.16, -45.25 47.26" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(846.5858175280651 110.09121273244097) rotate(0 -18.260838335179642 1.3599297907448715)"><path d="M0 0.8 C-6.05 1.06, -30.57 0.94, -36.53 1.06 M-1.45 0.18 C-7.1 0.66, -28.4 2.67, -34.24 2.53" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(846.5858175280651 110.09121273244097) rotate(0 -18.260838335179642 1.3599297907448715)"><path d="M-16.53 -5.48 C-22.59 -2.36, -26.52 0.83, -35.81 2.9 M-17.11 -4.33 C-22.82 -1.37, -27.67 0.89, -34.47 3.2" stroke="#e03131" stroke-width="1" fill="none"></path></g><g transform="translate(846.5858175280651 110.09121273244097) rotate(0 -18.260838335179642 1.3599297907448715)"><path d="M-16.02 6.73 C-22.18 6.41, -26.25 6.16, -35.81 2.9 M-16.6 7.88 C-22.59 6.91, -27.6 5.25, -34.47 3.2" stroke="#e03131" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(855.3800140170632 240.88730691350656) rotate(0 102.9999008178711 25)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">successor to replace</text><text x="0" y="25" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="#1971c2" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">target node</text></g></svg>

=== "Deletion"

    ```java
    public static BinaryTreeNode delete(BinaryTreeNode root, int key) {
      if (root == null) return null;

      if (key == root.key)
        return deleteRoot(root);

      SearchPair pair = search(root, key);
      if (!pair.found()) // nothing to do.
        return root;

      BinaryTreeNode target = pair.node;
      BinaryTreeNode parent = pair.parent;

      if (target.left == null || target.right == null) { // even works when it's a leaf.
        BinaryTreeNode child = target.left == null ? target.right : target.left;
        if (key < parent.key) parent.left = child;
        else parent.right = child;
        return root;
      }

      BinaryTreeNode successor = successor(target, parent);
      target.key = successor.key;
      target.right = delete(target.right, successor.key); // don't miss this.
      return root;
    }

    private static BinaryTreeNode deleteRoot(BinaryTreeNode root) {
      if (root.leaf())
        return null;
      if (root.left == null)
        return root.right;
      if (root.right == null)
        return root.left;

      BinaryTreeNode successor = successor(root, null);
      root.key = successor.key;
      root.right = delete(root.right, successor.key); // don't forget this.
      return root;
    }
    ```

=== "Unit test"

    ```java
    import static org.junit.jupiter.api.Assertions.*;

    import org.junit.jupiter.api.BeforeEach;
    import org.junit.jupiter.api.Test;

    class BinaryTreeNodeDeletionTest {

      BinaryTreeNode root;

      @BeforeEach
      public void setup() {
        /*
              ╭---10----╮
            ╭-8-╮     ╭-16-╮
            1   9    12    20
        */
        root = new BinaryTreeNode(10);
        BinaryTreeNode.insertExternal(root, 16);
        BinaryTreeNode.insertExternal(root, 12);
        BinaryTreeNode.insertExternal(root, 20);
        BinaryTreeNode.insertExternal(root, 8);
        BinaryTreeNode.insertExternal(root, 1);
        BinaryTreeNode.insertExternal(root, 9);
      }

      @Test
      public void deleteLeftLeaf() {
        root = BinaryTreeNode.delete(root, 1);
        String expected = """
            ╭---10----╮
            8-╮     ╭-16-╮
              9    12    20""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void deleteRightLeaf() {
        root = BinaryTreeNode.delete(root, 20);
        String expected = """
              ╭---10----╮
            ╭-8-╮     ╭-16
            1   9    12""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void deleteNodeWithSingleChild() {
        root = BinaryTreeNode.delete(root, 20);
        root = BinaryTreeNode.delete(root, 16);
        String expected = """
              ╭---10-╮
            ╭-8-╮    12
            1   9  \s""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void deleteNodeWithBothChildren() {
        root = BinaryTreeNode.delete(root, 8);
        String expected = """
              ╭-10----╮
            ╭-9     ╭-16-╮
            1      12    20""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void deleteRoot() {
        root = BinaryTreeNode.delete(root, 10);
        String expected = """
              ╭---12-╮
            ╭-8-╮    16-╮
            1   9       20""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void deleteRootAgain() {
        root = BinaryTreeNode.delete(root, 10);
        root = BinaryTreeNode.delete(root, 12);
        String expected = """
              ╭---16-╮
            ╭-8-╮    20
            1   9  \s""";
        assertEquals(expected, root.toString());
      }

      @Test
      public void deleteRootAndAgain() {
        root = BinaryTreeNode.delete(root, 10);
        root = BinaryTreeNode.delete(root, 12);
        root = BinaryTreeNode.delete(root, 16);
        String expected = """
              ╭---20
            ╭-8-╮
            1   9""";
        assertEquals(expected, root.toString());
      }
    }
    ```