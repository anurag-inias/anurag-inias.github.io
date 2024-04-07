# Types

There are 8 basic types in JS, with all but _Objects_ being _primitive_.

## Boolean

Straightforward (or so I thought), has two possible values: `true` or `false`. Following values convert to `false`:

```javascript linenums="1"
undefined
null
0
-0
NaN
"" // empty string
```

all other values convert to `true`. Use `===`/`!==` to avoid the implicit type coercion. However, `[]` is both truthy and loosely `false`. It's truthy because all objects are truthy, but it's also `false` because it's converted to primitive via `toString()` and emits `""`.

<div class="grid" markdown>

```javascript linenums="1"
if ([]) {
  // executes
}
```

```javascript linenums="1"
if ([] == false) {
  // executes too
}
```

</div>

Use [`Boolean`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean) to convert non-boolean values to boolean. Don't use it with `new` operator as all objects are truthy, even `Boolean` objects.

```javascript linenums="1"
const good = Boolean(expression);

if (new Boolean(false)) { // Don't do this!
  // this will execute
}
```

## null & undefined

Both indicate the absence of a value. `==` consider them to be equal, falsy values.

`null` is the sole member of its own type and implies a program-level, intentional absence of a value. `typeof` will report it incorrectly as `'object'`, that's a legacy bug.

`undefined` represents uninitialized values, a deeper kind of a absence. `undefined` is variable in global scope.

## Symbol

Introduced in ES6 to serve as non-string property names. There is no literal syntax for symbols.

<div class="grid" markdown>

When you want to keep your symbols private to your own code, guaranteed that they will not conflict with properties used by other code.

When you want to share symbol widely with other code.

```javascript title="acquire unique symbols" linenums="1"
const a = Symbol();
const b = Symbol("foo");
const c = Symbol("foo");

a == b; // false
b == c; // false
```

```javascript title="acquire shared symbols" linenums="1"
const a = Symbol.for("shared");
const b = Symbol.for("shared");

a === b;          // true
Symbol.keyFor(a); // "shared"
```

</div>

## String

JS strings use UTF-16 encoding of Unicode character set as sequences of unsigned 16-bit values. This is fine for most commonly used unicode characters as they'll fit in a single code point. 

But there are unicode characters which will take two code points. These will report wrong `length` and attempts to iterate over these may give unexpected results. That's why it's recommended to use _for/of_ loop.

<div class="grid" markdown>

```javascript title="wrong way to iterate" linenums="1"
const smiley = "😄";
smiley.length; // 2, \ud83d\ude04

for (let i = 0; i < smiley.length; i++)
  console.log(smiley.charAt(i)); // � �
```

```javascript title="right way to iterate" linenums="1"
const smiley = "😄";
let length = 0;

for (let c of smiley) {
  console.log(c); // "😄"
  length++;
}

console.log(length); // 1
```

</div>

<div class="grid" markdown>

String created from literal and from `String()` call are primitive values.

But ones created from `new String()` are an object.

```javascript linenums="1"
'test' // 'test'
"test" // 'test'

const name = "bob";
`hello
${name}` // 'hello\nbob', 

String(1);        // '1'
typeof String(1); // 'string'
```

```javascript linenums="1"
new String("foo"); // String {'foo'}
typeof s;          // 'object'
```

</div>

## Number & BigInt

There are no distinct integer and floating representation, instead JS uses 64-bit IEEE 754 floating point for both. \\(1\\) bit for _sign_, \\(11\\) bits for _exponent_ and \\(52\\) bits for _mantissa_ (a number b/w \\(0\\) and \\(1\\)).

\\[
  \text{number} = -1^\text{sign} \cdot (1 + \text{mantissa}) \cdot 2^{\text{exponent}}
\\]

Integers can be represented without loss of precision in range \\(\[-2^{53}+1, 2^{53}-1\]\\). Use `BigInt` beyond that.

```javascript linenums="1"
Number.MAX_VALUE        // 1.7976931348623157e+308
Number.MAX_SAFE_INTEGER // 9007199254740991
Number.MAX_SAFE_INTEGER + 1 === Number.MAX_SAFE_INTEGER + 2 // true, precision loss

const num = 1234567890123456789012345678901234567890n;
typeof num; // bigint
```

## Object

Object types (objects, arrays, functions) need their own section for a thorough breakdown.

--------

## `typeof` heads up

```javascript
typeof 0           // 'number'
typeof 1n          // 'bigint'
typeof true        // 'boolean'
typeof 'foo'       // 'string'
typeof undefined   // 'undefined'
typeof null        // 'object', known bug 
typeof Symbol()    // 'symbol'

typeof {}          // 'object'
typeof console.log // 'function', still an object but treated differently by typeof
```

