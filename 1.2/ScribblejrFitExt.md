# ScribblejrFitExt

**Usage:** `ScribblejrFitExt(string, [hAlign], [vAlign], [font], [fontScale], [width], [height])`

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
|`[width]`    |number   |Maximum width of the text. Defaults to no limit                                     |
|`[height]`   |number   |Maximum height of the text. Defaults to no limit                                    |

Caches plain text with limtied formatting. The text is shrunk down to within the given maximum width and height by reflowing the text at a smaller size. Over a few frames in the background, Scribble Junior will bake a vertex buffer that replaces the native text rendering and is faster to draw.

This function scales text whilst adding newlines. If you want to scale down text without adding newlines, which will gain you a little performance, then use ScribblejrShrinkExt().

!> Manual line breaks ("newlines") are not supported. Word breaks will only happen on spaces and any single words too long for a line will not be split in the middle. Per-character text wrapping (commonly used for Chinese) is not supported.

?> This function relies on internal caching for performance gains. If you change any of the arguments provided to this function, Scribble Junior will have to do extra work to recache the new text data. Try to limit how often you change these arguments to get the best performance.

&nbsp;

## Formatting

Two types of formatting command are supported:

&nbsp;

### Partial Text Colouring

**Example:** `"This is [c_orange]orange[/c] text."`

Tags that contain the name of a colour constant will colour subsequent characters in the string. [/c] [/color] [/colour] can be used to reset the colour to the default colour for the function call. New colours can be added with ScribblejrAddColor(). Hash codes aren't parsed automatically but hash codes can be added via ScribblejrAddColor().

&nbsp;

### In-line Sprites

Sprites can be inserted by using the name of the sprite in between two square brackets. Inserted sprites cannot be animated and show only one image at a time. By default, image 0 is shown.
    
**Example:** `"You need [sprCoin]100 to buy this bomb."`

By adding a second parameter to that tag, a different subimage in a sprite can be inserted.

**Example:** `"You've found [sprFairy,0][sprFairy,1][sprFairy,2]"`

You may also specify a third and fourth parameter which acts as an x/y offset for the sprite image. In this case, three images are displayed in a diagonal line from bottom to top, going left to right. This feature is helpful for adjusting sprite positions to line up better with text.

**Example:** `"Wow, magical! [sprSparke,0,0,4][sprSparke,0,0,0][sprSparke,0,0,-4]"`

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