# Object type

## Basics

An object is a collection of properties and methods.

```javascript title="Object literal" linenums="1"
const person = {
  name: "Foo",
  age: 38,
  about() {
    console.log(`Hi! It's me, ${this.name}`);
  }
};

// members can be added later too.
person.adios = function() { /* ... */ }
```

## Prototypes

Every object in JS has a built-in property called its ==prototype==, which itself is an object, making a _prototype chain_ until the very last ancestor with a `null` prototype. Most browser use [`__proto__`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/proto), but it's recommended to use `Object.getPrototypeOf(person)`.

When attempting to access a property/method on an object, JS will first look it up on the target object, followed by recursively looking for it on its prototype. The root prototype of all objects is `Object.prototype`.

```javascript linenums="1"
// Not really blank. It'll be an object with default methods like 
// "constructor", "isPrototypeOf", valueOf, __defineGetter__, etc.
Object.getPrototypeOf(person)                                         // {}
Object.getPrototypeOf({}) === Object.getPrototypeOf(person)           // true
Object.getPrototypeOf({}) === Object.getPrototypeOf(Object.prototype) // true 

// Prototype of a date instance for example: Date.prototype
const today = new Date();
Object.getPrototypeOf(today)     // { toISOString: f, toUTCString: f, ... }
```

In JS, all functions have a property named `prototype`. When called as a constructor (i.e. with `new` operator), the constructed object inherits this property as its `prototype`.

```javascript linenums="1"
function hello() {}
hello.prototype // {}, a blank object as prototype to all constructed "hello"s.
Object.getPrototypeOf(hello.prototype) === Object.prototype // true 
```

<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500.5999755859374 427.19989013671875" height="300">
  <g stroke-linecap="round" transform="translate(352.3999328613281 372.39990234375) rotate(0 47.199981689453125 22.399993896484375)"><path d="M11.2 0 C29.84 0, 48.49 0, 83.2 0 M11.2 0 C32.88 0, 54.56 0, 83.2 0 M83.2 0 C90.67 0, 94.4 3.73, 94.4 11.2 M83.2 0 C90.67 0, 94.4 3.73, 94.4 11.2 M94.4 11.2 C94.4 17.44, 94.4 23.67, 94.4 33.6 M94.4 11.2 C94.4 19.84, 94.4 28.48, 94.4 33.6 M94.4 33.6 C94.4 41.07, 90.67 44.8, 83.2 44.8 M94.4 33.6 C94.4 41.07, 90.67 44.8, 83.2 44.8 M83.2 44.8 C56.02 44.8, 28.84 44.8, 11.2 44.8 M83.2 44.8 C62.65 44.8, 42.1 44.8, 11.2 44.8 M11.2 44.8 C3.73 44.8, 0 41.07, 0 33.6 M11.2 44.8 C3.73 44.8, 0 41.07, 0 33.6 M0 33.6 C0 28.67, 0 23.73, 0 11.2 M0 33.6 C0 28.7, 0 23.8, 0 11.2 M0 11.2 C0 3.73, 3.73 0, 11.2 0 M0 11.2 C0 3.73, 3.73 0, 11.2 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(371.3599395751953 382.2998962402344) rotate(0 28.239974975585938 12.5)"><text x="28.239974975585938" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">today</text></g><g stroke-linecap="round" transform="translate(313.79998779296875 264.7999572753906) rotate(0 88.39999389648432 30)"><path d="M15 0 C58.39 0, 101.78 0, 161.8 0 M15 0 C63.01 0, 111.02 0, 161.8 0 M161.8 0 C171.8 0, 176.8 5, 176.8 15 M161.8 0 C171.8 0, 176.8 5, 176.8 15 M176.8 15 C176.8 23.72, 176.8 32.44, 176.8 45 M176.8 15 C176.8 21.98, 176.8 28.97, 176.8 45 M176.8 45 C176.8 55, 171.8 60, 161.8 60 M176.8 45 C176.8 55, 171.8 60, 161.8 60 M161.8 60 C106.85 60, 51.9 60, 15 60 M161.8 60 C120.76 60, 79.72 60, 15 60 M15 60 C5 60, 0 55, 0 45 M15 60 C5 60, 0 55, 0 45 M0 45 C0 37.87, 0 30.75, 0 15 M0 45 C0 37.38, 0 29.75, 0 15 M0 15 C0 5, 5 0, 15 0 M0 15 C0 5, 5 0, 15 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(327.17005920410156 282.2999572753906) rotate(0 75.02992248535156 12.5)"><text x="75.02992248535156" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Date.prototype</text></g><g stroke-linecap="round" transform="translate(103.19989013671875 132.00003051757812) rotate(0 91.5999755859375 30)"><path d="M15 0 C64.55 0, 114.11 0, 168.2 0 M15 0 C50.07 0, 85.15 0, 168.2 0 M168.2 0 C178.2 0, 183.2 5, 183.2 15 M168.2 0 C178.2 0, 183.2 5, 183.2 15 M183.2 15 C183.2 26.18, 183.2 37.35, 183.2 45 M183.2 15 C183.2 21.68, 183.2 28.36, 183.2 45 M183.2 45 C183.2 55, 178.2 60, 168.2 60 M183.2 45 C183.2 55, 178.2 60, 168.2 60 M168.2 60 C114.46 60, 60.71 60, 15 60 M168.2 60 C129.67 60, 91.13 60, 15 60 M15 60 C5 60, 0 55, 0 45 M15 60 C5 60, 0 55, 0 45 M0 45 C0 38.19, 0 31.38, 0 15 M0 45 C0 34.37, 0 23.75, 0 15 M0 15 C0 5, 5 0, 15 0 M0 15 C0 5, 5 0, 15 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(113.5999526977539 149.50003051757812) rotate(0 81.19991302490234 12.5)"><text x="81.19991302490234" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Object.prototype</text></g><g stroke-linecap="round"><g transform="translate(403.41298847945404 367.59991455078125) rotate(0 -0.1992664285058936 -18.39996337890625)"><path d="M0 0 C-0.07 -6.13, -0.33 -30.67, -0.4 -36.8 M0 0 C-0.07 -6.13, -0.33 -30.67, -0.4 -36.8" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(403.41298847945404 367.59991455078125) rotate(0 -0.1992664285058936 -18.39996337890625)"><path d="M6.08 -19.58 C3.89 -25.41, 1.7 -31.23, -0.4 -36.8 M6.08 -19.58 C4.74 -23.15, 3.39 -26.73, -0.4 -36.8" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(403.41298847945404 367.59991455078125) rotate(0 -0.1992664285058936 -18.39996337890625)"><path d="M-6.5 -19.44 C-4.44 -25.32, -2.37 -31.19, -0.4 -36.8 M-6.5 -19.44 C-5.24 -23.05, -3.97 -26.65, -0.4 -36.8" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(347.1091351757876 258.8000183105469) rotate(0 -43.591422440068925 -28)"><path d="M0 0 C-14.53 -9.33, -72.65 -46.67, -87.18 -56 M0 0 C-14.53 -9.33, -72.65 -46.67, -87.18 -56" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(347.1091351757876 258.8000183105469) rotate(0 -43.591422440068925 -28)"><path d="M-62.8 -50.5 C-72.48 -52.68, -82.17 -54.87, -87.18 -56 M-62.8 -50.5 C-69.02 -51.9, -75.23 -53.3, -87.18 -56" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(347.1091351757876 258.8000183105469) rotate(0 -43.591422440068925 -28)"><path d="M-72.04 -36.11 C-78.05 -44.01, -84.07 -51.91, -87.18 -56 M-72.04 -36.11 C-75.9 -41.18, -79.76 -46.25, -87.18 -56" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(105.00006103515625 264.39990234375) rotate(0 88.39999389648432 30)"><path d="M15 0 C70.76 0, 126.53 0, 161.8 0 M15 0 C72.59 0, 130.17 0, 161.8 0 M161.8 0 C171.8 0, 176.8 5, 176.8 15 M161.8 0 C171.8 0, 176.8 5, 176.8 15 M176.8 15 C176.8 26.92, 176.8 38.85, 176.8 45 M176.8 15 C176.8 21.34, 176.8 27.67, 176.8 45 M176.8 45 C176.8 55, 171.8 60, 161.8 60 M176.8 45 C176.8 55, 171.8 60, 161.8 60 M161.8 60 C117.29 60, 72.78 60, 15 60 M161.8 60 C104.05 60, 46.3 60, 15 60 M15 60 C5 60, 0 55, 0 45 M15 60 C5 60, 0 55, 0 45 M0 45 C0 36.11, 0 27.21, 0 15 M0 45 C0 34.41, 0 23.83, 0 15 M0 15 C0 5, 5 0, 15 0 M0 15 C0 5, 5 0, 15 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(122.75013732910156 281.89990234375) rotate(0 70.64991760253906 12.5)"><text x="70.64991760253906" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">hello.prototype</text></g><g stroke-linecap="round" transform="translate(10 263.79998779296875) rotate(0 31.999969482421818 30)"><path d="M15 0 C28.3 0, 41.6 0, 49 0 M15 0 C23.8 0, 32.61 0, 49 0 M49 0 C59 0, 64 5, 64 15 M49 0 C59 0, 64 5, 64 15 M64 15 C64 24.91, 64 34.83, 64 45 M64 15 C64 23.94, 64 32.87, 64 45 M64 45 C64 55, 59 60, 49 60 M64 45 C64 55, 59 60, 49 60 M49 60 C37.94 60, 26.88 60, 15 60 M49 60 C37.98 60, 26.95 60, 15 60 M15 60 C5 60, 0 55, 0 45 M15 60 C5 60, 0 55, 0 45 M0 45 C0 33.16, 0 21.32, 0 15 M0 45 C0 34.54, 0 24.08, 0 15 M0 15 C0 5, 5 0, 15 0 M0 15 C0 5, 5 0, 15 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(31.3099746704101 281.29998779296875) rotate(0 10.689994812011719 12.5)"><text x="10.689994812011719" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">{}</text></g><g stroke-linecap="round"><g transform="translate(51.157049593541785 255.60003662109375) rotate(0 41.58380364553997 -28.000015258789034)"><path d="M0 0 C13.86 -9.33, 69.31 -46.67, 83.17 -56 M0 0 C13.86 -9.33, 69.31 -46.67, 83.17 -56" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(51.157049593541785 255.60003662109375) rotate(0 41.58380364553997 -28.000015258789034)"><path d="M68.46 -35.79 C73.83 -43.18, 79.21 -50.56, 83.17 -56 M68.46 -35.79 C73.53 -42.76, 78.6 -49.73, 83.17 -56" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(51.157049593541785 255.60003662109375) rotate(0 41.58380364553997 -28.000015258789034)"><path d="M58.91 -49.97 C67.77 -52.18, 76.64 -54.38, 83.17 -56 M58.91 -49.97 C67.27 -52.05, 75.64 -54.13, 83.17 -56" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(192.39993286132812 254.79998779296875) rotate(0 0 -26.399993896484375)"><path d="M0 0 C0 -8.8, 0 -44, 0 -52.8 M0 0 C0 -8.8, 0 -44, 0 -52.8" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(192.39993286132812 254.79998779296875) rotate(0 0 -26.399993896484375)"><path d="M8.55 -29.31 C5.56 -37.51, 2.58 -45.71, 0 -52.8 M8.55 -29.31 C5.25 -38.38, 1.95 -47.45, 0 -52.8" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(192.39993286132812 254.79998779296875) rotate(0 0 -26.399993896484375)"><path d="M-8.55 -29.31 C-5.56 -37.51, -2.58 -45.71, 0 -52.8 M-8.55 -29.31 C-5.25 -38.38, -1.95 -47.45, 0 -52.8" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(158.7999267578125 10) rotate(0 31.999969482421818 30)"><path d="M15 0 C25.87 0, 36.74 0, 49 0 M15 0 C22.46 0, 29.91 0, 49 0 M49 0 C59 0, 64 5, 64 15 M49 0 C59 0, 64 5, 64 15 M64 15 C64 24.72, 64 34.44, 64 45 M64 15 C64 26.84, 64 38.69, 64 45 M64 45 C64 55, 59 60, 49 60 M64 45 C64 55, 59 60, 49 60 M49 60 C39.55 60, 30.11 60, 15 60 M49 60 C38.95 60, 28.91 60, 15 60 M15 60 C5 60, 0 55, 0 45 M15 60 C5 60, 0 55, 0 45 M0 45 C0 35.73, 0 26.46, 0 15 M0 45 C0 37.42, 0 29.85, 0 15 M0 15 C0 5, 5 0, 15 0 M0 15 C0 5, 5 0, 15 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(175.18991088867188 27.5) rotate(0 15.6099853515625 12.5)"><text x="15.6099853515625" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">null</text></g><g stroke-linecap="round"><g transform="translate(192.81306320539898 126) rotate(0 0.2666101017297251 -23.600006103515625)"><path d="M0 0 C0.09 -7.87, 0.44 -39.33, 0.53 -47.2 M0 0 C0.09 -7.87, 0.44 -39.33, 0.53 -47.2" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(192.81306320539898 126) rotate(0 0.2666101017297251 -23.600006103515625)"><path d="M8.35 -24.93 C6.4 -30.48, 4.45 -36.04, 0.53 -47.2 M8.35 -24.93 C6.48 -30.28, 4.6 -35.63, 0.53 -47.2" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(192.81306320539898 126) rotate(0 0.2666101017297251 -23.600006103515625)"><path d="M-7.79 -25.11 C-5.71 -30.62, -3.64 -36.13, 0.53 -47.2 M-7.79 -25.11 C-5.79 -30.42, -3.79 -35.72, 0.53 -47.2" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>


## OOP: classic vs JS

Unlike typical OOP languages, classes and objects are not distinct constructs. Objects are often created w/o any separate class definition, either as just object literal or a constructor function.

Constructor provide something like a class declaration to define the blueprint of the objects, and prototype allow implementing _inheritance_. 

In classic OOP languages, subclass instance is a singular object with methods from owne and parent classes. But in JS, it's essentially delegation. "Subclass" object doesn't actually have the method of "superclass", instead they reside in *superclass*'s prototype.

## Constructor

```javascript title="Class declaration using constructor" linenums="1"
function User(name) {
  // this = {}; (implict)

  this.name = name;
  this.hi = function() {
    console.log(`Hi, it's a me, ${this.name}`);
  };

  // return this; (implict)
};

const bob = new User("Shepherd");
```

## Common utils

### `Object.assign`

Copy enumerable _own properties_ from one or more source objects to a target object.

```javascript linenums="1"
Object.assign(target, source1, source2, ...);

const source = { greet() { console.log("hi"); } };

Object.assign(Date.prototype, source); // Yes, we can do this!
(new Date()).greet();                  // prints "hi"
```

### `Object.hasOwn`

You can find native members of an object using two different ways:

```javascript linenums="1"
Object.hasOwn(person, "name"); // true, recommended
person.hasOwnProperty("name"); // true
```

==`hasOwn` is recommended because `hasOwnProperty` is not protected from being overridden.==

## Sources

- [MDN](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects)