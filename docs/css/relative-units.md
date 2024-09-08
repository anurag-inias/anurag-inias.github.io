# em, rem and more

<style>
.md-logo img {
  content: url('/css/css.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/css/css.svg');
}

.demo-box {
  padding: 1em;
  font-size: 16px;
  background-color: #FFF9DBAF;
}

.demo-box > div {
  background-color: var(--md-primary-fg-color);
}

input {
  border: 1px solid #F2F0FF;
  padding: 0.5rem;
  border-radius: 0.5rem;
}
</style>

## em

`1em` denotes the font size of the current element.

<div id="em-demo-1-box" class="demo-box">
<div>
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
</div>
</div>

In this example, the padding is set to `1em` which calculated to be same as font size of the div.

<div class="grid" markdown>

`font-size:` <input type="number" value="16" min="0" id="em-demo-1-font-size" onchange="changeEmDemo1FontSize();" onkeyup="changeEmDemo1FontSize();"/> px

`padding:` <input type="number" value="1.0" min="0" step="0.1" id="em-demo-1-padding" onchange="changeEmDemo1Padding();" onkeyup="changeEmDemo1Padding();"/> em

</div>

```css
div {
  font-size: 16px;
  padding: 1em;
}
```

### em as font-size

Above mentioned mechanism wouldn't work for font size. What's `1.5x` of `1.5x`? Instead, when used as font size, `em` refers to the inherited font size.

```css
body {
  font-size: 16px;
}

.box {
  font-size: 1.2em; // 16 x 1.2 = 19.2px
  padding: 1.2em;   // 19.2 x 1.2 = 23.04px !
}
```

This is a counterintuitive outcome. Even though the relative value of both font size and padding are same (`1.2em`), we end up with two different absolute value for the two.

## rem

`rem` is short for root em. Instead of being relative to the current element, `rem` is relative to the `:root` pseudo element (equivalent as `<html>` tag).

```css
:root {
  font-size: 1em;     // 16px from user-agent styles.
}

.box {
  font-size: 0.8rem;  // 16 x 0.8 = 12.8px
}
```

This is a happy middle-ground between absolute units (`px`) and relative units (`em`). No matter where used, `1.2rem` is \\(1.2\times\\) the font size of root element.

{==

- Use `rem` for font-size.
- `px` for borders.
- either `em` or `rem` for everything else.

==}

---------------------

## Viewport relative units

- `vh` \\(1\\%\\) of viewport height.
- `vw` \\(1\\%\\) of viewport width.
- `vmin` \\(1\\%\\) of minimum of viewport width and height.
- `vmax` \\(1\\%\\) of maximum of viewport width and height.

The above units cause layout thrashing on mobile phones where viewport can keep changing as user scroll through the site, as scrolling down can hide address bar and other browser elements, causing these values to change.

Browsers reponded by altering the interpretation of these units by sticking to the largest possible viewport. But now there are designated units to make the differentiation:

- `lvh`, `lvw`, `lvmin`, `lvmax` refer to the above units for largest possible viewport.
- `svh`, `svw`, `svmin`, `svmax` refer to the above units for  smallest possible viewport.
- `dvh`, `dvw`, `dvmin`, `dvmax` refer to the old _dynamically_ calculated value of viewport based sizing.

## Responsive design with clamp

`clamp` is a smarter variant of `calc` which lets you define a minimum and maximum value.

```css
:root {
  font-size: clamp(16px, 0.5rem + 1svw, 24px);
}
```

- `0.5rem + 1svw` lets you scale font size smoothly with browser viewport. `0.5rem` here acts as an offset, without which font can become illegible.
- `16px` is the minimum font size.
- `24px` is the maximum font size.


<script>

function changeEmDemo1FontSize() {
  document.getElementById('em-demo-1-box').style.fontSize = document.getElementById('em-demo-1-font-size').value + 'px';
}

function changeEmDemo1Padding() {
  document.getElementById('em-demo-1-box').style.padding = document.getElementById('em-demo-1-padding').value + 'em';
}

</script>