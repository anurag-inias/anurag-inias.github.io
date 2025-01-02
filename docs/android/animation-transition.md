# Navigation animations

<style>
.md-logo img {
  content: url('/android/logo.svg');
}
</style>

[source](https://developer.android.com/guide/fragments/animate)

There are two mains ways to animation navigations:

1. `Animation` + `Animator`
2. Transitions framework

## Animation + Animator

![](https://developer.android.com/static/images/training/basics/fragments/enter-exit-animation.gif){width=200}

In above example, the previous fragment `fades out` while the new fragment `slides in`.

<div class="grid" markdown>

```xml linenums="1" title="res/anim/fade_out.xml"
<?xml version="1.0" encoding="utf-8"?>
<alpha xmlns:android="http://schemas.android.com/apk/res/android"
  android:duration="@android:integer/config_shortAnimTime"
  android:interpolator="@android:anim/decelerate_interpolator"
  android:fromAlpha="1"
  android:toAlpha="0" />
```

```xml linenums="1" title="res/anim/slide_in.xml"
<?xml version="1.0" encoding="utf-8"?>
<translate xmlns:android="http://schemas.android.com/apk/res/android"
  android:duration="@android:integer/config_shortAnimTime"
  android:interpolator="@android:anim/decelerate_interpolator"
  android:fromXDelta="100%"
  android:toXDelta="0%" />
```

```xml linenums="1" title="res/anim/fade_in.xml"
<?xml version="1.0" encoding="utf-8"?>
<alpha xmlns:android="http://schemas.android.com/apk/res/android"
  android:duration="@android:integer/config_shortAnimTime"
  android:interpolator="@android:anim/decelerate_interpolator"
  android:fromAlpha="0"
  android:toAlpha="1" />
```

```xml linenums="1" title="res/anim/slide_out.xml"
<?xml version="1.0" encoding="utf-8"?>
<translate xmlns:android="http://schemas.android.com/apk/res/android"
  android:duration="@android:integer/config_shortAnimTime"
  android:interpolator="@android:anim/decelerate_interpolator"
  android:fromXDelta="0%"
  android:toXDelta="100%" />
```

</div>

include these animations the part of transaction.

```kotlin linenums="1"
supportFragmentManager.commit {
  setReorderingAllowed(true)
  setCustomAnimations(
    /* enter=    */ R.anim.slide_in,
    /* exit=     */ R.anim.fade_out,
    /* popEnter= */ R.anim.fade_in,
    /* popExit   */ R.anim.slide_out
  )
  replace(R.id.fragment_container, fragment)
  addToBackStak(null)
}
```

==Animations must be set before `replace`. Order matters.==

## Transition framework

The alternative approach is to define within each fragment, their enter/exit transition.

<div class="grid" markdown>

```xml linenums="1" title="res/transition/fade.xml"
<fade xmlns:android="http://schemas.android.com/apk/res/android"
  android:duration="@android:integer/config_shortAnimTime"/>
```

```xml linenums="1" title="res/transition/slide_right.xml"
<slide xmlns:android="http://schemas.android.com/apk/res/android"
  android:duration="@android:integer/config_shortAnimTime"
  android:slideEdge="right" />
```

```kotlin linenums="1" title="outgoing fragment" hl_lines="4 5"
class FragmentA : Fragment() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    val inflater = TransitionInflater.from(requireContext())
    exitTransition = inflater.inflateTransition(R.transition.fade)
  }
}
```

```kotlin linenums="1" title="incoming fragment" hl_lines="4 5"
class FragmentB : Fragment() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    val inflater = TransitionInflater.from(requireContext())
    enterTransition = inflater.inflateTransition(R.transition.slide_right)
  }
}
```

</div>

## Extras:

Read more about **postponing transitions** and sharing views between enter-exiting fragments on source page.
