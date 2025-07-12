# Job sequencing

## Description

Given a list of jobs each with a deadline and a profit, find the maximum profit earned within specified time duration. Each job can be done in a **unit of time**, but must be done before its deadline.

## Example

| Job | Deadline | Profit |
| --- | -------- | ------ |
| 1   | 9        | 15     |
| 2   | 2        | 2      |
| 3   | 5        | 18     |
| 4   | 7        | 1      |
| 5   | 4        | 25     |
| 6   | 2        | 20     |
| 7   | 5        | 8      |
| 8   | 7        | 10     |
| 9   | 4        | 12     |
| 10  | 3        | 5      |

The maximum profit we can earn for various time durations is:

=== "$t=1$"

    | $t=1$ |
    | ----- |
    | 5     |

=== "$t=2$"

    | $t=1$ | $t=2$ |
    | ----- |-------|
    | 6     | 5     |

=== "$t=3$"

    | $t=1$ | $t=2$ | $t=3$ |
    | ----- |-------|-------|
    | 3     | 6     | 5     |

=== "$t=4$"

    | $t=1$ | $t=2$ | $t=3$ | $t=4$ |
    | ----- |-------|-------|-------|
    | 1     | 6     | 3     | 5     |

=== "$t=5$"

    | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ |
    | ----- |-------|-------|-------|-------|
    | 9     | 6     | 1     | 5     | 3     |

=== "$t=6$"

    | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ | $t=6$ |
    | ----- |-------|-------|-------|-------|-------|
    | 8     | 6     | 9     | 5     | 3     | 1     |

=== "$t=7$"

    | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ | $t=6$ | $t=7$ |
    | ----- |-------|-------|-------|-------|-------|-------|
    | 7     | 6     | 9     | 5     | 3     | 8     | 1     |

=== "$t=8$"

    | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ | $t=6$ | $t=7$ | $t=8$ |
    | ----- |-------|-------|-------|-------|-------|-------|-------|
    | 7     | 6     | 9     | 5     | 3     | 4     | 8     | 1     |

=== "$t=9$"

    | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ | $t=6$ | $t=7$ | $t=8$ | $t=9$ |
    | ----- |-------|-------|-------|-------|-------|-------|-------|-------|
    | 7     | 6     | 9     | 5     | 3     | 4     | 8     |       | 1     |

## Stub

```kotlin linenums="1" hl_lines="25"
fun main() {
  val res = jobScheduling(
    15,
    Job(1, 9, 15),
    Job(2, 2, 2),
    Job(3, 5, 18),
    Job(4, 7, 1),
    Job(5, 4, 25),
    Job(6, 2, 20),
    Job(7, 5, 8),
    Job(8,7, 10),
    Job(9, 4, 12),
    Job(10, 3, 5),
  )
  println(res.contentToString())
}

data class Job(val id: Int, val deadline: Int, val profit: Int) {
  override fun toString(): String {
    return "$id"
  }
}

fun jobScheduling(deadline: Int, vararg jobs: Job): Array<Job?> {
  /* Fill here */
}
```

## Hint

??? "Expand"

    Greedy, but in what?

## Solution

??? "Approach"

    First sort the tasks in descending order of their profits.

    | Job | Deadline | Profit |
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

    === "$t=1$"

        | $t=1$ |
        | ----- |
        | 5     |

    === "$t=2$"

        | $t=1$ | $t=2$ |
        | ----- |-------|
        | 6     | 5     |

    === "$t=3$"

        | $t=1$ | $t=2$ | $t=3$ |
        | ----- |-------|-------|
        | 3     | 6     | 5     |

    === "$t=4$"

        | $t=1$ | $t=2$ | $t=3$ | $t=4$ |
        | ----- |-------|-------|-------|
        | 1     | 6     | 3     | 5     |

    === "$t=5$"

        | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ |
        | ----- |-------|-------|-------|-------|
        | 9     | 6     | 1     | 5     | 3     |

    === "$t=6$"

        | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ | $t=6$ |
        | ----- |-------|-------|-------|-------|-------|
        | 8     | 6     | 9     | 5     | 3     | 1     |

    === "$t=7$"

        | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ | $t=6$ | $t=7$ |
        | ----- |-------|-------|-------|-------|-------|-------|
        | 7     | 6     | 9     | 5     | 3     | 8     | 1     |

    === "$t=8$"

        | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ | $t=6$ | $t=7$ | $t=8$ |
        | ----- |-------|-------|-------|-------|-------|-------|-------|
        | 7     | 6     | 9     | 5     | 3     | 4     | 8     | 1     |

    === "$t=9$"

        | $t=1$ | $t=2$ | $t=3$ | $t=4$ | $t=5$ | $t=6$ | $t=7$ | $t=8$ | $t=9$ |
        | ----- |-------|-------|-------|-------|-------|-------|-------|-------|
        | 7     | 6     | 9     | 5     | 3     | 4     | 8     |       | 1     |

??? "Implementation"

    ```kotlin linenums="1"
    fun jobScheduling(time: Int, vararg jobs: Job): Array<Job?> {
      // Take jobs in descending order of profitability.
      val sorted = jobs.sortedBy { -it.profit }
      // We have [deadline] amount of time and each job can be done
      // in a unit of time. So create an array of slots for all possible
      // jobs.
      // [ , , , , ..., ] length = time
      val slots = Array<Job?>(time) { null }

      // Pick next most profitable job.
      for (job in sorted) {
        // This job must be done by [job.deadline], so it must start
        // no later than [job.deadline - 1].
        // However, we only have [time] duration available.
        // e.g. time = 3, job.deadline = 15. So no job can end after 3.
        val latestStartTime = min(job.deadline, time) - 1
        // Find a slot as late as possible.
        for (i in latestStartTime downTo 0) {
          if (slots[i] == null) { // Found!
            slots[i] = job
            break
          }
        }
      }

      println(slots.filterNotNull().sumOf { it.profit })
      return slots
    }
    ```
