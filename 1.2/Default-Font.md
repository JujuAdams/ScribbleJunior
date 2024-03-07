# Default Font

&nbsp;

## ScribblejrSetDefaultFont

**Usage:** `ScribblejrSetDefaultFont(font)`

**Returns:** N/A (`undefined`)

|Name   |Datatype |Purpose                                         |
|-------|---------|------------------------------------------------|
|`font` |reference|                                                |

Sets the default font for Scribble Jr.  This default font will be used in cases where a font has not been specified. If a negative number is specified then Scribble Junior will fall back on its own default font (Droid Sans Mono which is close to GameMaker's native default font).

?> Unlike [Scribble Deluxe](https://www.github.com/jujuadams/Scribble), you will need to provide the font as a reference and not a string.

&nbsp;

## ScribblejrGetDefaultFont

**Usage:** `ScribblejrGetDefaultFont()`

**Returns:** Reference, the current default font for Scribble Junior

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the default font. If `ScribblejrSetDefaultFont()` has never been called, this function will return Scribble Junior's fallback font `ScribblejrDefaultFont`.