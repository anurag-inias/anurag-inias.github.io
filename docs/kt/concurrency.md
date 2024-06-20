#  Coroutines

<style>
.md-logo img {
  content: url('/kt/k-light.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/kt/k-dark.svg');
}
</style>

## Coroutines

### Intro

[source](https://kotlinlang.org/docs/coroutines-basics.html) and [Kotlin in Action 2](https://www.manning.com/books/kotlin-in-action-second-edition)

A coroutine is an instance of suspendable computation. Conceptually similar to a thread, but with a number of advantages:

1. Unlike threads, cheap to make. One can run 100K or more coroutines on a bog standard laptop.
2. Unlike threads, doesn't block system resources when suspended.
3. Structured concurrency ensures that child coroutines don't hang around when parent coroutine is cancelled.

Under the hood, coroutines are implemented by running on one or more JVM threads. Over its life, a coroutine may start on one thread, suspend, and then resume on another.

```kotlin linenums="1"
fun main() = runBlocking {
  launch {
    delay(1000L)
    println("World!")
  }
  print("hello ")
}
```

this prints `Hello World!`. Let's break it down:

1. `runBlocking` is a **coroutine builder**, a special one at that which bridges the regular blocking code with suspending functions. Without it, `launch` line will give the error `Unresolved reference: launch`. It's called `runBlocking` because the thread that runs it (i.e. main thread here) gets blocked for the duration of the call.

2. `launch` is another coroutine builder that launches a new coroutine concurrently with the rest of the code. That's why `Hello` gets printed first.

3. `delay` is a special **suspending function** that suspends the coroutine for the specified time. Unlike `Thread.sleep`, this does not block the underlying thread, and instead allows other coroutine to take turn.

4. A suspending function can only be called from another suspending function or a coroutine.

5. `launch` is meant for starting coroutines that don't return value. Actually, `launch` returns a `Job`, think of a `ListenableFuture<Void>`.

6. If you want a result from a coroutine, start it with `async` which returns a `Deferred<T>`.

Another example:

<div class="grid" markdown>   

```kotlin linenums="1"
fun main() = runBlocking {
  println("parent starts")                 // 1

  launch {
    println("second coroutine")            // 3
    delay(100.milliseconds)
    println("second coroutine resumed")    // 5
  }

  launch {
    println("third coroutine")             // 4
  }

  println("parent launched 2 coroutines")  // 2
}
```

```text linenums="1"
parent starts
parent launched 2 coroutines
second coroutine
third coroutine
second coroutine resumed
```

</div>

### Dispatchers

```kotlin linenums="1"
launch(Dispatchers.Default) {
  // do something on default dispatcher
}
```

*Dispatcher* determines what thread(s) the coroutine uses for its execution. Dispatchers are inherited by child corountines from their parents. Following dispatchers are available out of the box:

Dispatcher | Number of threads | Used for
-----------|-------------------|----------
`Dispatchers.Default` | Number of CPU cores | General purpose CPU-bound
`Dispatchers.Main`    | One                 | UI work
`Dispatchers.IO`      | Auto-scaling <br> \\(\text{max}(\text{CPU cores}, 64)\\)        | Blocking IO task 
`Dispatchers.Unconfined` | Any               | Used for immediate scheduling
`limitedParallelism(n)`  | `n`               | Custom scenarios

- `Unconfined` executes coroutine immediately on current thread and later resumes it whatever thread called `resume`.
- `limitedParallelism(n)` creates a *view* of the current dispatcher but with guarantee that no more than `n` coroutines are executed at any time.

### `launch` and `async` 

<div class="grid" markdown>   

```kotlin linenums="1"
public fun CoroutineScope.launch(
  context: CoroutineContext = EmptyCoroutineContext,
  ...
): Job { ... }
```

```kotlin linenums="1"
public fun <T> CoroutineScope.async(
  context: CoroutineContext = EmptyCoroutineContext,
  ...
): Deferred<T> { ... }
```

</div>

Both coroutine builders are actually extension of `CoroutineScope`. Well, what is a `CoroutineScope`?

### CoroutineScope

```kotlin linenums="1"
public interface CoroutineScope {
  public val coroutineContext: CoroutineContext
}
```

It's just a wrapper arount `CoroutineContext`. And what is that?

### CoroutineContext

```kotlin linenums="1"
// Persistent context for the coroutine. It is an indexed set of [Element] instances.
public interface CoroutineContext {
  public operator fun <E : Element> get(key: Key<E>): E?
}

...

public interface Element : CoroutineContext {
  public val key: Key<*>
  ...
}
```

It's an indexed set of `Element`s, each of which are `CoroutineContext` themselves, exemplified in following snippet:

```kotlin linenums="1"
fun main() {
  val foo: CoroutineContext = CoroutineName("foo")
  println(foo[CoroutineName]) // CoroutineName(foo)
  println(foo[Job]) // null

  val bar: CoroutineContext = CoroutineName("bar")
  println(bar[CoroutineName]) // CoroutineName(bar)
  println(foo[Job]) // null

  println((foo + bar)[CoroutineName]) // CoroutineName(bar)
  println((bar + foo)[CoroutineName]) // CoroutineName(foo)
}
```

P.S. `EmptyCoroutineContext` seen before has no elements, as the name implies.  

{==

That is, coroutine context is a set of "elements". The main elements are `Job` and the dispatcher.

==}

```kotlin linenums="1"
fun main() {
  val foo: CoroutineContext = Dispatchers.Default + Job()
  println(foo[CoroutineName]) // null
  println(foo[Job]) // JobImpl{Active}@5c29bfd
  println(foo[Job]?.isActive) // true

  foo.job.cancel()

  println(foo[Job]?.isActive) // false
}
```

### Adding it all together

[Source - Roman Elizarov: Kotlin Project Lead](https://elizarov.medium.com/coroutine-context-and-scope-c8b255d59055)

Recall our prior example of launching a coroutine with a given dispatcher:

```kotlin linenums="1"
fun main() = runBlocking {
  launch(Dispatchers.IO + Job()) {  // Passed context = [IO + Job()]
  }
}
```

`launch`/`async` is passed a `CoroutineContext` as parameter. But it also is an extension of `CoroutineScope` which itself is wrapping a context. That is, a coroutine builder is actually taking in two contexts.

The two contexts are merged, with elements of passed in context taking precedence over the elements of implicit (scoped) context. This is the **parent context** of the new coroutine. The child context is this `parent context` \\(+\\) a new `Job()` (child of parent job).

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 719.3602843301508 837.2353025023804" width="640">
  <g stroke-linecap="round" transform="translate(10 10) rotate(0 103.66667175292969 104.66664123535156)"><path d="M32 0 C75.47 0, 118.94 0, 175.33 0 C196.67 0, 207.33 10.67, 207.33 32 C207.33 83.37, 207.33 134.74, 207.33 177.33 C207.33 198.67, 196.67 209.33, 175.33 209.33 C143.81 209.33, 112.29 209.33, 32 209.33 C10.67 209.33, 0 198.67, 0 177.33 C0 131.19, 0 85.05, 0 32 C0 10.67, 10.67 0, 32 0" stroke="none" stroke-width="0" fill="#ffec99"></path><path d="M32 0 C61.4 0, 90.79 0, 175.33 0 M32 0 C70.61 0, 109.22 0, 175.33 0 M175.33 0 C196.67 0, 207.33 10.67, 207.33 32 M175.33 0 C196.67 0, 207.33 10.67, 207.33 32 M207.33 32 C207.33 82.25, 207.33 132.51, 207.33 177.33 M207.33 32 C207.33 62.67, 207.33 93.33, 207.33 177.33 M207.33 177.33 C207.33 198.67, 196.67 209.33, 175.33 209.33 M207.33 177.33 C207.33 198.67, 196.67 209.33, 175.33 209.33 M175.33 209.33 C143.38 209.33, 111.43 209.33, 32 209.33 M175.33 209.33 C126.96 209.33, 78.58 209.33, 32 209.33 M32 209.33 C10.67 209.33, 0 198.67, 0 177.33 M32 209.33 C10.67 209.33, 0 198.67, 0 177.33 M0 177.33 C0 128.39, 0 79.46, 0 32 M0 177.33 C0 126.54, 0 75.74, 0 32 M0 32 C0 10.67, 10.67 0, 32 0 M0 32 C0 10.67, 10.67 0, 32 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g stroke-linecap="round" transform="translate(32.333343505859375 43.666778564453125) rotate(0 82.33334350585938 83.66667175292969)"><path d="M32 0 C58.41 0, 84.82 0, 132.67 0 C154 0, 164.67 10.67, 164.67 32 C164.67 62.52, 164.67 93.04, 164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 C98.35 167.33, 64.04 167.33, 32 167.33 C10.67 167.33, 0 156.67, 0 135.33 C0 104.59, 0 73.84, 0 32 C0 10.67, 10.67 0, 32 0" stroke="none" stroke-width="0" fill="#b2f2bb"></path><path d="M32 0 C71.82 0, 111.64 0, 132.67 0 M32 0 C69.9 0, 107.8 0, 132.67 0 M132.67 0 C154 0, 164.67 10.67, 164.67 32 M132.67 0 C154 0, 164.67 10.67, 164.67 32 M164.67 32 C164.67 69.43, 164.67 106.85, 164.67 135.33 M164.67 32 C164.67 65.01, 164.67 98.02, 164.67 135.33 M164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 M164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 M132.67 167.33 C101.64 167.33, 70.62 167.33, 32 167.33 M132.67 167.33 C111.72 167.33, 90.77 167.33, 32 167.33 M32 167.33 C10.67 167.33, 0 156.67, 0 135.33 M32 167.33 C10.67 167.33, 0 156.67, 0 135.33 M0 135.33 C0 111.34, 0 87.35, 0 32 M0 135.33 C0 94.17, 0 53.02, 0 32 M0 32 C0 10.67, 10.67 0, 32 0 M0 32 C0 10.67, 10.67 0, 32 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g stroke-linecap="round" transform="translate(56.33332824707031 97.33332824707031) rotate(0 56.66667175292969 24.333328247070312)"><path d="M12.17 0 C33.49 0, 54.8 0, 101.17 0 C109.28 0, 113.33 4.06, 113.33 12.17 C113.33 21.59, 113.33 31, 113.33 36.5 C113.33 44.61, 109.28 48.67, 101.17 48.67 C66.98 48.67, 32.8 48.67, 12.17 48.67 C4.06 48.67, 0 44.61, 0 36.5 C0 29.7, 0 22.89, 0 12.17 C0 4.06, 4.06 0, 12.17 0" stroke="none" stroke-width="0" fill="#ffc9c9"></path><path d="M12.17 0 C42.53 0, 72.89 0, 101.17 0 M12.17 0 C45.96 0, 79.75 0, 101.17 0 M101.17 0 C109.28 0, 113.33 4.06, 113.33 12.17 M101.17 0 C109.28 0, 113.33 4.06, 113.33 12.17 M113.33 12.17 C113.33 20.94, 113.33 29.71, 113.33 36.5 M113.33 12.17 C113.33 19.35, 113.33 26.54, 113.33 36.5 M113.33 36.5 C113.33 44.61, 109.28 48.67, 101.17 48.67 M113.33 36.5 C113.33 44.61, 109.28 48.67, 101.17 48.67 M101.17 48.67 C69.59 48.67, 38.01 48.67, 12.17 48.67 M101.17 48.67 C75.16 48.67, 49.15 48.67, 12.17 48.67 M12.17 48.67 C4.06 48.67, 0 44.61, 0 36.5 M12.17 48.67 C4.06 48.67, 0 44.61, 0 36.5 M0 36.5 C0 26.85, 0 17.2, 0 12.17 M0 36.5 C0 31.08, 0 25.66, 0 12.17 M0 12.17 C0 4.06, 4.06 0, 12.17 0 M0 12.17 C0 4.06, 4.06 0, 12.17 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(73.80001831054688 111.66665649414062) rotate(0 39.199981689453125 10)"><text x="39.199981689453125" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Scope Job</text></g><g transform="translate(52.99998474121094 62.66664123535156) rotate(0 56.86396789550781 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Scope Context</text></g><g stroke-linecap="round" transform="translate(58.33331298828125 153) rotate(0 56.66667175292969 25)"><path d="M12.5 0 C31.9 0, 51.3 0, 100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 C113.33 18.14, 113.33 23.79, 113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 C81.07 50, 61.31 50, 12.5 50 C4.17 50, 0 45.83, 0 37.5 C0 27.55, 0 17.61, 0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="none" stroke-width="0" fill="#a5d8ff"></path><path d="M12.5 0 C34.05 0, 55.6 0, 100.83 0 M12.5 0 C36.76 0, 61.02 0, 100.83 0 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M113.33 12.5 C113.33 19.31, 113.33 26.13, 113.33 37.5 M113.33 12.5 C113.33 19.84, 113.33 27.18, 113.33 37.5 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M100.83 50 C76.45 50, 52.06 50, 12.5 50 M100.83 50 C69.21 50, 37.6 50, 12.5 50 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M0 37.5 C0 30, 0 22.5, 0 12.5 M0 37.5 C0 31.83, 0 26.16, 0 12.5 M0 12.5 C0 4.17, 4.17 0, 12.5 0 M0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(74.76802062988281 158) rotate(0 40.231964111328125 20)"><text x="40.231964111328125" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Scope </text><text x="40.231964111328125" y="34.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">dispatcher</text></g><g transform="translate(55.66667175292969 16.666641235351562) rotate(0 52.327972412109375 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Parent Scope</text></g><g stroke-linecap="round" transform="translate(291.33335876464844 39.40373074054986) rotate(0 82.33334350585938 83.66667175292969)"><path d="M32 0 C70.54 0, 109.07 0, 132.67 0 C154 0, 164.67 10.67, 164.67 32 C164.67 56.83, 164.67 81.67, 164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 C94.89 167.33, 57.12 167.33, 32 167.33 C10.67 167.33, 0 156.67, 0 135.33 C0 100.59, 0 65.84, 0 32 C0 10.67, 10.67 0, 32 0" stroke="none" stroke-width="0" fill="#b2f2bb"></path><path d="M32 0 C59.33 0, 86.66 0, 132.67 0 M32 0 C59.17 0, 86.33 0, 132.67 0 M132.67 0 C154 0, 164.67 10.67, 164.67 32 M132.67 0 C154 0, 164.67 10.67, 164.67 32 M164.67 32 C164.67 55.92, 164.67 79.84, 164.67 135.33 M164.67 32 C164.67 55.97, 164.67 79.93, 164.67 135.33 M164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 M164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 M132.67 167.33 C106.63 167.33, 80.6 167.33, 32 167.33 M132.67 167.33 C102.12 167.33, 71.58 167.33, 32 167.33 M32 167.33 C10.67 167.33, 0 156.67, 0 135.33 M32 167.33 C10.67 167.33, 0 156.67, 0 135.33 M0 135.33 C0 114.62, 0 93.9, 0 32 M0 135.33 C0 95.92, 0 56.5, 0 32 M0 32 C0 10.67, 10.67 0, 32 0 M0 32 C0 10.67, 10.67 0, 32 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g stroke-linecap="round" transform="translate(315.3333435058594 93.07028042316705) rotate(0 56.66667175292969 24.333328247070312)"><path d="M12.17 0 C42.41 0, 72.66 0, 101.17 0 C109.28 0, 113.33 4.06, 113.33 12.17 C113.33 18.69, 113.33 25.21, 113.33 36.5 C113.33 44.61, 109.28 48.67, 101.17 48.67 C75.94 48.67, 50.72 48.67, 12.17 48.67 C4.06 48.67, 0 44.61, 0 36.5 C0 29.9, 0 23.29, 0 12.17 C0 4.06, 4.06 0, 12.17 0" stroke="none" stroke-width="0" fill="#ffc9c9"></path><path d="M12.17 0 C46.6 0, 81.04 0, 101.17 0 M12.17 0 C33.57 0, 54.98 0, 101.17 0 M101.17 0 C109.28 0, 113.33 4.06, 113.33 12.17 M101.17 0 C109.28 0, 113.33 4.06, 113.33 12.17 M113.33 12.17 C113.33 18.76, 113.33 25.35, 113.33 36.5 M113.33 12.17 C113.33 18.25, 113.33 24.33, 113.33 36.5 M113.33 36.5 C113.33 44.61, 109.28 48.67, 101.17 48.67 M113.33 36.5 C113.33 44.61, 109.28 48.67, 101.17 48.67 M101.17 48.67 C79.02 48.67, 56.87 48.67, 12.17 48.67 M101.17 48.67 C71.6 48.67, 42.03 48.67, 12.17 48.67 M12.17 48.67 C4.06 48.67, 0 44.61, 0 36.5 M12.17 48.67 C4.06 48.67, 0 44.61, 0 36.5 M0 36.5 C0 30.66, 0 24.81, 0 12.17 M0 36.5 C0 27.18, 0 17.86, 0 12.17 M0 12.17 C0 4.06, 4.06 0, 12.17 0 M0 12.17 C0 4.06, 4.06 0, 12.17 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(326.1920471191406 107.40360867023736) rotate(0 45.80796813964844 10)"><text x="45.80796813964844" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Passed Job</text></g><g transform="translate(312 58.4035934114483) rotate(0 63.471954345703125 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Passed Context</text></g><g stroke-linecap="round" transform="translate(317.3333282470703 148.73695217609674) rotate(0 56.66667175292969 25)"><path d="M12.5 0 C35.92 0, 59.33 0, 100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 C113.33 21.78, 113.33 31.07, 113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 C67.68 50, 34.53 50, 12.5 50 C4.17 50, 0 45.83, 0 37.5 C0 30.1, 0 22.69, 0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="none" stroke-width="0" fill="#a5d8ff"></path><path d="M12.5 0 C32.3 0, 52.1 0, 100.83 0 M12.5 0 C42.79 0, 73.08 0, 100.83 0 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M113.33 12.5 C113.33 19.63, 113.33 26.76, 113.33 37.5 M113.33 12.5 C113.33 17.7, 113.33 22.91, 113.33 37.5 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M100.83 50 C75.98 50, 51.12 50, 12.5 50 M100.83 50 C70.68 50, 40.52 50, 12.5 50 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M0 37.5 C0 30.18, 0 22.86, 0 12.5 M0 37.5 C0 27.78, 0 18.06, 0 12.5 M0 12.5 C0 4.17, 4.17 0, 12.5 0 M0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(333.7680358886719 153.73695217609674) rotate(0 40.231964111328125 20)"><text x="40.231964111328125" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Passed </text><text x="40.231964111328125" y="34.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">dispatcher</text></g><g transform="translate(224.3333282470703 107.33329772949219) rotate(0 29.199981689453125 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">.launch(</text></g><g transform="translate(464.9999542236328 108.66667175292969) rotate(0 2.7039947509765625 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">)</text></g><g stroke-linecap="round" transform="translate(248.84961572001765 280.3504679325322) rotate(0 9.333343505859375 9)"><path d="M18.67 9 C18.67 9.52, 18.62 10.05, 18.52 10.56 C18.43 11.08, 18.29 11.59, 18.1 12.08 C17.92 12.57, 17.69 13.05, 17.42 13.5 C17.15 13.95, 16.83 14.39, 16.48 14.79 C16.14 15.18, 15.75 15.56, 15.33 15.89 C14.92 16.23, 14.47 16.53, 14 16.79 C13.53 17.05, 13.03 17.28, 12.53 17.46 C12.02 17.64, 11.49 17.77, 10.95 17.86 C10.42 17.95, 9.87 18, 9.33 18 C8.79 18, 8.24 17.95, 7.71 17.86 C7.18 17.77, 6.65 17.64, 6.14 17.46 C5.63 17.28, 5.13 17.05, 4.67 16.79 C4.2 16.53, 3.75 16.23, 3.33 15.89 C2.92 15.56, 2.53 15.18, 2.18 14.79 C1.84 14.39, 1.52 13.95, 1.25 13.5 C0.98 13.05, 0.75 12.57, 0.56 12.08 C0.38 11.59, 0.24 11.08, 0.14 10.56 C0.05 10.05, 0 9.52, 0 9 C0 8.48, 0.05 7.95, 0.14 7.44 C0.24 6.92, 0.38 6.41, 0.56 5.92 C0.75 5.43, 0.98 4.95, 1.25 4.5 C1.52 4.05, 1.84 3.61, 2.18 3.21 C2.53 2.82, 2.92 2.44, 3.33 2.11 C3.75 1.77, 4.2 1.47, 4.67 1.21 C5.13 0.95, 5.63 0.72, 6.14 0.54 C6.65 0.36, 7.18 0.23, 7.71 0.14 C8.24 0.05, 8.79 0, 9.33 0 C9.87 0, 10.42 0.05, 10.95 0.14 C11.49 0.23, 12.02 0.36, 12.53 0.54 C13.03 0.72, 13.53 0.95, 14 1.21 C14.47 1.47, 14.92 1.77, 15.33 2.11 C15.75 2.44, 16.14 2.82, 16.48 3.21 C16.83 3.61, 17.15 4.05, 17.42 4.5 C17.69 4.95, 17.92 5.43, 18.1 5.92 C18.29 6.41, 18.43 6.92, 18.52 7.44 C18.62 7.95, 18.64 8.74, 18.67 9 C18.69 9.26, 18.69 8.74, 18.67 9" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(252.95260327681706 280.5980246022102) rotate(0 5 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">+</text></g><g stroke-linecap="round"><g transform="translate(112.60946970624201 228.84699342119825) rotate(0 64.78562623299743 30.704093191400887)"><path d="M0 0 C4.2 9.21, 3.58 45.03, 25.18 55.27 C46.77 65.5, 112.17 60.38, 129.57 61.41 M0 0 C4.2 9.21, 3.58 45.03, 25.18 55.27 C46.77 65.5, 112.17 60.38, 129.57 61.41" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(112.60946970624201 228.84699342119825) rotate(0 64.78562623299743 30.704093191400887)"><path d="M106.13 70.1 C111.66 68.05, 117.2 66, 129.57 61.41 M106.13 70.1 C112.33 67.8, 118.53 65.5, 129.57 61.41" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(112.60946970624201 228.84699342119825) rotate(0 64.78562623299743 30.704093191400887)"><path d="M106.03 53 C111.59 54.98, 117.14 56.97, 129.57 61.41 M106.03 53 C112.26 55.22, 118.49 57.45, 129.57 61.41" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(381.2615803484467 219.63579638524914) rotate(0 -52.65317361627018 35.002669611448425)"><path d="M0 0 C-1.99 10.34, 5.59 50.35, -11.97 62.02 C-29.52 73.69, -89.75 68.67, -105.31 70.01 M0 0 C-1.99 10.34, 5.59 50.35, -11.97 62.02 C-29.52 73.69, -89.75 68.67, -105.31 70.01" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(381.2615803484467 219.63579638524914) rotate(0 -52.65317361627018 35.002669611448425)"><path d="M-81.85 61.35 C-87.85 63.56, -93.84 65.77, -105.31 70.01 M-81.85 61.35 C-90.63 64.59, -99.41 67.83, -105.31 70.01" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(381.2615803484467 219.63579638524914) rotate(0 -52.65317361627018 35.002669611448425)"><path d="M-81.78 78.45 C-87.79 76.29, -93.8 74.13, -105.31 70.01 M-81.78 78.45 C-90.58 75.29, -99.39 72.13, -105.31 70.01" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(188.40217662014732 344.7568852467318) rotate(0 82.33334350585938 83.66667175292969)"><path d="M32 0 C69.47 0, 106.93 0, 132.67 0 C154 0, 164.67 10.67, 164.67 32 C164.67 60.08, 164.67 88.17, 164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 C98.87 167.33, 65.07 167.33, 32 167.33 C10.67 167.33, 0 156.67, 0 135.33 C0 101.59, 0 67.85, 0 32 C0 10.67, 10.67 0, 32 0" stroke="none" stroke-width="0" fill="#b2f2bb"></path><path d="M32 0 C59.27 0, 86.54 0, 132.67 0 M32 0 C66.29 0, 100.57 0, 132.67 0 M132.67 0 C154 0, 164.67 10.67, 164.67 32 M132.67 0 C154 0, 164.67 10.67, 164.67 32 M164.67 32 C164.67 66.27, 164.67 100.53, 164.67 135.33 M164.67 32 C164.67 66.08, 164.67 100.16, 164.67 135.33 M164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 M164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 M132.67 167.33 C111.46 167.33, 90.26 167.33, 32 167.33 M132.67 167.33 C93.24 167.33, 53.8 167.33, 32 167.33 M32 167.33 C10.67 167.33, 0 156.67, 0 135.33 M32 167.33 C10.67 167.33, 0 156.67, 0 135.33 M0 135.33 C0 101.97, 0 68.61, 0 32 M0 135.33 C0 101.24, 0 67.15, 0 32 M0 32 C0 10.67, 10.67 0, 32 0 M0 32 C0 10.67, 10.67 0, 32 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g stroke-linecap="round" transform="translate(212.40216136135825 398.423434929349) rotate(0 56.66667175292969 24.333328247070312)"><path d="M12.17 0 C33.01 0, 53.85 0, 101.17 0 C109.28 0, 113.33 4.06, 113.33 12.17 C113.33 21.1, 113.33 30.03, 113.33 36.5 C113.33 44.61, 109.28 48.67, 101.17 48.67 C66.59 48.67, 32.01 48.67, 12.17 48.67 C4.06 48.67, 0 44.61, 0 36.5 C0 27.51, 0 18.52, 0 12.17 C0 4.06, 4.06 0, 12.17 0" stroke="none" stroke-width="0" fill="#ffc9c9"></path><path d="M12.17 0 C36.56 0, 60.96 0, 101.17 0 M12.17 0 C31.05 0, 49.94 0, 101.17 0 M101.17 0 C109.28 0, 113.33 4.06, 113.33 12.17 M101.17 0 C109.28 0, 113.33 4.06, 113.33 12.17 M113.33 12.17 C113.33 18.71, 113.33 25.25, 113.33 36.5 M113.33 12.17 C113.33 17.53, 113.33 22.89, 113.33 36.5 M113.33 36.5 C113.33 44.61, 109.28 48.67, 101.17 48.67 M113.33 36.5 C113.33 44.61, 109.28 48.67, 101.17 48.67 M101.17 48.67 C81.23 48.67, 61.3 48.67, 12.17 48.67 M101.17 48.67 C69.22 48.67, 37.28 48.67, 12.17 48.67 M12.17 48.67 C4.06 48.67, 0 44.61, 0 36.5 M12.17 48.67 C4.06 48.67, 0 44.61, 0 36.5 M0 36.5 C0 27.17, 0 17.83, 0 12.17 M0 36.5 C0 29.04, 0 21.58, 0 12.17 M0 12.17 C0 4.06, 4.06 0, 12.17 0 M0 12.17 C0 4.06, 4.06 0, 12.17 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(224.8048560635067 412.7567631764193) rotate(0 44.26397705078125 10)"><text x="44.26397705078125" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Parent Job</text></g><g transform="translate(209.06881785549888 363.75674791763026) rotate(0 61.92796325683594 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Parent Context</text></g><g stroke-linecap="round" transform="translate(214.4021461025692 454.0901066822787) rotate(0 56.66667175292969 25)"><path d="M12.5 0 C42.44 0, 72.37 0, 100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 C113.33 21.21, 113.33 29.91, 113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 C68.29 50, 35.74 50, 12.5 50 C4.17 50, 0 45.83, 0 37.5 C0 29.32, 0 21.13, 0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="none" stroke-width="0" fill="#a5d8ff"></path><path d="M12.5 0 C46.3 0, 80.09 0, 100.83 0 M12.5 0 C33.61 0, 54.73 0, 100.83 0 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M113.33 12.5 C113.33 19.46, 113.33 26.42, 113.33 37.5 M113.33 12.5 C113.33 17.6, 113.33 22.69, 113.33 37.5 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M100.83 50 C80.78 50, 60.73 50, 12.5 50 M100.83 50 C75.27 50, 49.71 50, 12.5 50 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M0 37.5 C0 29.57, 0 21.64, 0 12.5 M0 37.5 C0 28.89, 0 20.28, 0 12.5 M0 12.5 C0 4.17, 4.17 0, 12.5 0 M0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(230.83685374417075 459.0901066822787) rotate(0 40.231964111328125 20)"><text x="40.231964111328125" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Parent </text><text x="40.231964111328125" y="34.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">dispatcher</text></g><g stroke-linecap="round"><g transform="translate(258.45387722736075 304.07201752356616) rotate(0 0.6140863614965326 15.352032540486277)"><path d="M0 0 C0.2 5.12, 1.02 25.59, 1.23 30.7 M0 0 C0.2 5.12, 1.02 25.59, 1.23 30.7" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(258.45387722736075 304.07201752356616) rotate(0 0.6140863614965326 15.352032540486277)"><path d="M-4.6 16.49 C-2.3 22.09, 0 27.7, 1.23 30.7 M-4.6 16.49 C-2.74 21.02, -0.89 25.54, 1.23 30.7" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(258.45387722736075 304.07201752356616) rotate(0 0.6140863614965326 15.352032540486277)"><path d="M5.9 16.07 C4.06 21.84, 2.22 27.61, 1.23 30.7 M5.9 16.07 C4.41 20.73, 2.92 25.39, 1.23 30.7" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(369.4448400985914 411.6152071236173) rotate(0 97.9439468383789 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">= Scope Job Passed Job</text></g><g stroke-linecap="round"><g transform="translate(387.4109449453599 429.65170161222625) rotate(0 39.915318337778274 -7.061901798318331)"><path d="M0 0 C7.27 -1.33, 30.29 -5.63, 43.6 -7.98 C56.9 -10.34, 73.79 -13.1, 79.83 -14.12 M0 0 C7.27 -1.33, 30.29 -5.63, 43.6 -7.98 C56.9 -10.34, 73.79 -13.1, 79.83 -14.12" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(363.6449949056705 465.0938393691159) rotate(0 156.33587646484375 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">= Parent dispatcher Passed dispatcher</text></g><g stroke-linecap="round"><g transform="translate(378.7688828335922 481.05983177417124) rotate(0 70.61939747396514 -5.526706977398192)"><path d="M0 0 C23.54 -1.84, 117.7 -9.21, 141.24 -11.05 M0 0 C23.54 -1.84, 117.7 -9.21, 141.24 -11.05" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(177.8152683403746 617.9020200316774) rotate(0 103.66667175292969 104.6666412353515)"><path d="M32 0 C65.03 0, 98.07 0, 175.33 0 C196.67 0, 207.33 10.67, 207.33 32 C207.33 73.65, 207.33 115.3, 207.33 177.33 C207.33 198.67, 196.67 209.33, 175.33 209.33 C131.98 209.33, 88.63 209.33, 32 209.33 C10.67 209.33, 0 198.67, 0 177.33 C0 133.14, 0 88.94, 0 32 C0 10.67, 10.67 0, 32 0" stroke="none" stroke-width="0" fill="#ffec99"></path><path d="M32 0 C63.61 0, 95.22 0, 175.33 0 M32 0 C79.13 0, 126.26 0, 175.33 0 M175.33 0 C196.67 0, 207.33 10.67, 207.33 32 M175.33 0 C196.67 0, 207.33 10.67, 207.33 32 M207.33 32 C207.33 88.11, 207.33 144.21, 207.33 177.33 M207.33 32 C207.33 86.97, 207.33 141.94, 207.33 177.33 M207.33 177.33 C207.33 198.67, 196.67 209.33, 175.33 209.33 M207.33 177.33 C207.33 198.67, 196.67 209.33, 175.33 209.33 M175.33 209.33 C145.23 209.33, 115.13 209.33, 32 209.33 M175.33 209.33 C139.1 209.33, 102.87 209.33, 32 209.33 M32 209.33 C10.67 209.33, 0 198.67, 0 177.33 M32 209.33 C10.67 209.33, 0 198.67, 0 177.33 M0 177.33 C0 130.74, 0 84.15, 0 32 M0 177.33 C0 129.63, 0 81.92, 0 32 M0 32 C0 10.67, 10.67 0, 32 0 M0 32 C0 10.67, 10.67 0, 32 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g stroke-linecap="round" transform="translate(200.14861184623396 651.5687985961305) rotate(0 82.33334350585938 83.66667175292963)"><path d="M32 0 C69.12 0, 106.24 0, 132.67 0 C154 0, 164.67 10.67, 164.67 32 C164.67 58.89, 164.67 85.78, 164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 C108.28 167.33, 83.9 167.33, 32 167.33 C10.67 167.33, 0 156.67, 0 135.33 C0 111.69, 0 88.06, 0 32 C0 10.67, 10.67 0, 32 0" stroke="none" stroke-width="0" fill="#b2f2bb"></path><path d="M32 0 C58.25 0, 84.49 0, 132.67 0 M32 0 C62.59 0, 93.17 0, 132.67 0 M132.67 0 C154 0, 164.67 10.67, 164.67 32 M132.67 0 C154 0, 164.67 10.67, 164.67 32 M164.67 32 C164.67 54.75, 164.67 77.51, 164.67 135.33 M164.67 32 C164.67 64.44, 164.67 96.88, 164.67 135.33 M164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 M164.67 135.33 C164.67 156.67, 154 167.33, 132.67 167.33 M132.67 167.33 C94.24 167.33, 55.81 167.33, 32 167.33 M132.67 167.33 C95.02 167.33, 57.38 167.33, 32 167.33 M32 167.33 C10.67 167.33, 0 156.67, 0 135.33 M32 167.33 C10.67 167.33, 0 156.67, 0 135.33 M0 135.33 C0 108.01, 0 80.69, 0 32 M0 135.33 C0 100.3, 0 65.26, 0 32 M0 32 C0 10.67, 10.67 0, 32 0 M0 32 C0 10.67, 10.67 0, 32 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g stroke-linecap="round" transform="translate(224.1485965874449 705.2353482787477) rotate(0 56.66667175292969 25)"><path d="M12.5 0 C32.54 0, 52.58 0, 100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 C113.33 21.8, 113.33 31.1, 113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 C79.25 50, 57.66 50, 12.5 50 C4.17 50, 0 45.83, 0 37.5 C0 29.87, 0 22.24, 0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="none" stroke-width="0" fill="#ffc9c9"></path><path d="M12.5 0 C31.53 0, 50.55 0, 100.83 0 M12.5 0 C40.37 0, 68.25 0, 100.83 0 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M113.33 12.5 C113.33 18.17, 113.33 23.83, 113.33 37.5 M113.33 12.5 C113.33 17.56, 113.33 22.63, 113.33 37.5 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M100.83 50 C68.25 50, 35.67 50, 12.5 50 M100.83 50 C75.24 50, 49.64 50, 12.5 50 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M0 37.5 C0 28.94, 0 20.37, 0 12.5 M0 37.5 C0 28.22, 0 18.93, 0 12.5 M0 12.5 C0 4.17, 4.17 0, 12.5 0 M0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(232.79930001762068 710.2353482787477) rotate(0 48.015968322753906 20)"><text x="48.015968322753906" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Child Job = </text><text x="48.015968322753906" y="34.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Job()</text></g><g transform="translate(226.9560885861227 670.5686612670289) rotate(0 52.74395751953122 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Child Context</text></g><g stroke-linecap="round" transform="translate(226.14858132865584 760.9020200316774) rotate(0 56.66667175292969 24.999999999999943)"><path d="M12.5 0 C32.58 0, 52.65 0, 100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 C113.33 20.02, 113.33 27.53, 113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 C72.72 50, 44.61 50, 12.5 50 C4.17 50, 0 45.83, 0 37.5 C0 27.77, 0 18.05, 0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="none" stroke-width="0" fill="#a5d8ff"></path><path d="M12.5 0 C40.59 0, 68.69 0, 100.83 0 M12.5 0 C42.81 0, 73.11 0, 100.83 0 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M100.83 0 C109.17 0, 113.33 4.17, 113.33 12.5 M113.33 12.5 C113.33 21.06, 113.33 29.62, 113.33 37.5 M113.33 12.5 C113.33 20.62, 113.33 28.74, 113.33 37.5 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M113.33 37.5 C113.33 45.83, 109.17 50, 100.83 50 M100.83 50 C81.89 50, 62.94 50, 12.5 50 M100.83 50 C66.08 50, 31.32 50, 12.5 50 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M12.5 50 C4.17 50, 0 45.83, 0 37.5 M0 37.5 C0 29.41, 0 21.33, 0 12.5 M0 37.5 C0 29.6, 0 21.71, 0 12.5 M0 12.5 C0 4.17, 4.17 0, 12.5 0 M0 12.5 C0 4.17, 4.17 0, 12.5 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(240.89528543021834 765.9020200316774) rotate(0 41.91996765136719 19.999999999999943)"><text x="41.91996765136719" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Parent </text><text x="41.91996765136719" y="34.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Dispatcher</text></g><g transform="translate(232.0790929333993 625.1827616837396) rotate(0 43.14396667480469 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="#1e1e1e" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Child Scope</text></g><g stroke-linecap="round"><g transform="translate(214.54704673310437 729.6306192862045) rotate(0 -39.60827515703005 -149.835933732811)"><path d="M0 0 C-13.2 -8.09, -77.78 1.43, -79.22 -48.51 C-80.65 -98.46, -20.37 -257.81, -8.6 -299.67" stroke="var(--md-code-fg-color)" stroke-width="2.5" fill="none" stroke-dasharray="1.5 8"></path></g><g transform="translate(214.54704673310437 729.6306192862045) rotate(0 -39.60827515703005 -149.835933732811)"><path d="M-7.78 -274.69 C-8.07 -283.5, -8.36 -292.32, -8.6 -299.67" stroke="var(--md-code-fg-color)" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g><g transform="translate(214.54704673310437 729.6306192862045) rotate(0 -39.60827515703005 -149.835933732811)"><path d="M-24.03 -280.01 C-18.58 -286.95, -13.14 -293.89, -8.6 -299.67" stroke="var(--md-code-fg-color)" stroke-width="2.5" fill="none" stroke-dasharray="1.5 6"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(270.1214197092961 523.9132764240608) rotate(0 0.9211225146377444 39.915290227350056)"><path d="M0 0 C0.31 13.31, 1.54 66.53, 1.84 79.83 M0 0 C0.31 13.31, 1.54 66.53, 1.84 79.83" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(270.1214197092961 523.9132764240608) rotate(0 0.9211225146377444 39.915290227350056)"><path d="M-7.25 56.54 C-4.27 64.17, -1.29 71.8, 1.84 79.83 M-7.25 56.54 C-4.29 64.12, -1.33 71.7, 1.84 79.83" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(270.1214197092961 523.9132764240608) rotate(0 0.9211225146377444 39.915290227350056)"><path d="M9.85 56.15 C7.23 63.9, 4.6 71.66, 1.84 79.83 M9.85 56.15 C7.24 63.86, 4.64 71.56, 1.84 79.83" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g transform="translate(284.8594080539283 308.06358590090156) rotate(0 142.96791076660156 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Passed context overwrites elements</text></g><g transform="translate(398.4644713418695 712.1292915080874) rotate(0 155.44790649414062 10)"><text x="0" y="14.016" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-code-fg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">child context = parent context + Job()</text></g></svg>

We can see it all in work like this:

```kotlin linenums="1"
fun main() = runBlocking {
  launch(Dispatchers.Default) {
    val scopeContext = currentCoroutineContext()      // [StandaloneCoroutine{Active}@7d6b54ea, Dispatchers.Default]
    val scopeJob = scopeContext.job                   //  StandaloneCoroutine{Active}@7d6b54ea

    val parentContext = scopeContext + Dispatchers.IO // [StandaloneCoroutine{Active}@7d6b54ea, Dispatchers.IO]

    launch(Dispatchers.IO) {
      val childContext = currentCoroutineContext()    // [StandaloneCoroutine{Active}@4bcf3652, Dispatchers.IO]
      val childJob = childContext.job                 //  StandaloneCoroutine{Active}@4bcf3652

      println("${childContext == parentContext + childJob}") // true
      println("${childJob.parent == scopeJob}")              // true 
    }
  }
}
```

Had we passing in `Dispatcher.IO + Job()` to `launch`, the `childJob` would have been child of this new `Job` instead.

### `coroutineScope`

[Source](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/coroutine-scope.html)

In addition to coroutine scope provided by different builders, it is possible to create your own scope using `coroutineScope`. It creates a new scope and does not complete until all launched children complete.

It looks similar to `runBlocking`, but `runBlocking` **blocks** current thread while `coroutineScope` just suspends. That's why `corountineScope` is a suspend function whereas `runBlocking` is a regular function.

`coroutineScope` will fail if any of the child coroutine fail, resulting in cancellation of all other children. If you want other children to still complete regardless, use `supervisorScope`.

<div class="grid" markdown>   

```kotlin linenums="1"
fun main() = runBlocking {
  coroutineScope {
    launch {
      delay(5000L)
      println("a")
    }
    launch {
      delay(1L)
      throw Exception()
    }
  }
  println()
}
```

```kotlin linenums="1"
fun main() = runBlocking {
  supervisorScope {
    launch {
      delay(5000L)
      println("a")
    }
    launch {
      delay(1L)
      throw Exception()
    }
  }
  println()
}
```

finishes in right away
 
finishes after 5 second 

<hr>

<hr>

</div>

### Cancelling coroutines

[Kotlin in Action 2](https://www.manning.com/books/kotlin-in-action-second-edition)

We can call `cancel` on both `Job` and `Deferred<T>` to cancel the coroutine ahead of its time. This is useful in avoiding unnecessary work and leaks. 

Cancellation of parent cadcades through all children coroutines. Note that this is different thing from `coroutineScope/supervisorScope` which is about sibling cancellation.

```kotlin linenums="1"
fun main() = runBlocking {
  val job = launch {
    launch {
      launch {
        launch {
          delay(1000L)
          println("descendant 1 done") // prints
        }
        launch {
          delay(10_000L)
          println("descendant 2 done") // does not print
        }
      }
    }
  }
  delay(1500L)
  job.cancel()
}
```

this exits right after 1.5s.

We can also use `withTimeout` and `withTimeoutOrNull` to automatically cancel a coroutine.


<div class="grid" markdown>   

```kotlin linenums="1"
fun main() = runBlocking {
  withTimeout(50_000L) {
    delay(10_000L)
    println("hello")
  }
}
```

```kotlin linenums="1"
fun main() = runBlocking {
  withTimeout(500L) {
    delay(10_000L)
    println("hello")
  }
}
```

prints `hello` after 10s

aborts after .5s

<hr>

<hr>

</div>

{==

Cancellation is implemented by throwing a special exception type `CancellationException`. So never do a catch-all for `CancellationException` or its super-type `IllegalStateException`, `RuntimeException`, `Exception` and `Throwable`. Otherwise you will prevent the cancellation.

==}

### Suspension Point

[source 1](https://kotlinlang.org/spec/asynchronous-programming-with-coroutines.html) and [2](https://kotlinlang.org/docs/cancellation-and-timeouts.html#asynchronous-timeout-and-resources).

A suspending function is different from non-suspending functions by having zero or more *suspension points* - statements in the body where the function execution can be paused and resumed later. Usually that's the points at which the function calls other suspending functions. 

That's why non-suspending functions cannot call suspending ones, as they do not support suspension points. Also, suspending functions may call non-suspending functions knowing that it will not introduce a suspension point. [See function coloring](https://journal.stuffwithstuff.com/2015/02/01/what-color-is-your-function/).

```kotlin linenums="1"
coroutineScope {
  print("A")
  delay(500L) <- suspension point
  print("B")
  print("C")
}
```

this code will either print `A` or `ABC`, but never `AB` as there are no suspension point between `B` and `C`. 

Why are we talking about this? Consider the following example:

```kotlin linenums="1"
fun heavyCpuWork(): Int {
  while(...) {
    compute()
  }
}

fun main() = runBlocking {
  launch { heavyCpuWork() }
  launch { heavyCpuWork() }
}
```

Just using coroutines will not magically make our code concurrent. In the example above, `heavyCpuWork` has no suspension point. As a result, even when running on a coroutine, it will never suspend to let other coroutine have a go. The first corountine will finish to completion before second one gets a chance.

<div class="grid" markdown>   

```kotlin linenums="1" hl_lines="4"
fun heavyCpuWork(): Int {
  while(...) {
    compute()
    yield()
  }
}
```

```kotlin linenums="1" hl_lines="3 5"
fun heavyCpuWork(): Int {
  while(...) {
    if (isActive) {
      compute()
    }
  }
}
```

Use `yield` function lets coroutine voluntarily give way for other corountines.

The other approach is to explicitly check cancellation status.

</div>

## Channels

[Source](https://kotlinlang.org/docs/channels.html)

Basically `BlockingQueue` but instead of a blocking `put`, it has a suspending `send` and instead of a blocking `take`, it has a suspending `receive`.

<div class="grid" markdown>   

```kotlin linenums="1"
suspend fun produce(channel: Channel<Int>) {
  repeat(20) {
    delay(1000L)
    channel.send(it)
  }
  channel.close()
}

suspend fun consume(channel: Channel<Int>) {
  for (i in channel) { // until channel is closed
    println("${coroutineContext[CoroutineName]?.name} received $i")
  }
}

fun main() = runBlocking {
  val channel = Channel<Int>()
  launch(CoroutineName("A")) { consume(channel) }
  launch(CoroutineName("B")) { consume(channel) }
  launch(CoroutineName("C")) { consume(channel) }
  launch(CoroutineName("D")) { consume(channel) }
  launch(CoroutineName("P")) { produce(channel) }
  println()
}
```

```text linenums="1"
A received 0
B received 1
C received 2
D received 3
A received 4
B received 5
C received 6
D received 7
A received 8
B received 9
C received 10
D received 11
A received 12
B received 13
C received 14
D received 15
A received 16
B received 17
C received 18
D received 19
```

</div>

The example above had no buffer. Unbuffered channels transfer elements when sender and receiver meet each other (i.e. rendezvous). If sender is invoked first, then it gets suspended until receiver is invoked, and vice-versa.

We can optionally specify as capacity `Channel<T>(42)` which allows sender to send multiple items before getting suspended.

## Flow

[Flow](https://kotlinlang.org/docs/flow.html)

`Flow` is basically `Sequence` that also support suspending functions. And a sequence is like `Stream`, but more kotliny.

<div class="grid" markdown>   

```kotlin linenums="1"
fun produce() = sequence {
  for (i in 1..5) {
    Thread.sleep(1000L)
    yield(i)
  }
}

fun main() {
  produce().forEach { println(it) }
}
```

```kotlin linenums="1"
fun produce() = flow {
  for (i in 1..5) {
    delay(1000L)
    emit(i)
  }
}

fun main() = runBlocking {
  produce().collect { println(it) }
}
```

Prints `1`, `2`, `3`, `4`, `5`, each after 1s delay.

Does the same thing, but doesn't block the thread, just suspends it.

</div>

Notice that the function is no longer marked `suspend`, why's that? See `suspend` makes sense when function is returning just one thing and that thing may take time to "cook". `Flow`, on the other hand, is a lightweight object that's available right away. The function will always return it immediately. So a `suspend foo(): Flow` is moot in the same manner `suspend foo(): ListenableFuture<T>` is moot.

Once you got your hands on a flow, then sure it may take time to collect items from it. Which is why `collect` is still suspending function. 

Flows are **cold streams** similar to sequences, i.e. the builder does not run until the flow is `collect`ed. And you can do the same things to Flows as you can do with Sequences/Streams.

By default, code in `flow {...}` runs in the context that is provided by its collector. But it can be changed like this:

```kotlin linenums="1"
flow {
  ...
}.flowOn(Dispatchers.Default)
```

<hr>

<div class="grid" markdown>   

```kotlin linenums="1"
fun produce() = flow {
  for (i in 1..5) {
    delay(1000L)
    emit(i)
  }
}

fun main() = runBlocking {
  produce()
  .collect {
    delay(3000L)
    println(it)
  }
}
```

```kotlin linenums="1" hl_lines="10"
fun produce() = flow {
  for (i in 1..5) {
    delay(1000L)
    emit(i)
  }
}

fun main() = runBlocking {
  produce()
  .buffer()
  .collect {
    delay(3000L)
    println(it)
  }
}
```

Takes 4s to print each number (1s + 3s) due to running emit and collect sequentially.

`buffer` runs emitting code of `produce` concurrently with collecting code. So we wait 1s for first number and then only 3s each number.

</div>

Similar to `buffer`, use `conflate` to skip intermediate steps when the collector is too slow and you want to drop in-between emitted values. For `xxx` operator like `collect`, there is a family of `xxxLatest` operators (e.g. `collectLatest`) that cancel their code on a new value.

We can use `catch` before `collect` to grab exceptions thrown by the emitter. Again, note that the `collect` is not same as `collect` of `Stream`s. Without `collect`, a flow is cold, never emitting a value.

## Hot Flows

Hot flows are useful when sharing emitted items across multiple collectors, this time called *subscribers*. Which is why it doesn't make sense for relying on a collector to start collecting. 

It's like broadcasting. A TV station or a twitch stream will broadcast, regardless of whether there are any viewers or not.

Kotlin has two implementations of hot flows out of the box: *Shared flows* and *State flows*.

<div class="grid" markdown>

```kotlin title="producer" linenums="1"
val flow = MutableSharedFlow<Int>()

fun broadcast(scope: CoroutineScope) = scope.launch {
  repeat(1000) {
    delay(1000L)
    flow.emit("ping")
  }
} 
```

```kotlin title="subscriber" linenums="1"
val readOnly = flow.asSharedFlow()

readOnly.collect{ println(it) }
```

</div>

Subscribers only receive emissions that happened after they called `collect`. A hot flow can let you see some past broadcast with `replay` param: `MutableSharedFlow<Int>(replay = 10)`.

A special case of hot flow is when you need to track state of a system right now and don't care for past values.

```kotlin linenums="1"
private val viewWriter = MutableStateFlow(0) // inital views = 0
private vale viewReader = viewWriter.asStateFlow() 

fun increment() {
  viewWriter.update { it + 1 }
}

fun main() {
  increment()
  println(reader.value)
}
```

`StateFlow` only emit last known value, so no `relay`. They also come with a start value in the constructor that's emitted immediately. In general, it's a simpler API.