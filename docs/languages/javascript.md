# Javascript

## Types

Javascript has typed values (not typed variables). `typeof` operator returns the type of the value that the pointed variable holds:

# | Type | `typeof` output | Comments
--|-----|-----------|------------
1 | string | `"string"` |
2 | number | `"number"` |
3 | boolean | `"boolean"` |
4 | null | `"object"` | error in `typeof`
5 | undefined | `"undefined"`
6 | symbol | `"symbol"` | Added in ES6 (ECMAScript 2015)
7 | bigint | `"bigint"` | Added in ES11 (ECMAScript 2020)
8 | object | `"object"` |

- _array_ and _function_ are subtype of `object`.
    - arrays in JS are heterogenous `["hello", false, 19]`.
    - `typeof [1, 2, 3] = "object"`.
    - `typeof someFunction = "function"` :fontawesome-solid-explosion:. If the object implements `[[Call]]`, then `typeof` will return `"function"`.
