# ViewModel

`ViewModel` holds business logic or screen level state. Its purpose is to cache state and persist it through configuration changes.

## Why

Persistence:

: Alternative to a ViewModel is a plain class to hold the data displayed in UI. Problem is that navigating between activities would destory this class's objects unless stored in `savedInstanceState`. ViewModel is a convenience API for data persistence.

Business logic:

: Most of the business logic is maintained in data layer, but UI layer can also contain business logic. i.e. combining data from multiple repositories to create screen UI state. ViewModel is also charged with handling events and delegating them to other layers.

Scope:

: When creating ViewModel, we pass it an implementer of `ViewModelStateOwner` and is scope to the `LifeCycle` of it. When fragment / activity to which ViewModel is scoped is destroyed, async work continue.

`SavedStateHandle`:

: Combine ViewModel with it if you wish to persist data not just through config changes, but across process recreation.
