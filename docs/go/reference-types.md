# Reference Types

<style>
.md-logo img {
  content: url('/go/logo-go.svg');
}
</style>

Pointers, slices, maps, functions, channels and interface. We already discussed pointers and will cover the next two here.

## Slices

Variable-length sequences whose elements all have same type. Written as `[]T`, like an array without size.

- It's a lightweight data structure that gives access to a subsequence within an _underlying array_.
- It has three components:

      1. _pointer_: reference to the first element of the accessible subsequence of the underlying array. May or may not be the first element of the array.
      2. _capacity_: number of elements between the start of the slice and the end of underlying array. Returned by `cap`.
      3. _length_: number of elements in the slice. Can't exceed the _capacity_. Returned by `len`.

- Slicing beyond `len` extends the slice, but beyond `cap` causes panic.
- Multiple slices can share the same underlying array and can overlap.
- Slices are not comparable (unlike arrays). And cannot be used as maps in a key.

```golang
months := [...]string{"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
fmt.Println(reflect.TypeOf(months)) // [12]string

slice := months[:]
fmt.Println(reflect.TypeOf(slice))  // []string

slice = months[:3]
fmt.Println(slice, len(slice), cap(slice)) // [Jan Feb Mar] 3 12

slice = months[3:]
fmt.Println(slice, len(slice), cap(slice)) // [Apr ... Dec] 9 9
```

`months[:3]` reports capacity $12$ because the first element of the slice is `0`, so can it can be extended to the left (backwards). `months[3:]` reports capacity $9$ because it begins index `3` and cannot be extended anymore.

```golang
var s []int // len(s) == 0, s == nil

a := make([]T, len)
b := make([]T, len, cap)
```

zero value of a slice is `nil`.

## Maps

is a reference to a hash table. In `map[K]V`, key must be comparable using `==`.

<div markdown class="grid">

```golang title="map literal" linenums="1"
employeeIds := map[string]int {
  "alice": 123,
  "bob": 456
}
```

```golang title="with make" linenums="1"
employeeIds := make(map[string]int)
```

</div>

Once again, as a reference type, zero value of a map is `nil`.

- Operations such as get (`map["foo"]`), set (`map["foo"] = "bar"`), delete (`delete(map, "foo")`) are safe even if the key is absent.
- Map elements are not variables and thus cannot be addressed with `&` operator.
- Order of map iteration is random.
- Most map operation can be done even on `nil` map. But `set` on a `nil` map causes panic.
