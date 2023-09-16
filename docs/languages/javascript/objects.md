# Objects ![](/assets/facepalm-really.gif){width="32"}

Object in JS are unordered collection of _properties_. Properties have a name and a value, with names being strings (or Symbols).

There are three ways to create an object:

**1/ with object literal**

```javascript
const person = {
  name: ["bob", "burger"];
  age: 40,
  bio() {  // alternatively, bio: function() {...}
    console.log(`Welcome to ${this.name[0]}'s ${this.name[1]}`);
  }
}
```

**2/ with `new`**

Object literals are seriously inadequate when we need to create more than one object with same "shape". As a solution, we can wrap the boilerplate in a function:

```javascript
function createPerson(name) {
  const obj = {};
  obj.name = name;
  obj.bio = function() {...}
  return obj;
}

var person = createPerson("bob");
```

Still a bit verbose. That's what `new` keyword fixes Prefixing `new` in front of a function invocation changes its behaviour. It:

1. creates a new object.
2. binds `this` to the newly created object.
3. implicitly returns the newly created object.

The previous block is equivalent to this:

```
function Person(name) {  // only a convention
  this.name = name;
  this.bio = function() {...}
}

var person = new Person("bob");
```

??? question "btw, what happens when we invoke a normal function with `new`?" 

    Its return value gets hijacked:

    ```javascript
    function foo() {
      return 2;
    }

    var a = foo();     // 2
    var b = new foo(); // {}
    ```

**3/ with `Object.create`

Takes the first argument as the created object's prototype.

```javascript
let a = Object.create({x: 1, y: 2});     // a delegates properties x and y
a.x + a.y                                // => 3

let b = Object.create(null);             // has no prototype, not even toString().
let c = Object.create(Object.prototype); // equivalent to c = {};
```

## Wait, what is `prototype`

Most other languages have a _template_ model for OOP. _Classes_ act as the blueprint from which you can concrete instances, known as objects.

Javascript follows the _delegate_ model for OOP. Objects delegate properties and behaviour to their parent objects, using _prototype_ mechanism.

- Every object in JS has a built-in property, known as its prototype. 
- Prototype is a link (not a copy) to another object, which has its own prototype link and so on.
- It all terminates at `Object.prototype` as the root prototype of all chains and `null` as its own prototype.
- `Object.prototype` provides the following methods to all objects:
    ```
    __defineGetter__
    __defineSetter__
    __lookupGetter__
    __lookupSetter__
    __proto__
    constructor
    hasOwnProperty
    isPrototypeOf
    propertyIsEnumerable
    toLocaleString
    toString
    valueOf
    ```
- When a method or property is looked up for an object, if not found, the engine will walk that object's prototype chain in search of it.
- Use `Object.hasOwn(foo, "bar")` or `foo.hasOwnProperty("bar")` to see if a property actually belongs to an object or is being delegated to its prototype [^1].
- Property of objects that points to its prototype is not `prototype`. The name is actually not standard, but is `__proto__` by convention. You can look it with `Object.getPrototypeOf(foobar)`.


[^1]: `hasOwn` is recommended over `hasOwnProperty`. That's because `hasOwnProperty()` will be absent for an object if it's created with `Object.create(null)`. Also, `hasOwnProperty()` can be shadowed by an object. See [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/hasOwn#description).

**Back to `new`**

```javascript
function foo() {
  // literally nothing
}

var a = new foo();
Object.getPropertyOf(b); // {constructor: f}
```

There is some tomfoolery happening here that'll confuse any newcomer. Basically anytime a function is declared, function being a subclass of object get a prototype of its own, accessible as `functionName.prototype`. When a function is hijacked by `new` operator, this `functionName.prototype` becomes the new object's prototype. Let's demo this below:

```javascript
var a = {};
a.__proto__ === Object.prototype;             // so far all good.

function foo() {
  // literally nothing
}
foo.prototype;                                // {constructor: f}.
foo.prototype.constructor === foo             // true
foo.prototype.prototype                       // undefined. cringe, as Gen-Z would say.
foo.prototype.__proto__ === Object.prototype  // true

var b = new foo();
b.__proto__;                                  // Foo.prototype
```

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 482.29947798502633 450.8571319580078" width="482.29947798502633" height="450.8571319580078">
  <g stroke-linecap="round" transform="translate(245.00015258789062 10) rotate(0 104.57145690917969 85.7142562866211)"><path d="M32 0 M32 0 C66.81 0.86, 102.33 -2.34, 177.14 0 M32 0 C84.33 -1.46, 135.29 -0.64, 177.14 0 M177.14 0 C196.53 1.15, 209.96 11.31, 209.14 32 M177.14 0 C197.96 1.42, 210.14 10.63, 209.14 32 M209.14 32 C209.17 65.28, 210.65 100.89, 209.14 139.43 M209.14 32 C208.44 63.65, 209.77 93.47, 209.14 139.43 M209.14 139.43 C210.88 161.07, 198.45 170.34, 177.14 171.43 M209.14 139.43 C210.89 160.74, 198.03 170.1, 177.14 171.43 M177.14 171.43 C127.43 170.36, 83.25 172.22, 32 171.43 M177.14 171.43 C134.87 172, 91.38 172.78, 32 171.43 M32 171.43 C12.35 171.12, 1.34 160.29, 0 139.43 M32 171.43 C8.57 169.48, -1.37 159.44, 0 139.43 M0 139.43 C-2.55 109.82, 1.19 82.07, 0 32 M0 139.43 C1.12 107.38, 1.1 75.99, 0 32 M0 32 C0.62 9.43, 9.46 0.68, 32 0 M0 32 C0.96 9.33, 12.33 0.95, 32 0" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(266.7143859863281 18.5714111328125) rotate(0 81.19991302490234 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">Object.prototype</text></g><g stroke-linecap="round"><g transform="translate(246.14300537109375 51.14280700683594) rotate(0 104.14432972520592 -0.43604265724309244)"><path d="M-0.84 -0.98 C34.08 -1.05, 174.13 -0.02, 209.13 -0.11 M0.92 1.12 C35.82 0.65, 174.1 -1.69, 208.77 -1.99" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(255.85723876953125 57.99995422363281) rotate(0 56.79994201660156 50)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">constructor</text><text x="0" y="25" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">toString</text><text x="0" y="50" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">valueOf</text><text x="0" y="75" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">...</text></g><g stroke-linecap="round" transform="translate(250.71435546875 224.28578186035156) rotate(0 109.42857360839844 45.71427917480469)"><path d="M22.86 0 M22.86 0 C60.55 -0.3, 97.27 -1.96, 196 0 M22.86 0 C79.33 0.72, 133.98 -0.36, 196 0 M196 0 C211.16 1.43, 218.83 7.12, 218.86 22.86 M196 0 C209.68 2.1, 217.49 6.97, 218.86 22.86 M218.86 22.86 C218.52 34.79, 219.21 49.08, 218.86 68.57 M218.86 22.86 C218.9 35.17, 218.56 46.45, 218.86 68.57 M218.86 68.57 C217.08 82.81, 210.23 89.97, 196 91.43 M218.86 68.57 C220.16 85, 211.99 92.92, 196 91.43 M196 91.43 C159.68 92.05, 122.52 92.34, 22.86 91.43 M196 91.43 C154.26 90.43, 111.15 89.59, 22.86 91.43 M22.86 91.43 C6.74 90.76, 1.67 83.4, 0 68.57 M22.86 91.43 C5.78 92.69, 1.36 83.43, 0 68.57 M0 68.57 C-0.87 59.49, 1.69 46.59, 0 22.86 M0 68.57 C-0.17 56.9, -0.5 45.04, 0 22.86 M0 22.86 C0.34 9.25, 7.05 -1.95, 22.86 0 M0 22.86 C2.07 6.87, 9.84 -0.46, 22.86 0" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(263.28582763671875 236.85716247558594) rotate(0 59.219940185546875 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">function foo</text></g><g stroke-linecap="round"><g transform="translate(250.14297485351562 265.4285430908203) rotate(0 110.82166401943658 -0.3241207063058198)"><path d="M-0.51 -1.07 C36.3 -1.32, 183.02 -1.56, 219.83 -1.62 M1.42 0.98 C38.71 0.95, 185.81 0.13, 222.16 -0.04" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g transform="translate(265.0001220703125 276.8571014404297) rotate(0 56.79994201660156 12.5)"><text x="0" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="start" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">constructor</text></g><g stroke-linecap="round" transform="translate(255.28582763671875 372.28578186035156) rotate(0 107.42857360839844 34.285675048828125)"><path d="M17.14 0 M17.14 0 C86.43 1.27, 160.4 2.54, 197.71 0 M17.14 0 C79.62 -0.09, 141.2 -0.2, 197.71 0 M197.71 0 C209.53 0.51, 213.88 6.02, 214.86 17.14 M197.71 0 C208.28 -1.94, 215.99 4.44, 214.86 17.14 M214.86 17.14 C214.22 24.73, 215.41 33.45, 214.86 51.43 M214.86 17.14 C213.71 28.83, 214.89 39.51, 214.86 51.43 M214.86 51.43 C213.46 63.71, 210.8 70.43, 197.71 68.57 M214.86 51.43 C213.29 64.39, 210.54 69.72, 197.71 68.57 M197.71 68.57 C150.97 69.05, 104.77 67.98, 17.14 68.57 M197.71 68.57 C151.67 68, 105.44 68.65, 17.14 68.57 M17.14 68.57 C7.12 69.17, 1.99 60.92, 0 51.43 M17.14 68.57 C6.21 67.47, 1.62 64.43, 0 51.43 M0 51.43 C-1.89 42.65, -0.69 31.56, 0 17.14 M0 51.43 C0.03 39.3, 0.12 27.79, 0 17.14 M0 17.14 C0.62 6.28, 5.77 1.65, 17.14 0 M0 17.14 C-1.59 3.8, 4.82 -0.79, 17.14 0" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(357.63440704345703 394.0714569091797) rotate(0 5.079994201660156 12.5)"><text x="5.079994201660156" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">b</text></g><g stroke-linecap="round"><g transform="translate(359.788571399986 368.8571319580078) rotate(0 -1.0725036746852936 -20.846119752959368)"><path d="M0.9 0.99 C0.36 -5.88, -1.63 -33.89, -2.1 -40.76 M-0.09 0.46 C-0.88 -6.82, -2.62 -35.59, -3.04 -42.68" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(359.788571399986 368.8571319580078) rotate(0 -1.0725036746852936 -20.846119752959368)"><path d="M6.82 -23.77 C2.51 -30.85, 0.18 -37.86, -3.13 -44.3 M5.05 -22.82 C3.08 -28.58, 0.52 -34.49, -3.48 -43.06" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(359.788571399986 368.8571319580078) rotate(0 -1.0725036746852936 -20.846119752959368)"><path d="M-7.25 -22.92 C-6.04 -30.44, -2.87 -37.78, -3.13 -44.3 M-9.02 -21.96 C-6.74 -27.94, -5.03 -34.11, -3.48 -43.06" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(351.8989373372691 216.2857513427735) rotate(0 -0.2916309702002593 -15.729579935967962)"><path d="M0.78 0.85 C0.6 -4.72, -0.28 -26.78, -0.5 -32.31 M-0.28 0.25 C-0.64 -4.68, -1.2 -25.95, -1.36 -31.24" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(351.8989373372691 216.2857513427735) rotate(0 -0.2916309702002593 -15.729579935967962)"><path d="M5.55 -16.41 C1.14 -21.45, -0.86 -26.39, -0.97 -30.04 M3.88 -16.7 C2.2 -20.78, 0.15 -25.73, -0.78 -31.1" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(351.8989373372691 216.2857513427735) rotate(0 -0.2916309702002593 -15.729579935967962)"><path d="M-5.2 -16.1 C-5.9 -21.32, -4.19 -26.37, -0.97 -30.04 M-6.87 -16.39 C-5.04 -20.52, -3.58 -25.57, -0.78 -31.1" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(10 229.57142639160156) rotate(0 107.42857360839844 34.285675048828125)"><path d="M17.14 0 M17.14 0 C75.06 0.03, 134.85 0.21, 197.71 0 M17.14 0 C55.35 -2.39, 94.22 -1.19, 197.71 0 M197.71 0 C209.5 1.11, 216.13 5.37, 214.86 17.14 M197.71 0 C210.95 -2.18, 213.53 5.58, 214.86 17.14 M214.86 17.14 C215.63 25.96, 213.78 36.56, 214.86 51.43 M214.86 17.14 C214.1 26.74, 215.57 37.9, 214.86 51.43 M214.86 51.43 C213.91 62.14, 209.69 66.95, 197.71 68.57 M214.86 51.43 C216.75 65.14, 208.24 67.88, 197.71 68.57 M197.71 68.57 C156.1 67.85, 113.53 70.89, 17.14 68.57 M197.71 68.57 C136.63 69.73, 74.03 70.03, 17.14 68.57 M17.14 68.57 C5.3 68.36, -1.93 60.98, 0 51.43 M17.14 68.57 C3.96 68.42, -2.11 61.65, 0 51.43 M0 51.43 C0.99 41.28, -1.65 33.65, 0 17.14 M0 51.43 C0.68 41.44, 1.14 32.94, 0 17.14 M0 17.14 C-0.48 5.63, 4.83 0.61, 17.14 0 M0 17.14 C-1.4 5.9, 7.6 -0.16, 17.14 0" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(110.75857543945312 251.3571014404297) rotate(0 6.6699981689453125 12.5)"><text x="6.6699981689453125" y="0" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-typeset-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="text-before-edge">a</text></g><g stroke-linecap="round"><g transform="translate(114.67868041992188 218.57142639160156) rotate(0 61.02011701017618 -42.85159974484239)"><path d="M-0.57 0.45 C3.71 -11.51, 5.3 -56.87, 25.83 -70.96 C46.36 -85.04, 106.56 -81.88, 122.61 -84.08 M1.33 -0.35 C5.49 -12.2, 5.13 -55.17, 25.24 -69.47 C45.36 -83.77, 105.84 -83.94, 122.02 -86.16" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(114.67868041992188 218.57142639160156) rotate(0 61.02011701017618 -42.85159974484239)"><path d="M95.46 -72.6 C103.02 -76.97, 112.58 -81.67, 122.78 -85.18 M95.23 -74.25 C103.42 -77.55, 112.63 -82.25, 121.47 -86.17" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g><g transform="translate(114.67868041992188 218.57142639160156) rotate(0 61.02011701017618 -42.85159974484239)"><path d="M93.88 -93.06 C102.08 -91, 112.13 -89.29, 122.78 -85.18 M93.64 -94.71 C102.49 -91.61, 112.19 -89.91, 121.47 -86.17" stroke="var(--md-typeset-color)" stroke-width="1" fill="none"></path></g></g><mask></mask></svg>