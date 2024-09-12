# Default Font

&nbsp;

## …SetDefaultFont

**Usage:** `ScribblejrSetDefaultFont(font)`

**Returns:** N/A (`undefined`)

|Name   |Datatype |Purpose                   |
|-------|---------|--------------------------|
|`font` |reference|Font to set as the default|

Sets the default font for Scribble Junior. This default font will be used in cases where a font has not been specified. If a negative number is specified then Scribble Junior will fall back on `ScribblejrDefaultFont`, its own default font (which is Droid Sans Mono, close to GameMaker's native default font).

?> Unlike [Scribble Deluxe](https://www.github.com/jujuadams/Scribble), you will need to provide the font as a reference and not a string.

&nbsp;

## …GetDefaultFont

**Usage:** `ScribblejrGetDefaultFont()`

**Returns:** Reference, the current default font for Scribble Junior

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns the default font. If `ScribblejrSetDefaultFont()` has never been called, this function will return Scribble Junior's fallback font `ScribblejrDefaultFont`.