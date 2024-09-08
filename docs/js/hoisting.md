# var, hoisting, global

<style>
.md-logo img {
  content: url('/js/javascript.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/js/javascript.svg');
}
</style>

## Hoisting

The following two snippets are equivalent.

<div class="grid" markdown>

```javascript linenums="1"
function foo() {
  name = "oink";
  console.log(name); // 'oink'
  var name;
} 
```

```javascript linenums="1"
function foo() {
  var name;
  name = "oink";
  console.log(name); // 'oink'
} 
```

</div>

Note that only declarations are hoisted, not the accompanying assignments.

```javascript
function foo() {
  console.log(name); // undefined
  var name = "oink";
}
```

JS will hoist even functions, and in fact hoist them before `var`s.

```javascript
foo(); // 1

function foo() { return 1; }
var foo = function() { return 2; }
```

## let vs var

[MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let)

`let` | `var`
------|-------
scoped to blocks | scoped to functions
can only be accessed after declaration | declarations are hoisted, so can be accessed anytime
does no create properties in `globalThis` | global `var` and functions become properties of `globalThis`
cannot be redeclared | redeclarations are ignored and any new value is picked up

## globalThis

Global object is what hosts global variables and functions. In browser it's `window` and in node it's `global`. `globalThis` is a recent standardization.

```javascript
> globalThis
<ref *1> Object [global] {
  global: [Circular *1],
  clearImmediate: [Function: clearImmediate],
  setImmediate: [Function: setImmediate] {
    [Symbol(nodejs.util.promisify.custom)]: [Getter]
  },
  clearInterval: [Function: clearInterval],
  clearTimeout: [Function: clearTimeout],
  setInterval: [Function: setInterval],
  setTimeout: [Function: setTimeout] {
    [Symbol(nodejs.util.promisify.custom)]: [Getter]
  },
  queueMicrotask: [Function: queueMicrotask],
  structuredClone: [Function: structuredClone],
  atob: [Getter/Setter],
  btoa: [Getter/Setter],
  performance: [Getter/Setter],
  fetch: [Function: fetch],
  crypto: [Getter],
}
```
