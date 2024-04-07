# Basics

An object is a composite value: an unordered collection of properties, each with a name and a value. Property names are typically *strings*, but can also be *symbols*.

Object creation comes in two forms: literal and constructed form.

## Object literal

```javascript linenums="1"
const user = {
  name: "Foo",
  age: 42
};

user.name; // 'Foo'
user.age; // 42

// leaves user = { name: 'Foo' }
delete user.age; // true

user['name']; // 'Foo'
```

keys can be computed as well:

```javascript linenums="1"
let key = "umm";

const user = {
  "foo bar": 123,
  [key + ' hey']: 456
};
```

If property name and value are the same, we can use the shorthand notation:

```javascript linenums="1"
const user = {
  name,  // name: name
  age,   // age : age
  patron: 'zeus'
}
```

## Object constructor

`{}` syntax is good enough for one-off objects, but how do we create blueprint for a set of objects, all belonging to same *"class"*?

For this we use *constructor calls*. When a function in JS is invoked with `new` operator, JS hijacks its behaviour so:

```javascript linenums="1"
function User(name) {
  // this = {};       # implicit
  this.name = name;
  greet() {
    console.log(`hi ${this.name}`);
  }
  // return this;     # implicit
}

const user = new User("foo"); // { name: 'foo' }
```

??? "What about return statement"

    If the function being called has a return statement, it's ignored for primitive return, but not for object.

    <div class="grid" markdown>
    
    ```javascript linenums="1"
    function User(name){ 
      this.name = name; 
      return 5; 
    }

    new User('foo'); // User {name: 'foo'}
    ```

    ```javascript linenums="1"
    function User(name){ 
      this.name = name; 
      return { oink: 'oink' }; 
    }

    new User('foo'); // { oink: 'oink }
    ```
    
    </div>

There are built-in constructor for object, arrays, dates, and *boxed* primtives:

```javascript linenums="1"
const o = new Object(); // same as {}.
const a = new Array();  // same as [].
```

## Prototypes

Constructor calls do more than just help out with boilerplate. They spit out objects which all point to same *prototype*. What is that?

??? "JS vs. classic OOP"

    In every other OOP language one works with classes which are object blueprints. Objects are instances of classes. A class `C` which subclasses another `P` inherits its methods.

    JS doesn't work this way. For one, there was\* no construct for classes, just objects. Secondly, inheritance worked via delegation. Object `C` would inherit functionality of parent `P` through a link called *prototype*. 

Each object in JS has a built-in property, called its **prototype**. Prototype itself is an object, which means it itself has its own prototype, making a *prototype chain*. This chain ends at `Object.prototype` which has `null` prototype:

<div class="grid" markdown>

  ```javascript linenums="1"
  const o = {};
  // __proto__ is a legacy feature, is not recommended.
  o.__proto__;                             // Object.prototype
  Object.getPrototypeOf(o);                // Object.prototype
  Object.getPrototypeOf(Object.prototype); // null

  const a = [];
  Object.getPrototypeOf(a);                // Array.prototype
  Object.getPrototypeOf(Array.prototype);  // Object.prototype
  ```

  <p style="text-align: center">
    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 296.39984130859375 444.91424560546875" height="320px">
      <g stroke-linecap="round" transform="translate(164.39996337890625 390.1142578125) rotate(0 29.4857177734375 22.399993896484375)"><path d="M11.2 0 C20.67 0, 30.14 0, 47.77 0 M11.2 0 C22.21 0, 33.23 0, 47.77 0 M47.77 0 C55.24 0, 58.97 3.73, 58.97 11.2 M47.77 0 C55.24 0, 58.97 3.73, 58.97 11.2 M58.97 11.2 C58.97 17.44, 58.97 23.67, 58.97 33.6 M58.97 11.2 C58.97 19.84, 58.97 28.48, 58.97 33.6 M58.97 33.6 C58.97 41.07, 55.24 44.8, 47.77 44.8 M58.97 33.6 C58.97 41.07, 55.24 44.8, 47.77 44.8 M47.77 44.8 C33.97 44.8, 20.16 44.8, 11.2 44.8 M47.77 44.8 C37.33 44.8, 26.89 44.8, 11.2 44.8 M11.2 44.8 C3.73 44.8, 0 41.07, 0 33.6 M11.2 44.8 C3.73 44.8, 0 41.07, 0 33.6 M0 33.6 C0 28.67, 0 23.73, 0 11.2 M0 33.6 C0 28.7, 0 23.8, 0 11.2 M0 11.2 C0 3.73, 3.73 0, 11.2 0 M0 11.2 C0 3.73, 3.73 0, 11.2 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(183.9756851196289 400.0142517089844) rotate(0 9.909996032714844 12.5)"><text x="9.909996032714844" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">[]</text></g><g stroke-linecap="round" transform="translate(108.65719604492188 264.228515625) rotate(0 88.39999389648432 30)"><path d="M15 0 C58.39 0, 101.78 0, 161.8 0 M15 0 C63.01 0, 111.02 0, 161.8 0 M161.8 0 C171.8 0, 176.8 5, 176.8 15 M161.8 0 C171.8 0, 176.8 5, 176.8 15 M176.8 15 C176.8 23.72, 176.8 32.44, 176.8 45 M176.8 15 C176.8 21.98, 176.8 28.97, 176.8 45 M176.8 45 C176.8 55, 171.8 60, 161.8 60 M176.8 45 C176.8 55, 171.8 60, 161.8 60 M161.8 60 C106.85 60, 51.9 60, 15 60 M161.8 60 C120.76 60, 79.72 60, 15 60 M15 60 C5 60, 0 55, 0 45 M15 60 C5 60, 0 55, 0 45 M0 45 C0 37.87, 0 30.75, 0 15 M0 45 C0 37.38, 0 29.75, 0 15 M0 15 C0 5, 5 0, 15 0 M0 15 C0 5, 5 0, 15 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(121.0972671508789 281.728515625) rotate(0 75.95992279052734 12.5)"><text x="75.95992279052734" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Array.prototype</text></g><g stroke-linecap="round" transform="translate(103.19989013671875 132.00003051757812) rotate(0 91.5999755859375 30)"><path d="M15 0 C64.55 0, 114.11 0, 168.2 0 M15 0 C50.07 0, 85.15 0, 168.2 0 M168.2 0 C178.2 0, 183.2 5, 183.2 15 M168.2 0 C178.2 0, 183.2 5, 183.2 15 M183.2 15 C183.2 26.18, 183.2 37.35, 183.2 45 M183.2 15 C183.2 21.68, 183.2 28.36, 183.2 45 M183.2 45 C183.2 55, 178.2 60, 168.2 60 M183.2 45 C183.2 55, 178.2 60, 168.2 60 M168.2 60 C114.46 60, 60.71 60, 15 60 M168.2 60 C129.67 60, 91.13 60, 15 60 M15 60 C5 60, 0 55, 0 45 M15 60 C5 60, 0 55, 0 45 M0 45 C0 38.19, 0 31.38, 0 15 M0 45 C0 34.37, 0 23.75, 0 15 M0 15 C0 5, 5 0, 15 0 M0 15 C0 5, 5 0, 15 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(113.5999526977539 149.50003051757812) rotate(0 81.19991302490234 12.5)"><text x="81.19991302490234" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">Object.prototype</text></g><g stroke-linecap="round"><g transform="translate(196.4358168272396 385.31427001953125) rotate(0 0.3163149382734787 -27.542861938476562)"><path d="M0 0 C0.11 -9.18, 0.53 -45.9, 0.63 -55.09 M0 0 C0.11 -9.18, 0.53 -45.9, 0.63 -55.09" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(196.4358168272396 385.31427001953125) rotate(0 0.3163149382734787 -27.542861938476562)"><path d="M8.91 -31.5 C6.11 -39.48, 3.31 -47.46, 0.63 -55.09 M8.91 -31.5 C7.19 -36.4, 5.47 -41.29, 0.63 -55.09" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(196.4358168272396 385.31427001953125) rotate(0 0.3163149382734787 -27.542861938476562)"><path d="M-8.19 -31.69 C-5.2 -39.61, -2.22 -47.52, 0.63 -55.09 M-8.19 -31.69 C-6.36 -36.55, -4.52 -41.41, 0.63 -55.09" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round"><g transform="translate(196.97772054142433 258.22857666015625) rotate(0 -0.31944716064583645 -27.714279174804688)"><path d="M0 0 C-0.11 -9.24, -0.53 -46.19, -0.64 -55.43 M0 0 C-0.11 -9.24, -0.53 -46.19, -0.64 -55.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(196.97772054142433 258.22857666015625) rotate(0 -0.31944716064583645 -27.714279174804688)"><path d="M8.18 -32.04 C4.68 -41.33, 1.17 -50.62, -0.64 -55.43 M8.18 -32.04 C5.93 -38, 3.68 -43.97, -0.64 -55.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(196.97772054142433 258.22857666015625) rotate(0 -0.31944716064583645 -27.714279174804688)"><path d="M-8.92 -31.84 C-5.63 -41.21, -2.34 -50.58, -0.64 -55.43 M-8.92 -31.84 C-6.81 -37.86, -4.7 -43.87, -0.64 -55.43" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(10 263.79998779296875) rotate(0 31.999969482421818 30)"><path d="M15 0 C28.3 0, 41.6 0, 49 0 M15 0 C23.8 0, 32.61 0, 49 0 M49 0 C59 0, 64 5, 64 15 M49 0 C59 0, 64 5, 64 15 M64 15 C64 24.91, 64 34.83, 64 45 M64 15 C64 23.94, 64 32.87, 64 45 M64 45 C64 55, 59 60, 49 60 M64 45 C64 55, 59 60, 49 60 M49 60 C37.94 60, 26.88 60, 15 60 M49 60 C37.98 60, 26.95 60, 15 60 M15 60 C5 60, 0 55, 0 45 M15 60 C5 60, 0 55, 0 45 M0 45 C0 33.16, 0 21.32, 0 15 M0 45 C0 34.54, 0 24.08, 0 15 M0 15 C0 5, 5 0, 15 0 M0 15 C0 5, 5 0, 15 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(31.3099746704101 281.29998779296875) rotate(0 10.689994812011719 12.5)"><text x="10.689994812011719" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">{}</text></g><g stroke-linecap="round"><g transform="translate(51.157049593541785 255.60003662109375) rotate(0 41.58380364553997 -28.000015258789034)"><path d="M0 0 C13.86 -9.33, 69.31 -46.67, 83.17 -56 M0 0 C13.86 -9.33, 69.31 -46.67, 83.17 -56" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(51.157049593541785 255.60003662109375) rotate(0 41.58380364553997 -28.000015258789034)"><path d="M68.46 -35.79 C73.83 -43.18, 79.21 -50.56, 83.17 -56 M68.46 -35.79 C73.53 -42.76, 78.6 -49.73, 83.17 -56" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(51.157049593541785 255.60003662109375) rotate(0 41.58380364553997 -28.000015258789034)"><path d="M58.91 -49.97 C67.77 -52.18, 76.64 -54.38, 83.17 -56 M58.91 -49.97 C67.27 -52.05, 75.64 -54.13, 83.17 -56" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask><g stroke-linecap="round" transform="translate(158.7999267578125 10) rotate(0 31.999969482421818 30)"><path d="M15 0 C25.87 0, 36.74 0, 49 0 M15 0 C22.46 0, 29.91 0, 49 0 M49 0 C59 0, 64 5, 64 15 M49 0 C59 0, 64 5, 64 15 M64 15 C64 24.72, 64 34.44, 64 45 M64 15 C64 26.84, 64 38.69, 64 45 M64 45 C64 55, 59 60, 49 60 M64 45 C64 55, 59 60, 49 60 M49 60 C39.55 60, 30.11 60, 15 60 M49 60 C38.95 60, 28.91 60, 15 60 M15 60 C5 60, 0 55, 0 45 M15 60 C5 60, 0 55, 0 45 M0 45 C0 35.73, 0 26.46, 0 15 M0 45 C0 37.42, 0 29.85, 0 15 M0 15 C0 5, 5 0, 15 0 M0 15 C0 5, 5 0, 15 0" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(175.18991088867188 27.5) rotate(0 15.6099853515625 12.5)"><text x="15.6099853515625" y="17.52" font-family="Virgil, Segoe UI Emoji" font-size="20px" fill="var(--md-code-fg-color)" text-anchor="middle" style="white-space: pre;" direction="ltr" dominant-baseline="alphabetic">null</text></g><g stroke-linecap="round"><g transform="translate(192.81306320539898 126) rotate(0 0.2666101017297251 -23.600006103515625)"><path d="M0 0 C0.09 -7.87, 0.44 -39.33, 0.53 -47.2 M0 0 C0.09 -7.87, 0.44 -39.33, 0.53 -47.2" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(192.81306320539898 126) rotate(0 0.2666101017297251 -23.600006103515625)"><path d="M8.35 -24.93 C6.4 -30.48, 4.45 -36.04, 0.53 -47.2 M8.35 -24.93 C6.48 -30.28, 4.6 -35.63, 0.53 -47.2" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g><g transform="translate(192.81306320539898 126) rotate(0 0.2666101017297251 -23.600006103515625)"><path d="M-7.79 -25.11 C-5.71 -30.62, -3.64 -36.13, 0.53 -47.2 M-7.79 -25.11 C-5.79 -30.42, -3.79 -35.72, 0.53 -47.2" stroke="var(--md-code-fg-color)" stroke-width="2" fill="none"></path></g></g><mask></mask></svg>
  </p>


</div>