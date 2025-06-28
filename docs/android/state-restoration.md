# State Restoration

[Source](https://developer.android.com/topic/libraries/architecture/saving-states)

==Users expect that when they start an activity, the transient UI state is retained until they completely dismiss the activity.== But the system does so in only a few cases.

## User expectation vs System behaviour

### :green_square: Dismissal by the user

<div markdown class="grid">

<div markdown>
User can completely dismiss an activity by doing the following.

1. Swiping away / clearing an activity from the launcher's overview (recents) screen.
2. Force killing an activity from settings.
3. Rebooting the device.
4. Completing some sort of "finishing" action, one which ends in `Activity.finish()` call.

In above scenarios, user expect the activity to start from a clean state and **system behaviour matches that**.

</div>

<video controls width="300" style="box-shadow: 2px 2px 2px 2px #ddd">
  <source src="../explicit-dismissal.mp4" type="video/mp4"/>
</video>

</div>

<hr/>

### :red_square: Configuration changes

<div markdown class="grid">

<div markdown>
User expect activity state to remain the same throughout configuration changes:

1. Rotation
2. Theme changes
3. Entering / exiting windowed mode

However, here the system destroys the activity and wipes away UI states, completely **opposite to user expectation**.

</div>

<video controls width="300" style="box-shadow: 2px 2px 2px 2px #ddd">
  <source src="../config-change.mp4" type="video/mp4"/>
</video>

<div markdown>

!!! note

    If you move an activity to background (home / recents button, and back button on Android 12+), its UI state will remain preserved through configuration changes, as long as you are back on the original configuration before bringing the activity to foreground.

</div>

<video controls width="300" style="box-shadow: 2px 2px 2px 2px #ddd">
  <source src="../config-change-avoided.mp4" type="video/mp4"/>
</video>

</div>

<hr/>

### :yellow_square: Context switches

<div markdown class="grid">

<div markdown>

Users also expect activity state to remain if they temporarily to different app and come back. This can include:

1. Answering a phone call in the middle of using your app.
2. `startActivityForResult` for taking a picture, initiated by your app.
3. Jumping to other apps to copy/paste stuff to/from other apps.

This is a mixed bag. **System does its best to keep your app process in memory**, but it may need to destroy the process when under resource constraints. In this case any UI state will also be destroyed. We **unexpectedly start with a clean state**.

</div>

<video controls width="300" style="box-shadow: 2px 2px 2px 2px #ddd">
  <source src="../context-switch.mp4" type="video/mp4"/>
</video>

</div>

<hr>

## Solutions over the years

### 1. `onSaveInstanceState` in Activity

=== "MainActivity.kt"

    ```kotlin linenums="1" hl_lines="20 33-36"
    class MainActivity : ComponentActivity() {

      // Starting value of our UI state.
      private var currentValue = 123

      private lateinit var content: TextView
      private lateinit var minusButton: Button
      private lateinit var plusButton: Button

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.main_activity)

        content = findViewById(R.id.content)
        minusButton = findViewById(R.id.minus_button)
        plusButton = findViewById(R.id.plus_button)

        // (2)
        currentValue = savedInstanceState?.getInt(CURRENT_VALUE_KEY, currentValue) ?: currentValue
        content.text = "$currentValue"


        minusButton.setOnClickListener {
          content.text = "${--currentValue}"
        }
        plusButton.setOnClickListener {
          content.text = "${++currentValue}"
        }
      }

      // (1)
      override fun onSaveInstanceState(outState: Bundle) {
        outState.putInt(CURRENT_VALUE_KEY, currentValue)
        super.onSaveInstanceState(outState) // (3)
      }

      companion object {
        private const val CURRENT_VALUE_KEY = "current_value"
      }
    }
    ```

=== "main_activity.xml"

    ```xml linenums="1"
    <?xml version="1.0" encoding="utf-8"?>
    <FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:theme="@style/Theme.StateRestoration">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:orientation="vertical"
            android:gravity="center">

            <TextView
                android:id="@+id/content"
                android:textSize="30sp"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"/>

            <LinearLayout
                android:layout_width="wrap_content"
                android:layout_height="wrap_content" android:orientation="horizontal">
                <Button
                    android:id="@+id/minus_button"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="—"/>
                <Button
                    android:id="@+id/plus_button"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="+"/>
            </LinearLayout>


        </LinearLayout>

    </FrameLayout>
    ```

1. Save additional information not captured by each individual view.
2. Restore captured information.
3. Content is saved in `outState` **before** calling the default implementation.

About `onSaveInstanceState`

: Called to retrieve per-instance state from an activity before being killed so that the state can be restored in `onCreate(Bundle)` or `onRestoreInstanceState(Bundle)` (the Bundle populated by this method will be passed to both).

- $\lt$ Android 9: called before `onStop`. May or may not be called before `onPause`.
- $\ge$ Android 9: called after `onStop`.

About `onRestoreInstanceState`

: Called between `onStart` and `onPostCreate`. This method is called only when recreating an activity; the method isn't invoked if `onStart` is called for any other reason. Most of the times you'd restore state in `onCreate`. Use this when it's convenient to restore state after all the initialization has been done.

**Interestingly, the default implementation `super.onSaveInstanceState` ==already takes care of most the UI state==. It :**

1. calls `View.onSaveInstanceState` on each view in the hierarchy that has an id.
2. saves the id of the currently focused view.

We can see this in action by replacing the `TextView` in the example above with `EditText` and removing the state restoration code.

=== "MainActivity.kt"

    ```kotlin linenums="1" hl_lines="3"
    class MainActivity : ComponentActivity() {

      private lateinit var content: EditText
      private lateinit var minusButton: Button
      private lateinit var plusButton: Button

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.main_activity)

        content = findViewById(R.id.content)
        minusButton = findViewById(R.id.minus_button)
        plusButton = findViewById(R.id.plus_button)

        minusButton.setOnClickListener {
          content.setText("${currentValue - 1}")
        }
        plusButton.setOnClickListener {
          content.setText("${currentValue + 1}")
        }
      }

      private val currentValue: Int
        get() = if (content.text.isEmpty()) 0 else content.text.toString().toInt()
    }
    ```

=== "main_activity.xml"

    ```xml linenums="1" hl_lines="13-18"
    <?xml version="1.0" encoding="utf-8"?>
    <FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:theme="@style/Theme.StateRestoration">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:orientation="vertical"
            android:gravity="center">

            <EditText
                android:id="@+id/content"
                android:textSize="30sp"
                android:text="123"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"/>

            <LinearLayout
                android:layout_width="wrap_content"
                android:layout_height="wrap_content" android:orientation="horizontal">
                <Button
                    android:id="@+id/minus_button"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="—"/>
                <Button
                    android:id="@+id/plus_button"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="+"/>
            </LinearLayout>


        </LinearLayout>

    </FrameLayout>
    ```

Notice how we don't need to override `onSaveInstanceState` anymore.

!!! warning

    `onSaveInstanceState` requires serialization/deserialization and happens on main thread. So don't use it to store large amounts of data, such as bitmaps, nor complex data structures.

### 2. `onSaveInstanceState` in Fragment

[source](https://developer.android.com/guide/fragments/saving-state)

Table below outlines the operations that can cause fragment to lose state and whether the various types of state persit.

| Operation                       | variables        | view state       | `savedInstanceState` |
| ------------------------------- | ---------------- | ---------------- | -------------------- |
| Added to back stack             | :material-check: | :material-check: | :material-close:     |
| Removed not added to back stack | :material-close: | :material-close: | :material-close:     |
| Config change                   | :material-close: | :material-check: | :material-check:     |
| Process death                   | :material-close: | :material-check: | :material-check:     |
| Host finished                   | :material-close: | :material-close: | :material-close:     |

- Variables: fields of fragment class.
- View state: any data owned by the views in the fragment.
- `savedInstanceState`: data saved in `onSaveInstanceState`.
