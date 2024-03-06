# ScribblejrExt

`ScribblejrExt(string, [hAlign=left], [vAlign=top], [font], [fontScale=1])`

**Returns:** Text element struct, see below

|Name       |Datatype |Purpose                        |
|-----------|---------|-------------------------------|
|`string`   |string   |Text to search for in the cache|
|`hAlign`   |constant |                               |
|`vAlign`   |constant |                               |
|`font`     |reference|                               |
|`fontScale`|number   |                               |

Caches plain text with limited formatting but without text wrapping. Over a few frames in the background, Scribble Jr. will bake a vertex buffer that replaces the native text rendering and is faster to draw.

!> Manual line breaks ("newlines") are not supported.

?> This function relies on internal caching for performance gains. If you change any of the arguments provided to this function, Scribble Jr. will have to do extra work to recache the new text data. Try to limit how often you change these arguments to get the best performance.

&nbsp;

Two types of formatting command are supported:

### Partial Text Colouring

**Example:** "This is [c_orange]orange[/c] text."

Tags that contain the name of a colour constant will colour subsequent characters in the string. [/c] [/color] [/colour] can be used to reset the colour to the default colour for the function call. New colours can be added with ScribblejrAddColor(). Hash codes aren't parsed automatically but hash codes can be added via ScribblejrAddColor().

&nbsp;

### In-line Sprites

**Example:** `"You need [sprCoin]100 to buy this bomb."`

Sprites can be inserted by using the name of the sprite in between two square brackets. Inserted sprites cannot be animated and show only one image at a time. By default, image 0 is shown.
    
**Example:** `"You've found [sprFairy,0][sprFairy,1][sprFairy,2]"`

By adding a second parameter to that tag, a different subimage in a sprite can be inserted.
    
**Example:** `"Wow, magical! [sprSparke,0,0,4][sprSparke,0,0,0][sprSparke,0,0,-4]"`

You may also specify a third and fourth parameter which acts as an x/y offset for the sprite image. In this case, three images are displayed in a diagonal line from bottom to top, going left to right. This feature is helpful for adjusting sprite positions to line up better with text.

&nbsp;

This function doesn't actually draw the text, it only returns a "text element struct". This struct can then be used to draw the text, as well as get the width/height of the text, by calling methods on the struct.

&nbsp;

### .Draw()

`<element>.Draw(x, y, [color=white], [alpha=1])`

Draws the text element at the given coordinates. You can also optionally specify a colour and alpha.

&nbsp;

### .GetWidth()

`<element>.GetWidth()`

Returns the width of the text when drawn, in pixels.

&nbsp;

### .GetHeight()

`<element>.GetHeight()`

Returns the height of the text when, in pixels.

&nbsp;

### .Bake()

`<element>.Bake()`

Immediately fully bakes the vertex buffer for the text element. Helpful if you want to pre-cache text elements for drawing later.