# this?

`this` in JS is not bound. Value of `this` is evaluated at run-time, dependent on the context.

Before we explain how it's evaluated, let's clarify what it's not:

- `this` in a function is **not** referring to the enclosing function.
- `this` is not referring to its scope.
- `this` is not an object's prototype.

that said, the rule for evaluating `this`, in ascending order of precedence are:

## Default binding

catch-all rule for evaluating `this`.

```javascript
function foo() {
  console.log(this.a);
}

var a = 2;

foo(); // 2
```

=== "exception 1: `let`/`const`"

    recall from the [scope](/languages/javascript/scope#what-is-familiar) section, the quirk of `var` declaration is that they are like pseudo-properties of the global object. A side-effect of this is when we call a function without "owner" object, `this` falls back to `globalThis`. Which means it will not work with `let`/`const`.

    ```javascript
    function foo() {
      console.log(this.a);
    }

    let a = 2;

    foo(); // undefined
    ```

=== "exception 2: strict mode"

    In `use strict` mode global object is not eligible for default binding.

    ```javascript
    function foo() {
      "use strict";

      console.log(this.a);
    }

    var a = 2;

    foo(); /* error, this undefined! */
    ```

    Ironically, strict mode of the call-site is irrelevant in whether global is eligible for default binding.

    ```javascript
    function foo() {
      console.log(this.a);
    }

    var a = 2;

    (function(){
      "use strict";

      foo();          // 2
    })();
    ```

## Implicit binding

Objects don't "own" methods, but that's how we think when we look at `foo.bar()`. Anyway, if a method is called with the "owner" object in context, `this` evaluates to the owning object.

```javascript
function foo() {
  console.log(this.a);
}

var obj = {
  a: 2,
  foo: foo
};

var a = 1;

foo();     // 1
obj.foo(); // 2, implicit binding taking precedence
```

what about nesting? In the chain `foo`.`bar`.**`tar`**.`method()` we only care for the last level `tar`:

```javascript
function foo() {
  console.log(this.a);
}

var parent = {
  a: 1,
  foo: foo
};

var grandparent = {
  a: 2,
  child: parent,
  foo: foo
};

parent.foo();            // 1
grandparent.foo();       // 2
grandparent.child.foo(); // 1
```

## Explicit binding

We can, in fact force a `this` value. 

=== "`apply`/`call` for immediately invocation"

    `call` attaches `this` to the function and immediately invokes it:

    ```javascript
    function foo(arg1) {
      console.log(this.a, arg1);
    }

    foo.call({a: 4}, "yikes");    // 42 'yikes'
    ```

    `apply` is same, but accepts params as array.

    ```javascript
    foo.apply({a: 4}, ["yikes"]); // 42 'yikes'
    ```

=== "**Hard** `bind` to call function later"
  
    creates a new `function` instance that, when called, calls the function with its `this` keyword set to provided value. 

    ```javascript
    function foo() {
      console.log(this.a);
    }

    var bar = foo.bind({ a: 4 });
    bar();     // 4

    var obj = { a: 1, bar: bar };
    obj.bar();  // 4, precedence over implicit binding
    ```

## _new_ binding

Takes the highest precedence in binding `this`:

```javascript
function foo(a) {
  this.a = a;
}

var b = new foo(2);
b.a;             /* 2 */
```

it's as if `foo` is rewritten on-fly to:

```javascript
function foo(a) {
+  const obj = {};
+  this = obj;   
   this.a = a;
+  obj.__proto__ = foo.prototype;
+  return a;
```

what happens hard binding clashes with `new` operator call?

```javascript
function foo(a) {
  this.a = a;
}

var obj = {};
var bar = foo.bind(obj);

bar(2);
obj;  // {a: 2}

var baz = new bar(3);
obj;  // {a: 2} same
baz;  // {a: 3} overtaken the hard binding
```

------

![](/assets/blank-stare-really.gif){width="32"}