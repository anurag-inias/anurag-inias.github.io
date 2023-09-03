# Types

there are 8 built-in types are:

type name | `typeof` output | type name | `typeof` output
----------|-----------------|-----------|-----------------
boolean   | `typeof(true) = 'boolean'` | number | `typeof(42) = 'number'`
string   | `typeof("hello") = 'string'` | null | `typeof(null) = 'object'`
undefined   | `typeof(undefined) = 'undefined'` <br/> `let foo; typeof(foo) = 'undefined'` | symbol[^symbol] | `typeof(Symbol('raven')) = 'symbol'`
bigint[^bigint]   | `typeof(17n) = 'bigint'` | object | `typeof({foo: 'bar'}) = 'object'` <br> `typeof([1, 2, 3]) = 'object'` <br> `typeof(function(){ console.log('hi'); }) = 'function'`

- `null` is its own type, yet mistakenly reported an `object`. that's a known bug in `typeof` implementation.
- `null` represents a program-level / normal / expected absence of value.
- `undefined` represents a system-level / error-like / unexpected absence of value.

## Symbols

serve as non-string property names. used to add unique property keys to an object that won't collide with keys any other code might add.

```javascript
Symbol()          === Symbol()             // false
Symbol("foo")     === Symbol("for")        // false, guaranteed to return unique Symbol
Symbol.for('foo') === Symbol.for('foo')    // true, saved in fictitious global registry

Symbol("foo").description       // 'foo'
Symbol().description            // 'undefined'
Symbol.keyFor(fooSymbol)        // 'foo'
```

Symbols are only primitive data type that has reference identity, and behave like objects in some way. 

- They are garbage collectable, and can be stored in `WeakMap`, `Weakset`, `WeakRef` etc. 
- Registed symbols are like `string`s they wrap instead, and are **NOT** garbage collectable, and **cannot** be stored in `WeakMap`, `Weakset`, `WeakRef` etc.

_Well-known_ symbols are used to extend the language:

- `String` function calls `toString()/valueOf()` method and `JSON.stringify` calls `toJSON()` method on the objects. But that was not scalable as new and new operations are added to the language, due to collision risk. This is fixed with Symbols, guaranteed to be unique.

## Number

There are no separate `int`, `float` etc in Javascript. Instead `number` is [double-precision floating point](/data-structures/numbers#floating-point). 

constants                 | value    | constants                 | value
--------------------------|----------|---------------------------|----------
`Number.MIN_SAFE_INTEGER` | $-2^{53}+1$|`Number.MAX_SAFE_INTEGER` | $2^{53}-1$
`Number.MIN_VALUE` | $2^{-1074}$ <br/> values closest to 0|`Number.MAX_SAFE_INTEGER` | $2^{1024}-1$
`Number.NEGATIVE_INFINITY` | $-\infty$ |`Number.POSITIVE_INFINITY` | $+\infty$
`Number.EPSILON` | $2^{-52}$ <br/> $1+\epsilon$ next representable <br/> number after 1 |`Number.NaN` | Not a number

## Boolean

every value is considered _truthy_ except the following _falsy_ values:

```javascript
undefined
null
0, -0
NaN
"" 
```

## String

Javascript uses UTF-16 encoding (unlike Go, which uses UTF-8). Most string operations work on 16-bit values, without any normalization (again, unlike `rune` in Go). With ES6, `for/of` loop works on actual characters and not just 16-bit values.

```javascript
let euro = "€";  // euro.length = 1, has one 16-bit element
let love = "❤"; // love.length = 2, does not fit in 16-bit "\ud83d\udc99"
```

## Sources
- <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol" target="_blank">Symbol - MDN :octicons-tab-external-16:</a>

## Footnotes
[^symbol]: new in ES6 (2015).
[^bigint]: new in ES11 (2020).