# Searching

## Binary Search

Halves the search space in each iteration.

=== "Implementation"

    ```java linenums="1"
    public static SuccessOr<Integer> search(int[] array, int needle) {
      if (array == null || array.length < 1) return SuccessOr.failure();

      int l = 0, r = array.length-1;
      while (l <= r) {
        int m = l + (r - l) / 2;
        switch (Integer.compare(needle, array[m])) {
          case 0 -> {
            return SuccessOr.success(m);
          }
          case -1 -> r = m - 1; // needle < array[m]
          default -> l = m + 1; // needle > array[m]
        }
      }
      return SuccessOr.failure(l); // the two cursors have switched places
    }
    ```

=== "`SuccessOr` definition"

    ```java linenums="1"
    class SuccessOr<T> {
      private T value;
      private boolean success;

      private SuccessOr(){}

      public static <T> SuccessOr<T> success(T value) {
        SuccessOr<T> successOr = new SuccessOr<>();
        successOr.value = value;
        successOr.success = true;
        return successOr;
      }

      public static <T> SuccessOr<T> failure(T value) {
        SuccessOr<T> successOr = new SuccessOr<>();
        successOr.value = value;
        successOr.success = false;
        return successOr;
      }

      public static <T> SuccessOr<T> failure() {
        SuccessOr<T> successOr = new SuccessOr<>();
        successOr.success = false;
        return successOr;
      }

      public boolean success() {
        return success;
      }

      public Optional<T> value() {
        return Optional.ofNullable(value);
      }
    }
    ```
