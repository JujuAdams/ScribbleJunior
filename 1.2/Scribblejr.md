# Scribblejr

**Usage:** `Scribblejr(string, [hAlign], [vAlign], [font], [fontScale])`

**Returns:** Text element struct, see below

&nbsp;

## Description

|Name         |Datatype |Purpose                                                                             |
|-------------|---------|------------------------------------------------------------------------------------|
|`string`     |string   |Text to search for in the cache                                                     |
|`[hAlign]`   |constant |Horizontal alignment, one of `fa_left` `fa_center` `fa_right`. Defaults to `fa_left`|
|`[vAlign]`   |constant |Vertical alignment, one of `fa_top` `fa_middle` `fa_bottom`. Defaults to `fa_top`   |
|`[font]`     |reference|Font to use. Defaults to what has been set by `ScribblejrSetDefaultFont()`          |
|`[fontScale]`|number   |Scale of the font. Defaults to `1`, no change in scale                              |

Caches plain text without formatting or layout. Over a few frames in the background, Scribble Junior will bake a vertex buffer that replaces the native text rendering and is faster to draw.

!> This function should not be used for extremely fast changing text such as a stopwatch. You should use ScribblejrNative() instead if you plan for the drawn text to only show for a few frames at a time.

?> This function relies on internal caching for performance gains. If you change any of the arguments provided to this function, Scribble Junior will have to do extra work to recache the new text data. Try to limit how often you change these arguments to get the best performance.

&nbsp;

## Methods

This function doesn't actually draw the text, it only returns a "text element struct". This struct can then be used to draw the text, as well as get the width/height of the text, by calling methods on the struct.

&nbsp;

### .Draw

`<element>.Draw(x, y, [color=white], [alpha=1], [sdfEffects])`

Draws the text element at the given coordinates. You can also optionally specify a colour and alpha.

If you are using an SDF font, you may provide an SDF effects struct as you would use with the native function [`font_enable_effects()`](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Fonts/font_enable_effects.htm).

?> Only the drop shadow effect is supported at this time.

&nbsp;

### .GetWidth

`<element>.GetWidth()`

Returns the width of the text when drawn, in pixels.

&nbsp;

### .GetHeight

`<element>.GetHeight()`

Returns the height of the text when, in pixels.

&nbsp;

### .Bake

`<element>.Bake()`

Immediately fully bakes the vertex buffer for the text element. Helpful if you want to pre-cache text elements for drawing later.