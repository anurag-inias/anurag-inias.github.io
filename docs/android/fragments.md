# Fragments

<style>
.md-logo img {
  content: url('/android/logo.svg');
}
</style>

## Intro

[source](https://developer.android.com/guide/fragments)

- Modular portion of the user interface within an activity.
- Defines and manages its own layout, has its own lifecycle, and can handle its own input events.
- Must be hosted by an activity or another fragment.
- The fragment’s view hierarchy becomes part of, or attaches to, the host’s view hierarchy.
- Unlike activities,

## Creating fragment

<div class="grid" markdown>

```kotlin linenums="1"
class ExampleFragment
  : Fragment(R.layout.example_fragment)
```

```kotlin linenums="1"
class ExampleFragment: Fragment() {

  override fun onCreateView(
    inflater: LayoutInflater, container: ViewGroup?,
    savedInstanceState: Bundle?
  ): View? {
    return inflater.inflate(R.layout.example_fragment, container, false)
  }
}
```

</div>

## Adding to an activity

<div class="grid" markdown>

```xml linenums="1" title="example_activity.xml"
<androidx.fragment.app.FragmentContainerView
  xmlns:android="http://schemas.android.com/apk/res/android"
  android:id="@+id/fragment_container_view"
  android:layout_width="match_parent"
  android:layout_height="match_parent"
  android:name="com.example.ExampleFragment" />
```

In declarative approach, `android:name` specifies the class name of the fragment to instantiate.

```kotlin linenums="1" title="ExampleActivity.kt"
class ExampleActivity: AppCompatActivity(...) {

  override fun onCreate(savedState: Bundle?) {
    super.onCreate(savedState)

    if (savedState != null) {
      supportFragmentManager.commit {
        setReorderingAllowed(true)
        add<ExampleFragment>(R.id.fragment_container_view)
      }
    }
  }
}
```

In programatic approach, `android:name` is omitted. So no specific fragment is automatically instantiated. <br> <br> Note that fragment is automatically restored from the `savedState`.

</div>

## Passing arguments to fragment

<div class="grid" markdown>

```kotlin linenums="1" title="Pass from parent activity"
val bundle = bundleOf("foo" to 42)

supportFragmentManager.commit {
  setReorderingAllowed(true)
  add<ExampelFragment>(
    R.id.fragment_container_view,
    args = bundle
  )
}
```

```kotlin linenums="1" title="Retrieve in fragment"
override onViewCreated(...) {
  val answerToLife = requireArguments().getInt("foo")
}
```

</div>

## Fragment manager

[source](https://developer.android.com/guide/fragments/fragmentmanager)

Manages the fragment back stack, such as adding or removing fragments in response to user interactions. It can be accessed from both activity and fragment like this:

![](https://developer.android.com/static/images/guide/fragments/manager-mappings.png){width=540}

```kotlin linenums="1" title="Example transaction"
supportFragmentManager.commit {
  replace<ExampleFragment>(R.id.fragment_container)
  setReorderingAllowed(true)
  addToBackStack("name") // Name can be null
}
```

### `setReorderingAllowed` purpose

Ensures that any intermediaate fragments do not go through lifecycle changes and do not have their animations / transitions run. Intermediate fragments are one that are added and replaced right away.

It should always be set. But it's not default for compatibility reasons.

### `addToBackStack` purpose

Commits the transaction to back stack so user can later reverse it. Reversal is done transaction-by-transaction basis, and not just fragment-by-fragment.

<div class="grid" markdown>

`remove` w/o `addToBackStack`: <br> removed fragment is destroyed and user cannot navigate back to it.

`remove` with `addToBackStack`: <br> fragment is only `STOPPED` and later `RESUMED` when user navigates back. Its `view` is destroyed in this case.

</div>

### `setPrimaryNavigationFragment`

In split-view apps where app shows multiple sibling fragments on screen at same time, then one fragment must be designated the primary fragment to handle app's navigation.

This fragment is first to receive `onBackPressed` and system will check if this fragment can handle it.

This fragment is used by navigation component to resolve navigation actions.

### Class vs instance

[source](https://developer.android.com/guide/fragments/fragmentmanager#dependencies)

We can manually create an instance of a fragment and add it in a transaction:

```kotlin linenums="1"
val myFrag = ExampleFragment()
add(R.id.fragment_container, myFrag)
```

But recall from [Adding to an activity](#adding-to-an-activity) that on configuration changes, fragment manager automatically recreates the fragment for us, no manually instantiated fragment for it to us.

Internally it uses reflection to find and invoke a no-arg constructor of the fragment. That is, ==any custom constructor used the first time is not used during recreation==. Create a fragment factory to solve this.

<div class="grid" markdown>

```kotlin linenums="1" title="factory"
class MyFragmentsFactory(val dep: MyDependency)
  : FragmentFactory() {

  override fun instantiate(
    classLoader: ClassLoader,
    className: String
  ): Fragment = when(loadFragmentClass(classLoader, className)) {
    ExampleFragment::class.java -> ExampleFragment(dep)
    else -> super.instantiate(classLoader, className)
  }
}
```

```kotlin linenums="1" title="In activity"
override fun onCreate(savedState: Bundle?) {
  supportFragment.fragmentFactory = MyFragmentsFactory(dep)
  super.onCreate(savedState)
}
```

</div>

You create a factory that knows how to create one or more types of fragments, and then let the parent activity know to use this factory. With all this set up, update the fragment transaction to use class instead of an instance:

```kotlin linenums="1"
add<ExampleFragment>(R.id.fragment_container)
```

## Fragment transaction

[source](https://developer.android.com/guide/fragments/transactions)

Each set of fragment changes that we commit are called a transaction.

- `commit` is async. It schedules the transaction to run on main UI thread as soon as possible.

- `commitNow` is synchronous, but it's incompatible with `addToBackStack`.

- We can use `commit` and then force immediate execution by `executePendingTransactions`.

- Order of actions within a commit is important.

## Attaching and detaching fragments

[source](<https://stackoverflow.com/questions/9156406/whats-the-difference-between-detaching-a-fragment-and-removing-it#:~:text=To%20add%20to%20Rajdeep's%20answer,called%20(in%20that%20order).>)

`detach` detaches a fragment from the UI, destroys its view hierarchy. However, fragment remains in `STOPPPED` state, same as being put in back stack and fragment manager continues to maintain its state. That is, it can be reused with `attach`.

| `remove`                                          | `detach`                             |
| ------------------------------------------------- | ------------------------------------ |
| view is destroyed but fragment itself is retained | both view and instance are destroyed |
| `onDestroyView onStop onPause`                    | `+ onStop onDetach`                  |

equivalently:

| `add`                                                                     | `attach`                                                       |
| ------------------------------------------------------------------------- | -------------------------------------------------------------- |
| for adding a new fragment not already part of the activity                | for reattaching a fragment that previously added then detached |
| triggers full lifecycle `onAttach onCreate onCreateView onStart onResume` | skips `onAttach onCreate`                                      |

{==
Note that `onAttach/onDetach` are poorly named.
==}

## Lifecycle

A fragment and its view have separate `Lifecycle`, managed independently. View's lifecycle can be accessed through `viewLifecycleOwner` in fragment.

![](https://developer.android.com/static/images/guide/fragments/fragment-view-lifecycle.png){width=420}

- Fragment when first instantiated is in `INITIALIZED` state. `findFragmentBy*` will not work yet.
- Not shown in diagram above, there are two more lifecyle events called `onAttach` and `onDetach`.
- `onAttach` is called before even `onCreate` and its counterpart is called after `onDestroy`.
- `onAttach` is called when it is added to a `FragmentManager` and its host. It is now **active**. `findFragmentBy*` starts working here.
- `onDetach` is called when fragment is remove from `FragmentManager`. It is no longer active and cannot be found with `findFragmentBy*`.

| Fragment  | View          | Notes                                                                                                             |
| --------- | ------------- | ----------------------------------------------------------------------------------------------------------------- |
| `CREATED` |               | added to `FragmentManager`. restore any saved state here.                                                         |
| `CREATED` | `INITIALIZED` | `view` can now be retrieved. set up initiate state of the view in `onViewCreated` and start observing `LiveData`. |
| `CREATED` | `CREATED`     | any previous view state is restored.                                                                              |
| `STARTED` | `STARTED`     | recommended to tie lifecycle-aware components to this state. safe to perform transactions on child fragment.      |
| `RESUMED` | `RESUMED`     | Animations and transitions have finished. ready for interaction. ok to manually set focus.                        |
| `CREATED` | `CREATED`     | downwards, no longer visible.                                                                                     |
| `CREATED` | `DESTROYED`   | exist animations and transitions done. fragment's view has been detached from the window.                         |

{==

`ON_STOP` event is the last point where it's safe to perform a fragment transaction.

![](https://developer.android.com/static/images/guide/fragments/stop-save-order.png){width=480}

==}

### Maximum state

`setMaxLifecycle` can be included in transaction to cap the maximum lifecycle state of a fragment. Additionally, a fragment cannot have state greater than its parent.
