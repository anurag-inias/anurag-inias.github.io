# Box Model

<style>
.md-logo img {
  content: url('/css/css.svg');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/css/css.svg');
}
</style>

<div class="grid" markdown>

<div markdown>
`box-sizing: content-box;`

By **default in CSS** box model, the `width` and `height` assigned to an element is only applied to its content box. Any padding, border, and margin are added on top of that.

</div>

<div markdown>
![](content-box-light.svg#only-light)
![](content-box-night.svg#only-dark)
</div>

<div markdown>
`box-sizing: border-box;`

This tells the browser to account for padding and border in the specified `width` and `height`.

</div>

<div markdown>
![](border-box-light.svg#only-light)
![](border-box-night.svg#only-dark)
</div>

</div>
