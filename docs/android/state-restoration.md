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

### 1. Before fragments were a thing
