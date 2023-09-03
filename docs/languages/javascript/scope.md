# Scope

**Javascript has function-based scopes.**

```javascript
var foo = true; 

if (foo) {
  var bar = foo * 2;  // fake scope! a poser!
}
```

## IIFE

A side-effect of requiring functions for scopes in old JS was the _immediately invoked function expression_ pattern, to hide declarations.

Wrapping with `(..)` turns the function declaration into a function expression. The enclosing scope (global) doesn't know what `foo` is. It's only known inside the `...`.

```javascript
(function foo() {     
  console.log(foo);   // [function]
})();

console.log(foo);     // undefined
```

While it's possible, and often encouraged to drop the function name `foo` as well, it has many drawbacks:

1. no useful name to display in stack trace.
2. cannot refer to itself for recursion.
3. goes against self-documenting code.

## Block scoping 

ES6 introduced block scoping with the new `let` and `const` keywords. Before this ES3 speced that `catch` had its own scope too.

## Hoisting

All declarations, both variables and functions are processed first, before any code execution.

```javascript
a = 2;                  var a;   
var a;             =>   a = 2;
console.log(a);         console.log(a); // prints 2;
```

another

```javascript
console.log(a);         var a;
var a = 2;         =>   console.log(a); // prints 'undefined'
                        a = 2;         
```

- only declarations themselves are hoisted, while keeping the assigment and executions left _in place_.


```javascript
                                                   
foo();   /* TypeError! foo is not a function */    var foo;
var foo = function {...}   =>                      foo();   // attempting to call 'undefined'
                                                   foo = function() {...}
```

- hoisting is _per-scope_.
- functions are hoisted first, then variables.

## Closure

> When a function is able to remember its lexical scope, even executing outside of said scope, that's closure.

```javascript
for (var i = 1; i <= 5; i++) {
 setTimeout(function(){
  console.log(i);
 }, i * 1000);
}
```

one would expect this code to print out `1, 2, ..., 5` one at a time, per second. However, it prints `6` five times at one-second interval. That's the anonymous functino _closure_ over variable _`i`_, which is set to `6` by the time first timeout executes.

switch to `let`, which is:

1. block-scoped, that way each anonymous function gets a separate `i`.
2. has special behaviour set for `for` loop, where it's declared not just once, but for each iteration.

Wow...welcome to the sane languages club JS (circa 2015). You still have a long way to go.