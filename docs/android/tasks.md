# Tasks

[source](https://developer.android.com/guide/components/activities/tasks-and-back-stack#back-press-behavior)

{==

A collection of activities that user interact with when trying to do something in your app, arranged in a stack (i.e. *back stack*).

==}

- Home screen is the starting place for most tasks. Tapping on an app icon creates a new task for that launcher activity if one is not already present.
- When currenct activity `A` starts another, `B`, then `B` is added to the task and pushed to the top of the back stack. `A` remains in stack but is stopped.
    ![](https://developer.android.com/static/images/fundamentals/diagram_backstack.png)
- The `task` is a cohesive unit that can move the *background* as a whole when user starts another task or goes back to home screen.
- Activities in the start are never rearranged, and activities can only be added or removed from the top. So if `A` starts `B` and `B` starts `A`, system will not promote `A` to the top, instead it will be a new instance of `A` on top.  
    ![](https://developer.android.com/static/images/fundamentals/diagram_multiple_instances.png)
- Multi-window environment maintains separate tasks for each window.

## Manage behaviour

It is possible to interrupt the default behaviour of activities being added to the tasks, principally through manifest file and through the launch flags.

### Attribute in `manifest` 

- `android:taskAffinity`: activities with same affinity belong in same task, same "application" from user's perspective. By default, all activities in an application have same affinity. Use this attribute to group them differently. `""` is treated as no affinity, and instead it's inherited.
- `launchMode`: The values fall into two groups. First for normal launches, consider the task `[A B C D]` with a new intent arriving for `D` (which is at top):
   
    Launch mode | Multiple Instances? | Result        | Notes
    ------------|---------------------|---------------|----------
    `standard`  | Yes                 | `[A B C D D]` | New instance is created for every new intent
    `singleTop` | Conditionally       | `[A B C D]`   | Not if there's already an instance at the top. Intent is routed to `onIntent` of existing instance at the top.

    and for specialized launches:

    Launch mode             | Multiple Instances? | Notes
    ------------------------|---------------------|----------
    `singleTask`            | Conditionally       | Create activity at the root of a new task or locate existing one in a with same affinity task. **Back button** still takes you to top of old task. 
    `singleInstance`        | No                  | `singleTask + ` no other activity allowed in its task.
    `singleInstancePerTask` | Conditionally       | Can only be at the root of the task, thus only one instance per task.

    Let's say we have `[A B C]` in task and intent arrives for `A`. Both `singleTask` and `singleInstancePerTask` will finish `B` and `C`.

### Launch flags

- `FLAG_ACTIVITY_SINGLE_TOP` same as `singleTop`.
- `FLAG_ACTIVITY_NEW_TASK` same as `singleTask`.
- `FLAG_ACTIVITY_CLEAR_TOP` finishes activities on top of its instance in back stack. Has no equivalent `launchMode`. Usually used with `singleInstance` and adds the aforementioned quirk to it.

