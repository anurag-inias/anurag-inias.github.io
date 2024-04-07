# Basics

## Types

=== "number \\(\&\\) bigint"

    Represents both integer and floating point numbers. 

    ```javascript
    255 === 255.0 // true
    0xff          // same
    0b11111111    // same
    0.255e2       // same, decimal exponent notation
    ```

    It uses double-precision 64bit number. \\(1\\) bit for _sign_, \\(11\\) bits for _exponent_ and \\(52\\) bits for _mantissa_ (a number b/w \\(0\\) and \\(1\\)).

    \\[
      \text{number} = -1^\text{sign} \cdot (1 + \text{mantissa}) \cdot 2^{\text{exponent}}
    \\]
    
    There are also special numeric values `Infinity`, `-Infinity` and `NaN`.

    ```javascript
    1/0         // Infinity
    1/0 === 2/0 // true, Infinity/-Infinity are global variables

    // Represents computation error. It poisons mathematical expressions
    0/0         // NaN
    NaN == NaN  // false, no two NaN are same.
    ```

    Integers can be represented without loss of precision in range \\(\[-2^{53}+1, 2^{53}-1\]\\). Use `BigInt` beyond that.

    ```javascript
    Number.MAX_SAFE_INTEGER // 9007199254740991
    Number.MAX_VALUE        // 1.7976931348623157e+308
    9007199254740991 + 1 === 9007199254740991 + 2 // true, 9007199254740992

    const num = 1234567890123456789012345678901234567890n;
    typeof num; // bigint
    ```

    ==Don't mix `bigint` and `number` in expressions.==

    **Type coercion**

    ```javascript
    Number(true)      // 1
    Number(false)     // 0
    Number(undefined) // NaN

    Number("123")     // 123
    Number(" 123")    // 123, whitespace/line terminators are ignored
    Number("0123")    // 123, leading 0 is not taken as octal literal
    Number("1,234")   // NaN, separators are not supported
    Number("   ")     // 0
    Number("foo")     // NaN
    Number("false")   // NaN

    Number([])        // 0
    Number([0])       // 0
    Number([1])       // 1
    Number([1, 1])    // NaN

    Number({})        // NaN
    ```

    Objects are first converted to primitive by calling `[@@toPrimitive]()`, `valueOf()`, and `toString()` in order; the resulting primitive is then converted to a number. 

=== "string"

    Strings are sequences of UTF-16 code units in JS. Every code unit is 16bits long, and can represent most common characters like Latin, Greek, Cyrillic alphabets and many East Asian characters.

    ```javascript
    const s = "A string";
    const s = 'A string';
    const s = `A string`; // template literal
    const s = new String("A string"); // typeof = "object"

    "cat".charAt(1); // 'a', thre is no character type
    "cat"[1];        // 'a', not writable
    ```

    JS distinguishes b/w `String` object and primitive string values (same for `Boolean` and `Number`).

    **Type coercion**

    ```javascript
    String(undefined) // 'undefined'
    String(null)      // 'null'
    String(0xff)      // '255', same as toString(10)
    ```

=== "boolean"

    Type with only two values `true` and `false`.

=== "undefined \\(\&\\) null"

    Both `null` and `undefined` are for the absence of value. `undefined` represents system-level, unexpected, or error-like absence of value. `null` on the other hand is for program-level, intentional absence of value.

    ```javascript
    null === undefined // false
    null == undefined  // true

    null === null      // true
    !null              // true
    ```

    For legacy reasons `typeof(null)` is `object`, that's a language bug.

    `undefined` a property of the _global object_. In all non-legacy browsers, it's a non-configurable, non-writable property. So avoid overriding it in legacy browsers.


=== "symbol"

    Built-in object whose constructor returns a `symbol` primitive, guaranteed to be unique. It is used to add unique property keys to an object that cannot collide with any other keys, so pretty useful for creating libraries.

    ```javascript
    const s = Symbol();
    Symbol("foo") == Symbol("foo"); // false

    // Prevents one from creating wrapper objects
    const s = new Symbol(); // TypeError
    ```

    To create shared symbols, use `Symbol.for`.

    ```javascript
    Symbol.for("foo") // Symbol(foo)
    Symbol.for("foo") == Symbol.for("foo") // true

    const s = Symbol.for("foo");
    Symbol.keyFor(s); // 'foo'
    ```

=== "object"

    All the aforementioned types are _primitive_, distinct from _Object_ type. Read more about it [here](/js/object.md).

## `typeof`

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

