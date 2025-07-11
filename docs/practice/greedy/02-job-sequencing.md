# Job sequencing

## Problem

Given a list of tasks with deadlines and a profit each, find the maximum profit earned within specified deadline.

| Task | Deadline | Profit |
| ---- | -------- | ------ |
| 1    | 9        | 15     |
| 2    | 2        | 2      |
| 3    | 5        | 18     |
| 4    | 7        | 1      |
| 5    | 4        | 25     |
| 6    | 2        | 20     |
| 7    | 5        | 8      |
| 8    | 7        | 10     |
| 9    | 4        | 12     |
| 10   | 3        | 5      |

## Hint

??? "Expand"

    Greedy, but in what?

## Solution

??? "Approach"

    First sort the tasks in descending order of their profits.

    | Task | Deadline | Profit |
    | ---- | -------- | ------ |
    | 5    | 4        | 25     |
    | 6    | 2        | 20     |
    | 3    | 5        | 18     |
    | 1    | 9        | 15     |
    | 9    | 4        | 12     |
    | 8    | 7        | 10     |
    | 7    | 5        | 8      |
    | 10   | 3        | 5      |
    | 2    | 2        | 2      |
    | 4    | 7        | 1      |

    Then process these task one by one and **try to schedule them as late as possible**.

??? "Implementation"

    ```kotlin linenums="1"
    // (deadline, profit)
    fun jobScheduling(tasks: List<Pair<Int, Int>>, deadline: Int) : Array<Pair<Int, Int>> {
      val picked = Array<Pair<Int, Int>?>(deadline, init = { null })
      val sorted = tasks.toMutableList().sortedBy { -it.second } // descending order of profit

      for (job in sorted) {
        for (latestSlot in picked.indices.reversed()) {
          if (picked[latestSlot] == null && job.first <= latestSlot + 1) {
            picked[latestSlot] = job
            break
          }
        }
      }

      return picked.filterNotNull().toTypedArray()
    }
    ```

## Unit tests

```kotlin linenums="1"
@Test
fun example_1() {
  val tasks = listOf(
    9 to 15,
    2 to 2,
    5 to 18,
    7 to 1,
    4 to 25,
    2 to 20,
    5 to 8,
    7 to 10,
    4 to 12,
    3 to 5,
  )
  val picked = arrayOf(
    2 to 2, // 1
    3 to 5, // 2
    5 to 8, // 3
    7 to 10, // 4
    4 to 12, // 5
    9 to 15, // 6
    5 to 18, // 7
    2 to 20, // 8
    4 to 25, // 9
  )
  assertThat(jobScheduling(tasks, 15)).isEqualTo(picked)
}
```
