# Activities

<style>
.md-logo img {
  content: url('/android/logo.svg');
}
</style>

[source](https://developer.android.com/guide/components/activities/intro-activities)

## Concept

- Mobile apps don't have a central entry point like `main`.
- User journey in your app may begin in a non-deterministically way. Example: gmail app start from the launcher icon vs opening from share sheet.
- Android starts the activities of an app, instead of app as an atomic whole.
- Activity provides window in which app draws its UI.

## Manifest

1. Activities must be declared in the manifest file:

```xml
<manifest ...>
  <application ...>
    <activity android:name=".FooActivity" />
```

    - `android:name` is the only required attribute.

2.  To allow other apps to launch your activity through **implicit intent**, add an `intent-filter`.

    === "called activity"

        ```xml
        <activity android:name=".FooActivity">
          <intent-filter>
            <action android:name="android.intent.action.SEND" />
            <category android:name="android.intent.category.DEFAULT" />
            <data android:mimeType="text/plain" />
        ```

    === "caller activity"

        ```kotlin
        startActivity(
          Intent().apply {
            action = Intent.ACTION_SEND
            type = "text/plain"
            putExtra(Intent.EXTRA_TEXT, "here goes my text")
          }
        )
        ```

    - `action` specifies that this activity sends data.
    - `category` as `DEFAULT` lets activity receive launch requests.
    - `data` specifies the type of data this activity can send.

3.  Caller and callee activities must share permission.

    === "called activity"

        ```xml
        <manifest>
          <activity
            android:name=".FooActivity"
            android:permission="com.example.fooapp.permission.SHARE_POST">
        ```

    === "caller activity"

        ```xml
        <manifest>
          <uses-permission android:name="com.example.fooapp.permission.SHARE_POST" />
        ```

## Lifecycle

[source](https://developer.android.com/guide/components/activities/activity-lifecycle)

<p style="background-color: rgba(255, 255, 255, 0.1); display: inline-block;" markdown>
![](https://developer.android.com/guide/components/images/activity_lifecycle.png)
</p>

1. `onCreate`: perform logic here that happens once in activity's life. e.g.:

   - bind data to list
   - associate activity with a `ViewModel`
   - instantiate class-scope variables.
   - set layout of the activity.

   ```
   onCreate -> onStart
   ```

2. `onStart`: it's now visible to the user. It used to be that activity would never remain in `STARTED` state for long. But on large screen devices, with multi/freeform window, that's no longer the case.

   ```
   onStart -> onResume
   ```

3. `onResume`: now in focus and interactive.

   ```
   onResume -> onPause
   ```

4. `onPause`: actitiy is no longer in focus. e.g. a dialog is partially obscuring the activity, or focus is on another activity in multi-window mode. This is very brief and doesn't have enough time to do network and/or disk calls (e.g. save state).

   ```
   onPause -> onResume / onStop
   ```

5. `onStop`: Happens when another activity has taken over the full screen or before the activity is finished running and due for termination. Release resources, stop animations, save stuff to db (if can't find a better alternative) and any CPU-intensive work here as the main thread is no longer updating the UI.

   ```
   onStop -> onRestart / onDestroy
   ```

6. `onDestroy`: Activity is either finishing for good or is being temporarily destroyed for configuration change. In the `ViewModel#onCleared()` of the activity, check `isFinishing()` to determine which of the two it is.

   ```
   onDestroy -> [onCreate]
   ```

Examples of activity state changes:

1. **Configuration change:** `onPause -> onStop -> onDestroy -> onCreate -> onStart -> onResume`
2. **Enter multi-window mode / resize:** same as previously mentioned.
3. **Activity / disalog appears in foreground:** `onPause <-> onResume` if partially covered. A further `onStop <-> onRestart -> onStart` is fully covered.
4. **Home / Recents button button:** same as if activity has been covered.
5. **Back button:** `onPause -> onStop -> onDestroy`. However, if it's the [root launcher activity](https://developer.android.com/guide/components/activities/tasks-and-back-stack#back-press-behavior):
   - on \\(\le\\) Android 11: system finishes the activity, so same as above.
   - on \\(\ge\\) Android 12: moves activity to background, so same as _home / recents_ button.
6. **Killed by system:** there is no guarantee that `onDestory` will be called.

{==

The system never kills an activity to free up memory, but instead the whole process.

==}
