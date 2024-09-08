# Basics

<style>
.md-logo img {
  content: url('/js/javascript.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/js/javascript.svg');
}
</style>

## JS on web

```html linenums="1" hl_lines="7-9"
<!DOCTYPE HTML>
<html>
  <body>

    <p>Lorem ipsum</p>

    <script>
      alert('Oi world!');
    </script>

  </body>
</html>
```

JS can be included anywhere in inside an HTML document. The `script` tag can be used without any attributes. When linking external scripts, use `src="/path/to/foo/bar.js"` attribute.

```html
<script src="/some/file.js">
  alert("this won't be called");
</script>
```

when `src` is set, script's inline content is not executed.

## Semicolon

<div class="grid" markdown>

```javascript
alert('hi')
alert('world')
```

```javascript
console.log(3 +
1
+ 2
); // logs 6
```

newline implies a semicolon.

JS doesn't insert a semicolon as the statement is ending on `+`.

</div>

## use strict

```javascript
"use strict";

// modern JS
```

directive to enforce modern JS behaviour. However, use of classes and modules automatically enables it.

## Variables

```javascript
// declaration
let greeting;

// assignment
greeting = "hello world";

// combined
let greeting = "hello world";

// also works for multiple variables.
let greeting = "hello world", name = "Piggy"; 
```

## Constants

```javascript
const pi = 3; // I'm an engineer. (1)

pi = 3.14;    // Uncaught TypeError: Assignment to constant variable.
```

1. they won't let me near any bridges.

## || and ??

- `||` returns first truthy value.
- `??` returns first defined value.

```javascript
null ?? 4 // 4
null || 4 // 4

0 ?? 4 // 0
0 || 4 // 4
```

