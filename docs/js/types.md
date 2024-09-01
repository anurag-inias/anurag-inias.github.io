# Types

<style>
.md-logo img {
  content: url('/js/javascript.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/js/javascript.svg');
}
</style>

## 1. boolean

Primitive, has only two values `true` or `false`. All values are truthy, except[<sup>1</sup>](https://developer.mozilla.org/en-US/docs/Glossary/Truthy):

- `false`
- `0`, `-0`, `0n`
- `""`
- `null`, `undefined`
- `NaN`
- `document.all` ⚠ deprecated

But since it's Javascript, our exceptions have exceptions. `{}` is truthy, yet `{} == false`. That's because:

```javascript
String({})                 // '[object Object]' non-empty string
Boolean('[object Object]') // true
```

## 2. number

JS has no separate `int` and `float` types. Instead all numbers are represented as IEEE 754 64-bit floating numbers. Integers in range \\(\pm2^{53}-1\\) can be represented exactly.

```javascript
42       // decimal
0b101010 // in binary (ES6)
052      // in octal  (ES6)
0o52     // in octal  (ES6)
0x2a     // in hexadecimal
4.2e1    // in exponential
```

`Number` is the wrapper object around the primitve.

Property | Decription
---------|-------------
`Number.MAX_VALUE` | Largest representable positive number
`Number.MAX_SAFE_INTEGER` | Largest safe integer \\(2^{53}-1\\)
`Number.EPSILON` | Smallest value greater than \\(1\\) that can be represented.
`Number.NaN` | Special "not a number" value.
`Number.POSITIVE_INFINITY` | Overflow.

```javascript
Number.parseInt('2')    // 2
Number.parseInt('2.0')  // 2
Number.parseInt('2a')   // 2
Number.parseInt('2a2')  // 2
Number.parseInt('22a')  // 22
Number.parseInt('a2')   // NaN

Number.isInteger('2.0') // True
Number.isInteger('2.1') // False
```

## 3. BigInt

For arbitrary length integer.

```javascript
>> 1234567891234567891
1234567891234568000    // normal number can't handle it

>> 1234567891234567891n
1234567891234567891n   // a bigint literal

>> BigInt("1234567891234567891")
1234567891234567891n   // can also pass as a long string

>> BigInt(1234567891234567891)
1234567891234567936n   // ⚠ precision can be lost before conversion
```

Since Sept 2020 available in latest browsers. 96% coverage as of Sep 2024.

```javascript
1n + 2n // 3n
1n + 2  // Uncaught TypeError: Cannot mix BigInt and other types, use explicit conversions
```

## 4. string

Immutable ordered sequence of 16-bit values, each of which typically represents a Unicode character. `length` is the count of these 16-bit values.

```javascript
'€'.length; // 1
'❤️'.length; // 2
```

Since ES6 strings are iterable, so use `for/of` loop, or `...` operator to iterate the actual characters of the strings and not the 16-bit values.

```javascript
for (const c of '❤️') {
  console.log(c); // '❤️'
}

let [..codepoints] = '❤️'; // ['❤️']
```

Use backticks for constructing string templates.

```javascript
let name = 'Oinkster';
let greet = `Hello ${name}`; // 'Hello Oinkster'
```

## 5. null 

Represents a program-level, normal, or expected absence of value.

```javascript
typeof null; // 'object'
```

is an known bug.

## 6. undefined

Represents a system-level, unexpected, or error-like absence of value. It's a the value of a variable that has not been initialized. It's also the return value of functions that return nothing.

## 7. Symbol

```javascript
let a = Symbol("hi"); // Symbol(hi)

let s = Symbol(); // Symbol()
let t = Symbol(); // Symbol()
s == t;           // false

Symbol(123) == Symbol(123) // false
Symbol("x") == Symbol("x") // false
```

there is no `Symbol` literal. `Symbol()` function returns unique values each time.

```javascript
let s = Symbol.for("foo");
let t = Symbol.for("foo");
s == t;                    // true
```

JavaScript defines a global Symbol registry, which if needed can be used to pump out reproducible symbols with `Symbol.for`.

## 8. object

![](/js/ok.png){width=100px}

[...alright](/js/objects)

-------------------

## typedef

Type | Result | Comments
-----|--------|-----------
`typeof true` | `'boolean'` | 
`typeof 42` | `'number'` |
`typeof 42n` | `'bigint'` |
`typeof 'hello'` | `'string'` |
`typeof null` | `'object'` | bug
`typeof undefined` <br> `typeof neverSeenBeforeName` | `'undefined'`
`typeof Symbol()` | `'symbol'` |
`typeof {}` <br> | `'object'` | 
`typeof console.log` | `'function'` | implements `[[Call]]`
`typeof WeakMap` | `'function`' | classes are functions