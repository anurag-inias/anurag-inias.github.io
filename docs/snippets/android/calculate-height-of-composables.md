# Calculate height of composables

```kotlin
@Composable
fun MyComposable() {
  var height by remember { mutableStateOf(0.dp) }

  Column(
    modifier = Modifier
      .onGloballyPositioned { layoutCoordinates ->
        height = with(LocalDensity.current) { layoutCoordinates.size.height.toDp() }
      }
  ) {
    // Your composable content here
    Text("Height: ${height.value} dp")
  }
}
```
