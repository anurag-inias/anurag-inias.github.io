# Scope

The _scope_ of a variable is the region of the program source in which it is defined. 

##What is familiar

In modern JS (ES6+), variables are declared with `let` keyword and constants are declared with `const`. Both are _block scoped_. Those outside of any code blocks are _global_ variables / constants.

- In traditional client-side JS, scope of the global variable is the HTML document in which it is defined, shared across all `<script>` tags.
- In Node, client-side JS modules, scope of global variable is the file it is defined in.

## What is not

Prior to ES6, only way to declare variable was with `var` keyword, which has quite a idiosyncrasies to tackle:

1. Famously, `var` variables are _function scoped_.
2. Global `var`s are like members of the global object `globalThis`. That's `window` in browser context. However, they cannot be deleted with `delete globalThis[foobar]`.
3. It is legal to have multiple declaration of same variable in same function with `var`.
4. Declartions made with `var` are hoisted.

```javascript
a = 2;                                             var a;
var a;                                      =>     a = 2;
console.log(a); /* prints 2 */                     console.log(a);
```
```javascript
                                                  var a; 
console.log(a); /* prints "undefined" */    =>    console.log(a);
var a = 2;                                        a = 2;
```

Javascript treats `var a = 2;` as two different statements. First is the declaration of `a`, which is processed in compilation phase, and as such hoisted to the top of function (or global) scope. Second is the assigment of `a`, which is left in place for execution phase.

Both functions and `var` declarations are hoisted, but functions are hoisted first, then `var`.

```javascript
foo();                             function foo() {}
                                     console.log(2);
var foo;                           }

foo = function() {           =>    foo();  // prints 2
  console.log(1);
};

function foo() {                   foo = function() {
  console.log(2);                    console.log(1);
}                                  }
```

Who knows why would you even do that in the first place.