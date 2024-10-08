# Basics

<style>
.md-logo img {
  content: url('/data-structures/stack/stack.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/data-structures/stack/stack.svg');
}
</style>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
</script>

Stack is an abstract data type that serves the elements of a collection in last in, first out fashion.

## Interface

```kotlin
interface Stack {
  val empty: Boolean

  val size: Int

  fun push(item: Int)

  fun pop(): Int?
}
```

## Implementation

=== "As an array"

    - `top` points to the index where the next element goes.
    - once the stack is full, `top` will spill beyond the underlying array to `array.size`.
    - at this point, we double the size of the underlying array.

    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 283.20703125 164.14973200123853" width="200">
      <g 21 troke-linecap="round" transform="translate(10 44.06008900700357) rotate(0 131.603515625 27.640625)"><path d="M13.82 0 C72.52 0, 131.22 0, 249.39 0 M13.82 0 C66.5 0, 119.17 0, 249.39 0 M249.39 0 C258.6 0, 263.21 4.61, 263.21 13.82 M249.39 0 C258.6 0, 263.21 4.61, 263.21 13.82 M263.21 13.82 C263.21 19.73, 263.21 25.63, 263.21 41.46 M263.21 13.82 C263.21 21.81, 263.21 29.8, 263.21 41.46 M263.21 41.46 C263.21 50.67, 258.6 55.28, 249.39 55.28 M263.21 41.46 C263.21 50.67, 258.6 55.28, 249.39 55.28 M249.39 55.28 C172.26 55.28, 95.13 55.28, 13.82 55.28 M249.39 55.28 C171.67 55.28, 93.96 55.28, 13.82 55.28 M13.82 55.28 C4.61 55.28, 0 50.67, 0 41.46 M13.82 55.28 C4.61 55.28, 0 50.67, 0 41.46 M0 41.46 C0 33.35, 0 25.24, 0 13.82 M0 41.46 C0 34.65, 0 27.85, 0 13.82 M0 13.82 C0 4.61, 4.61 0, 13.82 0 M0 13.82 C0 4.61, 4.61 0, 13.82 0" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g><g stroke-linecap="round"><g transform="translate(39.94140625 44.829366087077744) rotate(0 0.2421875 26.84765625)"><path d="M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7 M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(69.08220744883101 45.37270873620281) rotate(0 0.2421875 26.84765625)"><path d="M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7 M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(100.43438183520192 44.63005952057614) rotate(0 0.2421875 26.84765625)"><path d="M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7 M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(129.5727542740383 44.26757597485374) rotate(0 0.2421875 26.84765625)"><path d="M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7 M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(158.5625968697492 44.82279467415549) rotate(0 0.2421875 26.84765625)"><path d="M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7 M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(187.7734660177298 45.416914046656814) rotate(0 0.2421875 26.84765625)"><path d="M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7 M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(215.63518909065556 45.28606632771306) rotate(0 0.2421875 26.84765625)"><path d="M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7 M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(242.76133579762734 45.80415256623354) rotate(0 0.2421875 26.84765625)"><path d="M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7 M0 0 C0.08 8.95, 0.4 44.75, 0.48 53.7" stroke="var(--md-primary-bg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(12.547094201756579 49.705716265788794) rotate(0 12.038874249033086 21.71276438877905)"><path d="M1.6 1.39 C1.6 1.39, 1.6 1.39, 1.6 1.39 M1.6 1.39 C1.6 1.39, 1.6 1.39, 1.6 1.39 M0.42 14.94 C5.11 9.56, 9.79 4.17, 12.89 0.6 M0.42 14.94 C4.91 9.78, 9.4 4.62, 12.89 0.6 M0.56 26.98 C8.6 17.74, 16.64 8.49, 22.86 1.32 M0.56 26.98 C5.5 21.29, 10.45 15.61, 22.86 1.32 M0.69 39.02 C9.63 28.75, 18.56 18.47, 23.65 12.61 M0.69 39.02 C7.31 31.41, 13.93 23.79, 23.65 12.61 M7.38 43.52 C13.22 36.8, 19.07 30.08, 23.78 24.65 M7.38 43.52 C10.77 39.63, 14.15 35.73, 23.78 24.65 M18.01 43.48 C19.34 41.96, 20.66 40.43, 23.92 36.69 M18.01 43.48 C19.51 41.76, 21 40.05, 23.92 36.69" stroke="#a5d8ff" stroke-width="1" fill="none"></path><path d="M6.02 0 C9.76 0, 13.49 0, 18.06 0 M6.02 0 C9.65 0, 13.27 0, 18.06 0 M18.06 0 C22.07 0, 24.08 2.01, 24.08 6.02 M18.06 0 C22.07 0, 24.08 2.01, 24.08 6.02 M24.08 6.02 C24.08 17.85, 24.08 29.69, 24.08 37.41 M24.08 6.02 C24.08 15.84, 24.08 25.65, 24.08 37.41 M24.08 37.41 C24.08 41.42, 22.07 43.43, 18.06 43.43 M24.08 37.41 C24.08 41.42, 22.07 43.43, 18.06 43.43 M18.06 43.43 C15.52 43.43, 12.99 43.43, 6.02 43.43 M18.06 43.43 C14.44 43.43, 10.82 43.43, 6.02 43.43 M6.02 43.43 C2.01 43.43, 0 41.42, 0 37.41 M6.02 43.43 C2.01 43.43, 0 41.42, 0 37.41 M0 37.41 C0 27.15, 0 16.9, 0 6.02 M0 37.41 C0 26.33, 0 15.25, 0 6.02 M0 6.02 C0 2.01, 2.01 0, 6.02 0 M0 6.02 C0 2.01, 2.01 0, 6.02 0" stroke="transparent" stroke-width="2" fill="none"></path></g><g stroke-linecap="round" transform="translate(42.3405893415208 49.42368638509265) rotate(0 12.038874249033086 21.71276438877905)"><path d="M1.6 1.39 C1.6 1.39, 1.6 1.39, 1.6 1.39 M1.6 1.39 C1.6 1.39, 1.6 1.39, 1.6 1.39 M0.42 14.94 C3.93 10.91, 7.44 6.88, 12.89 0.6 M0.42 14.94 C4.03 10.79, 7.64 6.64, 12.89 0.6 M0.56 26.98 C5.46 21.35, 10.36 15.71, 22.86 1.32 M0.56 26.98 C7.75 18.71, 14.95 10.43, 22.86 1.32 M0.69 39.02 C8.82 29.67, 16.95 20.31, 23.65 12.61 M0.69 39.02 C8.65 29.87, 16.6 20.72, 23.65 12.61 M7.38 43.52 C13.02 37.04, 18.65 30.56, 23.78 24.65 M7.38 43.52 C12.5 37.63, 17.62 31.74, 23.78 24.65 M18.01 43.48 C19.65 41.6, 21.29 39.71, 23.92 36.69 M18.01 43.48 C19.42 41.86, 20.83 40.24, 23.92 36.69" stroke="#a5d8ff" stroke-width="1" fill="none"></path><path d="M6.02 0 C9.62 0, 13.23 0, 18.06 0 M6.02 0 C9.18 0, 12.35 0, 18.06 0 M18.06 0 C22.07 0, 24.08 2.01, 24.08 6.02 M18.06 0 C22.07 0, 24.08 2.01, 24.08 6.02 M24.08 6.02 C24.08 14.87, 24.08 23.73, 24.08 37.41 M24.08 6.02 C24.08 16.75, 24.08 27.49, 24.08 37.41 M24.08 37.41 C24.08 41.42, 22.07 43.43, 18.06 43.43 M24.08 37.41 C24.08 41.42, 22.07 43.43, 18.06 43.43 M18.06 43.43 C15.37 43.43, 12.69 43.43, 6.02 43.43 M18.06 43.43 C13.33 43.43, 8.6 43.43, 6.02 43.43 M6.02 43.43 C2.01 43.43, 0 41.42, 0 37.41 M6.02 43.43 C2.01 43.43, 0 41.42, 0 37.41 M0 37.41 C0 28.86, 0 20.32, 0 6.02 M0 37.41 C0 30.74, 0 24.08, 0 6.02 M0 6.02 C0 2.01, 2.01 0, 6.02 0 M0 6.02 C0 2.01, 2.01 0, 6.02 0" stroke="transparent" stroke-width="2" fill="none"></path></g><g stroke-linecap="round" transform="translate(73.24717419851567 49.90287195041361) rotate(0 12.038874249033086 21.71276438877905)"><path d="M1.6 1.39 C1.6 1.39, 1.6 1.39, 1.6 1.39 M1.6 1.39 C1.6 1.39, 1.6 1.39, 1.6 1.39 M0.42 14.94 C3.88 10.97, 7.33 7, 12.89 0.6 M0.42 14.94 C5.36 9.26, 10.31 3.58, 12.89 0.6 M0.56 26.98 C6.25 20.43, 11.95 13.88, 22.86 1.32 M0.56 26.98 C9.27 16.96, 17.99 6.93, 22.86 1.32 M0.69 39.02 C9.46 28.94, 18.22 18.86, 23.65 12.61 M0.69 39.02 C6.19 32.69, 11.7 26.36, 23.65 12.61 M7.38 43.52 C11.22 39.1, 15.06 34.69, 23.78 24.65 M7.38 43.52 C11.89 38.33, 16.4 33.15, 23.78 24.65 M18.01 43.48 C19.32 41.99, 20.62 40.49, 23.92 36.69 M18.01 43.48 C19.77 41.47, 21.52 39.45, 23.92 36.69" stroke="#a5d8ff" stroke-width="1" fill="none"></path><path d="M6.02 0 C10.28 0, 14.55 0, 18.06 0 M6.02 0 C10.19 0, 14.36 0, 18.06 0 M18.06 0 C22.07 0, 24.08 2.01, 24.08 6.02 M18.06 0 C22.07 0, 24.08 2.01, 24.08 6.02 M24.08 6.02 C24.08 18.01, 24.08 30.01, 24.08 37.41 M24.08 6.02 C24.08 16.66, 24.08 27.31, 24.08 37.41 M24.08 37.41 C24.08 41.42, 22.07 43.43, 18.06 43.43 M24.08 37.41 C24.08 41.42, 22.07 43.43, 18.06 43.43 M18.06 43.43 C14.07 43.43, 10.08 43.43, 6.02 43.43 M18.06 43.43 C13.47 43.43, 8.88 43.43, 6.02 43.43 M6.02 43.43 C2.01 43.43, 0 41.42, 0 37.41 M6.02 43.43 C2.01 43.43, 0 41.42, 0 37.41 M0 37.41 C0 26.55, 0 15.7, 0 6.02 M0 37.41 C0 25.63, 0 13.85, 0 6.02 M0 6.02 C0 2.01, 2.01 0, 6.02 0 M0 6.02 C0 2.01, 2.01 0, 6.02 0" stroke="transparent" stroke-width="2" fill="none"></path></g><g stroke-linecap="round" transform="translate(103.42879196406557 49.87988518897754) rotate(0 12.038874249033086 21.71276438877905)"><path d="M1.6 1.39 C1.6 1.39, 1.6 1.39, 1.6 1.39 M1.6 1.39 C1.6 1.39, 1.6 1.39, 1.6 1.39 M0.42 14.94 C3.12 11.84, 5.81 8.74, 12.89 0.6 M0.42 14.94 C5.27 9.36, 10.12 3.78, 12.89 0.6 M0.56 26.98 C6.04 20.68, 11.52 14.37, 22.86 1.32 M0.56 26.98 C6.09 20.61, 11.63 14.24, 22.86 1.32 M0.69 39.02 C9 29.46, 17.31 19.9, 23.65 12.61 M0.69 39.02 C8.9 29.58, 17.12 20.13, 23.65 12.61 M7.38 43.52 C12.69 37.41, 18 31.31, 23.78 24.65 M7.38 43.52 C13.42 36.57, 19.46 29.63, 23.78 24.65 M18.01 43.48 C19.91 41.31, 21.8 39.13, 23.92 36.69 M18.01 43.48 C20.37 40.78, 22.72 38.07, 23.92 36.69" stroke="#a5d8ff" stroke-width="1" fill="none"></path><path d="M6.02 0 C9.43 0, 12.84 0, 18.06 0 M6.02 0 C9.06 0, 12.1 0, 18.06 0 M18.06 0 C22.07 0, 24.08 2.01, 24.08 6.02 M18.06 0 C22.07 0, 24.08 2.01, 24.08 6.02 M24.08 6.02 C24.08 14.03, 24.08 22.05, 24.08 37.41 M24.08 6.02 C24.08 18.29, 24.08 30.55, 24.08 37.41 M24.08 37.41 C24.08 41.42, 22.07 43.43, 18.06 43.43 M24.08 37.41 C24.08 41.42, 22.07 43.43, 18.06 43.43 M18.06 43.43 C14.43 43.43, 10.81 43.43, 6.02 43.43 M18.06 43.43 C14.02 43.43, 9.98 43.43, 6.02 43.43 M6.02 43.43 C2.01 43.43, 0 41.42, 0 37.41 M6.02 43.43 C2.01 43.43, 0 41.42, 0 37.41 M0 37.41 C0 28.91, 0 20.42, 0 6.02 M0 37.41 C0 25.39, 0 13.37, 0 6.02 M0 6.02 C0 2.01, 2.01 0, 6.02 0 M0 6.02 C0 2.01, 2.01 0, 6.02 0" stroke="transparent" stroke-width="2" fill="none"></path></g><g transform="translate(19.11953976005242 12.102910981227183) rotate(0 6.740000307559967 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g transform="translate(47.823357374482384 10.716126029354257) rotate(0 4.269996643066406 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g transform="translate(78.03326653872284 10.633020045700846) rotate(0 7 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g transform="translate(109.3376991898034 10.34656963395912) rotate(0 6.079994201660156 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g transform="translate(137.79177342281207 10) rotate(0 5.849998474121094 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g transform="translate(167.2077552112995 10.309437173177741) rotate(0 6.180000156164169 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">5</text></g><g transform="translate(195.51860423843732 11.75760314364976) rotate(0 6.399993896484375 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">6</text></g><g transform="translate(223.40154586038102 11.352682499891444) rotate(0 5.579994201660156 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">7</text></g><g transform="translate(249.09367229622615 10.834596261370848) rotate(0 6.359992980957031 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">8</text></g><g transform="translate(131.06860437851242 129.14973200123853) rotate(0 16.899993896484375 12.5)"><text x="0" y="17.619999999999997" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">top</text></g><g stroke-linecap="round"><g transform="translate(146.10901920736978 123.00342563571911) rotate(0 -0.1529503741707572 -20.33974744607886)"><path d="M0 0 C-0.05 -6.78, -0.25 -33.9, -0.31 -40.68" stroke="var(--md-primary-bg-color)" stroke-width="2.5" fill="none" stroke-dasharray="8 10"></path></g></g><mask></mask></svg>

    ```kotlin linenums="1"
    class ArrayStack(capacity: Int = 2) : Stack {
      private var top: Int = 0
      private var items: IntArray = IntArray(size = capacity)

      override val empty: Boolean
        get() = size == 0

      override val size: Int
        get() = top

      override fun push(item: Int) {
        maybeResize()
        items[top++] = item
      }

      override fun pop(): Int? = if (top == 0) {
        null
      } else {
        items[--top]
      }

      private fun maybeResize() {
        if (top == items.size) {
          items = items.copyOf(newSize = items.size * 2)
        }
      }
    }
    ```

=== "As a linked list"

    - A singly-linked list will do.
    - The `head` of the linked list is where new elements are added.
    - Popping off elements just involves shifting `head` to the `next`.

    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 443.3556644099215 125.97244604383818" width="400">
      <g stroke-linecap="round" transform="translate(165.33874947010133 10.946479705916602) rotate(0 18.83056279404184 17.077221314813883)"><path d="M8.54 0 C14.47 0, 20.4 0, 29.12 0 M8.54 0 C13.63 0, 18.71 0, 29.12 0 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M37.66 8.54 C37.66 13.42, 37.66 18.3, 37.66 25.62 M37.66 8.54 C37.66 14.95, 37.66 21.37, 37.66 25.62 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M29.12 34.15 C20.95 34.15, 12.77 34.15, 8.54 34.15 M29.12 34.15 C24.33 34.15, 19.53 34.15, 8.54 34.15 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M0 25.62 C0 21.39, 0 17.16, 0 8.54 M0 25.62 C0 19.8, 0 13.98, 0 8.54 M0 8.54 C0 2.85, 2.85 0, 8.54 0 M0 8.54 C0 2.85, 2.85 0, 8.54 0" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(179.6813123480665 18.0237010207305) rotate(0 4.48799991607666 10)"><text x="4.48799991607666" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g stroke-linecap="round" transform="translate(239.7989410856482 10) rotate(0 18.83056279404181 17.077221314813883)"><path d="M8.54 0 C14.09 0, 19.64 0, 29.12 0 M8.54 0 C15.36 0, 22.19 0, 29.12 0 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M37.66 8.54 C37.66 13.02, 37.66 17.51, 37.66 25.62 M37.66 8.54 C37.66 14.29, 37.66 20.05, 37.66 25.62 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M29.12 34.15 C21.46 34.15, 13.8 34.15, 8.54 34.15 M29.12 34.15 C24.55 34.15, 19.98 34.15, 8.54 34.15 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M0 25.62 C0 19.08, 0 12.54, 0 8.54 M0 25.62 C0 20.39, 0 15.17, 0 8.54 M0 8.54 C0 2.85, 2.85 0, 8.54 0 M0 8.54 C0 2.85, 2.85 0, 8.54 0" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(254.17350367083537 17.077221314813897) rotate(0 4.456000208854675 10)"><text x="4.456000208854675" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g stroke-linecap="round" transform="translate(315.4751074863267 10.41235994048506) rotate(0 18.83056279404184 17.077221314813883)"><path d="M8.54 0 C16.71 0, 24.89 0, 29.12 0 M8.54 0 C13.95 0, 19.35 0, 29.12 0 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M37.66 8.54 C37.66 14.96, 37.66 21.38, 37.66 25.62 M37.66 8.54 C37.66 14.67, 37.66 20.8, 37.66 25.62 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M29.12 34.15 C23.39 34.15, 17.66 34.15, 8.54 34.15 M29.12 34.15 C22.57 34.15, 16.02 34.15, 8.54 34.15 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M0 25.62 C0 20.63, 0 15.65, 0 8.54 M0 25.62 C0 20.5, 0 15.39, 0 8.54 M0 8.54 C0 2.85, 2.85 0, 8.54 0 M0 8.54 C0 2.85, 2.85 0, 8.54 0" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(329.7216704081609 17.48958125529896) rotate(0 4.583999872207642 10)"><text x="4.583999872207642" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round" transform="translate(393.87544703713866 10.168840290592385) rotate(0 18.83056279404184 17.077221314813883)"><path d="M8.54 0 C12.8 0, 17.06 0, 29.12 0 M8.54 0 C14.66 0, 20.79 0, 29.12 0 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M37.66 8.54 C37.66 12.15, 37.66 15.76, 37.66 25.62 M37.66 8.54 C37.66 12.18, 37.66 15.82, 37.66 25.62 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M29.12 34.15 C21.05 34.15, 12.99 34.15, 8.54 34.15 M29.12 34.15 C20.99 34.15, 12.86 34.15, 8.54 34.15 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M0 25.62 C0 19.23, 0 12.85, 0 8.54 M0 25.62 C0 19.38, 0 13.15, 0 8.54 M0 8.54 C0 2.85, 2.85 0, 8.54 0 M0 8.54 C0 2.85, 2.85 0, 8.54 0" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(408.27400970076553 17.246061605406254) rotate(0 4.432000130414963 10)"><text x="4.432000130414963" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round"><g transform="translate(209.41580610069332 27.037947475568785) rotate(0 12.555873148471392 -0.08751172633027693)"><path d="M0 0 C4.19 -0.03, 20.93 -0.15, 25.11 -0.18 M0 0 C4.19 -0.03, 20.93 -0.15, 25.11 -0.18" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(209.41580610069332 27.037947475568785) rotate(0 12.555873148471392 -0.08751172633027693)"><path d="M13.34 4.2 C15.8 3.29, 18.25 2.38, 25.11 -0.18 M13.34 4.2 C17.48 2.66, 21.62 1.12, 25.11 -0.18" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(209.41580610069332 27.037947475568785) rotate(0 12.555873148471392 -0.08751172633027693)"><path d="M13.28 -4.39 C15.75 -3.51, 18.21 -2.63, 25.11 -0.18 M13.28 -4.39 C17.44 -2.91, 21.6 -1.42, 25.11 -0.18" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(283.49773052674027 27.638939973899852) rotate(0 12.932516873638917 -0.05334250166335153)"><path d="M0 0 C4.31 -0.02, 21.55 -0.09, 25.87 -0.11 M0 0 C4.31 -0.02, 21.55 -0.09, 25.87 -0.11" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(283.49773052674027 27.638939973899852) rotate(0 12.932516873638917 -0.05334250166335153)"><path d="M13.73 4.37 C17.26 3.07, 20.79 1.76, 25.87 -0.11 M13.73 4.37 C17.18 3.09, 20.64 1.82, 25.87 -0.11" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(283.49773052674027 27.638939973899852) rotate(0 12.932516873638917 -0.05334250166335153)"><path d="M13.69 -4.48 C17.23 -3.21, 20.77 -1.94, 25.87 -0.11 M13.69 -4.48 C17.16 -3.24, 20.62 -1.99, 25.87 -0.11" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(359.2226008573971 26.434329439096956) rotate(0 13.911465866207834 -0.1759226108176506)"><path d="M0 0 C4.64 -0.06, 23.19 -0.29, 27.82 -0.35 M0 0 C4.64 -0.06, 23.19 -0.29, 27.82 -0.35" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(359.2226008573971 26.434329439096956) rotate(0 13.911465866207834 -0.1759226108176506)"><path d="M14.81 4.57 C18.63 3.13, 22.44 1.68, 27.82 -0.35 M14.81 4.57 C19.78 2.69, 24.74 0.81, 27.82 -0.35" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(359.2226008573971 26.434329439096956) rotate(0 13.911465866207834 -0.1759226108176506)"><path d="M14.69 -4.94 C18.54 -3.6, 22.39 -2.25, 27.82 -0.35 M14.69 -4.94 C19.7 -3.19, 24.71 -1.44, 27.82 -0.35" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(87.00010156392864 18.196871415390802) rotate(0 17.863981008529663 10)"><text x="0" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">head</text></g><g stroke-linecap="round"><g transform="translate(130.0868449516234 27.028517384835368) rotate(0 13.906595473209961 0.2029330415773103)"><path d="M0 0 C4.64 0.07, 23.18 0.34, 27.81 0.41 M0 0 C4.64 0.07, 23.18 0.34, 27.81 0.41" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(130.0868449516234 27.028517384835368) rotate(0 13.906595473209961 0.2029330415773103)"><path d="M14.68 4.97 C18.11 3.78, 21.55 2.58, 27.81 0.41 M14.68 4.97 C18.69 3.58, 22.7 2.18, 27.81 0.41" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(130.0868449516234 27.028517384835368) rotate(0 13.906595473209961 0.2029330415773103)"><path d="M14.81 -4.54 C18.21 -3.25, 21.61 -1.95, 27.81 0.41 M14.81 -4.54 C18.78 -3.03, 22.75 -1.52, 27.81 0.41" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(167.1578412548003 81.81800341421044) rotate(0 18.83056279404184 17.07722131481387)"><path d="M8.54 0 C14.72 0, 20.9 0, 29.12 0 M8.54 0 C14.47 0, 20.41 0, 29.12 0 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M37.66 8.54 C37.66 14.88, 37.66 21.21, 37.66 25.62 M37.66 8.54 C37.66 14.6, 37.66 20.65, 37.66 25.62 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M29.12 34.15 C23.01 34.15, 16.89 34.15, 8.54 34.15 M29.12 34.15 C23.1 34.15, 17.08 34.15, 8.54 34.15 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M0 25.62 C0 21.18, 0 16.74, 0 8.54 M0 25.62 C0 19.34, 0 13.07, 0 8.54 M0 8.54 C0 2.85, 2.85 0, 8.54 0 M0 8.54 C0 2.85, 2.85 0, 8.54 0" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(181.50040413276548 88.8952247290243) rotate(0 4.48799991607666 10)"><text x="4.48799991607666" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">1</text></g><g stroke-linecap="round" transform="translate(241.61803287034724 80.87152370829389) rotate(0 18.830562794041867 17.07722131481387)"><path d="M8.54 0 C14.5 0, 20.46 0, 29.12 0 M8.54 0 C12.76 0, 16.97 0, 29.12 0 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M37.66 8.54 C37.66 13.85, 37.66 19.16, 37.66 25.62 M37.66 8.54 C37.66 14.15, 37.66 19.77, 37.66 25.62 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M29.12 34.15 C24.85 34.15, 20.58 34.15, 8.54 34.15 M29.12 34.15 C23.25 34.15, 17.37 34.15, 8.54 34.15 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M0 25.62 C0 19.67, 0 13.73, 0 8.54 M0 25.62 C0 19.59, 0 13.56, 0 8.54 M0 8.54 C0 2.85, 2.85 0, 8.54 0 M0 8.54 C0 2.85, 2.85 0, 8.54 0" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(255.9925954555344 87.94874502310776) rotate(0 4.456000208854675 10)"><text x="4.456000208854675" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">2</text></g><g stroke-linecap="round" transform="translate(317.2941992710257 81.28388364877887) rotate(0 18.83056279404184 17.07722131481387)"><path d="M8.54 0 C13.21 0, 17.87 0, 29.12 0 M8.54 0 C12.72 0, 16.89 0, 29.12 0 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M37.66 8.54 C37.66 13.76, 37.66 18.98, 37.66 25.62 M37.66 8.54 C37.66 14.77, 37.66 21, 37.66 25.62 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M29.12 34.15 C24.91 34.15, 20.7 34.15, 8.54 34.15 M29.12 34.15 C20.98 34.15, 12.83 34.15, 8.54 34.15 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M0 25.62 C0 20.83, 0 16.05, 0 8.54 M0 25.62 C0 19.01, 0 12.41, 0 8.54 M0 8.54 C0 2.85, 2.85 0, 8.54 0 M0 8.54 C0 2.85, 2.85 0, 8.54 0" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(331.5407621928598 88.36110496359274) rotate(0 4.583999872207642 10)"><text x="4.583999872207642" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">3</text></g><g stroke-linecap="round" transform="translate(395.6945388218378 81.04036399888625) rotate(0 18.83056279404184 17.07722131481387)"><path d="M8.54 0 C14.28 0, 20.02 0, 29.12 0 M8.54 0 C13.48 0, 18.43 0, 29.12 0 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M37.66 8.54 C37.66 13.19, 37.66 17.84, 37.66 25.62 M37.66 8.54 C37.66 13.16, 37.66 17.78, 37.66 25.62 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M29.12 34.15 C21.8 34.15, 14.48 34.15, 8.54 34.15 M29.12 34.15 C23.33 34.15, 17.54 34.15, 8.54 34.15 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M0 25.62 C0 20.95, 0 16.29, 0 8.54 M0 25.62 C0 19.2, 0 12.78, 0 8.54 M0 8.54 C0 2.85, 2.85 0, 8.54 0 M0 8.54 C0 2.85, 2.85 0, 8.54 0" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(410.09310148546456 88.11758531370012) rotate(0 4.432000130414963 10)"><text x="4.432000130414963" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">4</text></g><g stroke-linecap="round"><g transform="translate(211.2348978853924 97.90947118386268) rotate(0 12.555873148471392 -0.08751172633027693)"><path d="M0 0 C4.19 -0.03, 20.93 -0.15, 25.11 -0.18 M0 0 C4.19 -0.03, 20.93 -0.15, 25.11 -0.18" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(211.2348978853924 97.90947118386268) rotate(0 12.555873148471392 -0.08751172633027693)"><path d="M13.34 4.2 C17.03 2.83, 20.71 1.46, 25.11 -0.18 M13.34 4.2 C17.75 2.56, 22.16 0.92, 25.11 -0.18" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(211.2348978853924 97.90947118386268) rotate(0 12.555873148471392 -0.08751172633027693)"><path d="M13.28 -4.39 C16.99 -3.07, 20.69 -1.75, 25.11 -0.18 M13.28 -4.39 C17.72 -2.81, 22.15 -1.23, 25.11 -0.18" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(285.3168223114394 98.51046368219372) rotate(0 12.932516873638917 -0.05334250166335153)"><path d="M0 0 C4.31 -0.02, 21.55 -0.09, 25.87 -0.11 M0 0 C4.31 -0.02, 21.55 -0.09, 25.87 -0.11" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(285.3168223114394 98.51046368219372) rotate(0 12.932516873638917 -0.05334250166335153)"><path d="M13.73 4.37 C16.99 3.16, 20.26 1.96, 25.87 -0.11 M13.73 4.37 C17.79 2.87, 21.86 1.37, 25.87 -0.11" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(285.3168223114394 98.51046368219372) rotate(0 12.932516873638917 -0.05334250166335153)"><path d="M13.69 -4.48 C16.97 -3.3, 20.24 -2.13, 25.87 -0.11 M13.69 -4.48 C17.77 -3.02, 21.84 -1.55, 25.87 -0.11" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(361.0416926420962 97.30585314739082) rotate(0 13.911465866207834 -0.1759226108176506)"><path d="M0 0 C4.64 -0.06, 23.19 -0.29, 27.82 -0.35 M0 0 C4.64 -0.06, 23.19 -0.29, 27.82 -0.35" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(361.0416926420962 97.30585314739082) rotate(0 13.911465866207834 -0.1759226108176506)"><path d="M14.81 4.57 C18.67 3.11, 22.53 1.65, 27.82 -0.35 M14.81 4.57 C19.55 2.78, 24.29 0.99, 27.82 -0.35" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(361.0416926420962 97.30585314739082) rotate(0 13.911465866207834 -0.1759226108176506)"><path d="M14.69 -4.94 C18.59 -3.58, 22.49 -2.22, 27.82 -0.35 M14.69 -4.94 C19.47 -3.27, 24.26 -1.6, 27.82 -0.35" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(10 87.48714086371425) rotate(0 17.863981008529663 10)"><text x="0" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">head</text></g><g stroke-linecap="round"><g transform="translate(53.086743387694696 96.85908424806163) rotate(0 13.041288983924375 -0.01836488277126591)"><path d="M0 0 C4.35 -0.01, 21.74 -0.03, 26.08 -0.04 M0 0 C4.35 -0.01, 21.74 -0.03, 26.08 -0.04" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(53.086743387694696 96.85908424806163) rotate(0 13.041288983924375 -0.01836488277126591)"><path d="M13.83 4.44 C17.47 3.11, 21.11 1.78, 26.08 -0.04 M13.83 4.44 C17.1 3.25, 20.36 2.05, 26.08 -0.04" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(53.086743387694696 96.85908424806163) rotate(0 13.041288983924375 -0.01836488277126591)"><path d="M13.82 -4.48 C17.46 -3.16, 21.1 -1.84, 26.08 -0.04 M13.82 -4.48 C17.09 -3.3, 20.36 -2.11, 26.08 -0.04" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(89.3817237398801 80.78629183083146) rotate(0 18.83056279404184 17.07722131481387)"><path d="M8.54 0 C15.16 0, 21.78 0, 29.12 0 M8.54 0 C13.48 0, 18.42 0, 29.12 0 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M29.12 0 C34.81 0, 37.66 2.85, 37.66 8.54 M37.66 8.54 C37.66 12.87, 37.66 17.21, 37.66 25.62 M37.66 8.54 C37.66 14.49, 37.66 20.44, 37.66 25.62 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M37.66 25.62 C37.66 31.31, 34.81 34.15, 29.12 34.15 M29.12 34.15 C24.39 34.15, 19.66 34.15, 8.54 34.15 M29.12 34.15 C24.49 34.15, 19.86 34.15, 8.54 34.15 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M8.54 34.15 C2.85 34.15, 0 31.31, 0 25.62 M0 25.62 C0 20.88, 0 16.14, 0 8.54 M0 25.62 C0 21.43, 0 17.24, 0 8.54 M0 8.54 C0 2.85, 2.85 0, 8.54 0 M0 8.54 C0 2.85, 2.85 0, 8.54 0" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(103.70028636059163 87.86351314564533) rotate(0 4.512000173330307 10)"><text x="4.512000173330307" y="14" font-family="Virgil, Segoe UI Emoji" font-size="16px" fill="var(--md-primary-bg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">0</text></g><g stroke-linecap="round"><g transform="translate(134.60981658229855 98.8224707348991) rotate(0 12.614317864445638 0.06762868546550749)"><path d="M0 0 C4.2 0.02, 21.02 0.11, 25.23 0.14 M0 0 C4.2 0.02, 21.02 0.11, 25.23 0.14" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(134.60981658229855 98.8224707348991) rotate(0 12.614317864445638 0.06762868546550749)"><path d="M13.35 4.39 C17.96 2.74, 22.56 1.09, 25.23 0.14 M13.35 4.39 C16.66 3.2, 19.96 2.02, 25.23 0.14" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g><g transform="translate(134.60981658229855 98.8224707348991) rotate(0 12.614317864445638 0.06762868546550749)"><path d="M13.4 -4.24 C17.99 -2.55, 22.57 -0.85, 25.23 0.14 M13.4 -4.24 C16.69 -3.02, 19.98 -1.81, 25.23 0.14" stroke="var(--md-primary-bg-color)" stroke-width="1" fill="none"></path></g></g><mask></mask></svg>

    ```kotlin linenums="1"
    class LinkedListStack : Stack {

      private var _size: Int = 0
      private var head: Node? = null

      override val empty: Boolean
        get() = head == null

      override val size: Int
        get() = _size

      override fun push(item: Int) {
        head = Node(item, head)
        _size++
      }

      override fun pop(): Int? {
        if (head != null) {
          _size--
        }
        val result = head?.item
        head = head?.next
        return result
      }
    }

    data class Node(val item: Int, var next: Node? = null)
    ```

=== "Unit tests"

    ```kotlin linenums="1"
    class StackTest {

      private lateinit var stack: Stack

      @BeforeEach
      fun setup() {
        stack = Stack()
      }

      @Test
      fun empty() {
        assertThat(stack.empty).isTrue()
        assertThat(stack.size).isEqualTo(0)
        assertThat(stack.pop()).isNull()
      }

      @Test
      fun single() {
        stack.push(4)
        assertThat(stack.empty).isFalse()
        assertThat(stack.size).isEqualTo(1)

        assertThat(stack.pop()).isEqualTo(4)

        assertThat(stack.empty).isTrue()
        assertThat(stack.size).isEqualTo(0)
        assertThat(stack.pop()).isNull()
      }


      @Test
      fun push() {
        for (i in 1..100) {
          stack.push(i)
        }
        assertThat(stack.size).isEqualTo(100)

        for (i in (1..100).reversed()) {
          assertThat(stack.size).isEqualTo(i)
          assertThat(stack.pop()).isEqualTo(i)
        }
        assertThat(stack.empty).isTrue()
        assertThat(stack.size).isEqualTo(0)
        assertThat(stack.pop()).isNull()
      }
    }
    ```

## Comparision

<div id="impl"></div>

<script type="text/javascript">
  function chart() {
    var data = google.visualization.arrayToDataTable(
      [
        ["Size", "Array", "Linked List"],
        [100, 0, 0],
        [1000, 0, 0],
        [10000, 0, 0],
        [100000, 1, 1],
        [1000000, 3, 17],
        [2000000, 2, 16],
        [5000000, 8, 18],
        [8000000, 6, 26],
        [10000000, 14, 137],
        [20000000, 24, 216],
      ]
    );

    var options = {
      title: 'Stack: array vs linked list',
      curveType: 'function',
      hAxis: {
        title: 'input size'
      },
      vAxis: {
        title: 'millis',
        viewWindow: {
          min: 0,
          max: 256
        },
      }
    };

    const chart = new google.visualization.LineChart(document.getElementById('impl'));
    chart.draw(data, options);
  };  
  google.charts.setOnLoadCallback(chart);
</script>
