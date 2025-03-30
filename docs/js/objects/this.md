# this

<style>
.md-logo img {
  content: url('/js/javascript.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/js/javascript.svg');
}
</style>

`this` in JS refers to the context in which a function is executed. Following are the bindings of `this`, in increasing order of precedence.

## 1. Standalone function

Default catch-all case of a function's context. When invoked as a standalone function, `this` is:

1. `globalThis` in non-strict mode.
2. `undefined` in strict mode.

<hr>

<div class="grid" markdown>

<div markdown>
In non-strict mode, global variables and functions are made properties of global object (`window` in browser). 
</div>

```javascript
var name = "piggy";

function greet() {
  console.log(`${this.name}`);
}

greet(); // piggy
```

<div markdown>
In strict mode, aforementioned behaviour is disabled.
</div>

```javascript
var name = "piggy";

function greet() {
  "use strict";
  console.log(`${this.name}`);
}

greet(); // TypeError: Cannot read properties of undefined
```

</div>

## 2. Implicit binding

When a function is invoked as a method (i.e. member) of an object, that object is treated as `this`.

<hr>

<div class="grid" markdown>

```javascript
let james = {
  name: "James",
  greet() {
    console.log(`${this.name}`);
  },
};

james.greet(); // James
```

Here `james` becomes the context of `greet()` call.

```javascript
function sayHi() {
  console.log(`${this.name}`);
}

let james = {
  name: "James",
  greet: sayHi,
};

james.greet(); // James
```

Doesn't matter if the function was first declared in the object or later added as a member. There is no distinction.

```javascript
let james = {
  name: "James",
  greet() {
    console.log(`${this.name}`);
  },
};

james.greet(); // James
let g = james.greet;
g(); // undefined
```

Functions and methods in JS are the same thing. There is no implied ownership.

```
function announce(callback) {
  callback()
}

james.greet();           // James
announce(james.greet);   // undefined
```

A common pitfall. We can unintentionally end up losing context.

</div>

## 3. Explicit binding

As shown, a major disadvantage of implicit binding is losing its context. That's where explicit binding comes in picture.

```javascript
function greet(age) {
  console.log(`${this.name} is ${age} years old`);
}
```

<div class="grid" markdown>

```javascript hl_lines="3"
greet.call({ name: "foo" }, 5); // 'foo is 5 years old'
```

```javascript hl_lines="3"
greet.apply({ name: "foo" }, [5]); // 'foo is 5 years old'
```

`call` invokes the function with supplied `this` and arguments provided individually.

`apply` invokes the function with supplied `this` and arguments provided in an array.

</div>

<hr>

`call`/`apply` is then combined with function closures to give explicit binding:

```javascript
function bind(func, context) {
  return function () {
    return func.apply(context, arguments);
  };
}

function greet() {
  console.log(`${this.name}`);
}

let j = bind(greet, { name: "james" });
j(); // james

j.call({ name: "games" }); // james
```

This pattern has been standardized in ES5 as `Function.prototype.bind`. One thing to note: `null` and `undefined` is ignored as context and JS fallsback to standalone function call.

## 4. new operator

[As discussed previously](basics.md#2-with-new-operator), there is no such thing as constructor in JS. Instead, there is a constructor operator called by prefixing `new` to a function call.

`new` hijacks the behaviour of the function, implicitly creating a new object and binding it as `this`.

<div class="grid" markdown>

```javascript
var name = "piggy";

function greet() {
  console.log(`${this.name}`);
}

greet(); // piggy
```

```javascript
var name = "piggy";

function greet() {
  // this = {}
  // this.__proto__ = greet.prototype
  console.log(`${this.name}`);
  // return this;
}

new greet(); // undefined
```

a normal function call.

function call hijacked by constructor operator.

</div>

## Rules

Combining all four of these rules in the order of precedence gets us:

1. `new func()`? newly constructed object is `this`.
2. `call` / `apply` / `bind`? Passed in object is `this`.
3. `context.func()`? Use `context` as `this`.
4. `func()` in strict mode? `this` is `undefined`.
5. `func()` in non-strict mode? `this` is `globalThis`.

<hr>

## Arrow function

The arrow-functions capture `this` from surrounding scope and it cannot be overridden, even with `new`.

```javascript
var name = "james";

function greet() {
  // this: depends on call site.
  console.log(`${this.name}`);
}

let meet = () => {
  // this: inherited and stickied from enclosing scope.
  console.log(`${this.name}`);
};

greet(); // james
greet.call({ name: "games" }); // games
meet.call({ name: "games" }); // james
```

See another example below. Even with an arrow-function you can end up having call-site dependent `this` if the surrounding scope is an old school function.

```javascript
var name = "james";

function foo() {
  // this: depends on call site
  let bar = () => {
    // this: inherited and stickied from enclosing scope.
    //     : ends up depending on call site.
    console.log(`${this.name}`);
  };
  bar();
}

foo(); // 'james'
foo.call({ name: "games" }); // 'games'
```
