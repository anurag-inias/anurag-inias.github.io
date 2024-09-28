# Singleton

<style>
.md-logo img {
  content: url('/design-patterns/logo-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/design-patterns/logo-dark.png');
}
</style>


!!! abstract ""

    Ensure a class has only one instance.

=== "Kotlin"

    ```kotlin
    class Singleton private constructor() {
      companion object {  
        val INSTANCE: Singleton by lazy(
          LazyThreadSafetyMode.SYNCHRONIZED
        ) { Singleton() }
      }
    }
    ```

    or even just:

    ```kotlin
    object Singleton {
    }
    ```

=== "Java"

    ```java
    public class Singleton {
      
      // Private constructor so new instances cannot be created.
      private Singleton() {}

      // Proper way to get this single instance.
      public static Singleton getInstance() {
        return Holder.INSTANCE;
      }

      private static class Holder {
        private static final Singleton INSTANCE = new Singleton();
      }
    }
    ```

    Nested class is not referenced before `getInstance()` is called, and thus is loaded on-demand by class loader. This solution is thread safe without needing `volatile` or `synchronized`.
