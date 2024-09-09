# Basics

<style>
.md-logo img {
  content: url('/js/javascript.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/js/javascript.svg');
}
</style>

An object is an unordered collection of properties, each of which is a key-value pair. The key is usually `string`, but can also be `symbol`. Beyond their own properties, objects can also inherit properties from thier "parent" prototype.

Unlike most other languages, objects in JS are dynamic, so properties can be added and removed at runtime.

## Creating objects

Objects can be created with object literals, `new` keyword and with `Object.create()` call.

## 1. Object literal

```javascript linenums="1"
// empty object
let foo = {};

// simple object
let foo = {
  age: 42,
  name: 'bar',
};

// keys are not valid variable identifier, so use string.
let name = 'oink oink';
let foo = {
  [name]: 'here comes the piggy',
};
```

## 2. With new operator

First thing to note that there are no constructors in JS. Instead there is `new` operator. When a function is called with `new` operator, it hijacks the function.

```javascript linenums="1"
new Object(); // same as {}
new Array();  // same as []
```

more on this later.

## 3. Object.create()

<div class="grid" markdown>

```javascript linenums="1"
// equivalent to {}, and new Object()
let o = Object.create(Object.prototype)
```

```
       null                   
        ▲                     
        │                     
        │ [[Prototype]]        
        │                     
┌───────┴────────┐            
│Object.prototype│            
└────────────────┘            
        ▲                     
        │                     
        │ [[Prototype]]        
        │ 
    ┌───┴────┐                   
    │ o = {} │                   
    └────────┘   
```

```javascript linenums="1"
// create object w/o any [[Prototype]]
Object.create(null)
```

```                                             
              ┌──►null◄─────┐                     
              │             │                     
[[Prototype]] │             │ [[Prototype]]       
              │             │                     
       ┌──────┴─────────┐ ┌─┴─┐                   
       │Object.prototype│ │ o │                   
       └────────────────┘ └───┘                   
```

```javascript linenums="1"
// create object with { foo: 'bar' } as [[Prototype]]
Object.create({ foo: 'bar' })
```

```
       null                   
        ▲                     
        │                     
        │ [[Prototype]]        
        │                     
┌───────┴────────┐            
│Object.prototype│            
└────────────────┘            
        ▲                     
        │                     
        │ [[Prototype]]        
        │ 
┌───────┴───────┐                   
│ { foo: 'bar'} │                   
└───────────────┘   
        ▲                     
        │                     
        │ [[Prototype]]        
        │ 
    ┌───┴────┐                   
    │ o = {} │                   
    └────────┘  
```

</div>



