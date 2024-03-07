# Colors

&nbsp;

## ScribblejrAddColor

**Usage:** `ScribblejrAddColor(name, color)`

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                  |
|-------|--------|-----------------------------------------|
|`name` |string  |Name to use for the color formatting tag |
|`color`|color   |Color to use for the color formatting tag|

Adds a colour that Scribble Junior will recognise when used in formatting tags in strings drawn by the `Scribblejr*Ext()` functions. Colours should be provided in GameMaker's standard 24-bit BGR format. Colour names are case sensitive. If you specify a negative number then Scribble Junior will interpret this as a colour reset command.

?> Color formatting tags should be inserted into strings using square brackets e.g. `"This text is [c_red]red[/c] and this text is [c_blue]blue[/c]."`

&nbsp;

## ScribblejrGetColor

**Usage:** `ScribblejrGetColor(name)`

**Returns:** Color, the color defined for the given name

|Name   |Datatype|Purpose                         |
|-------|--------|--------------------------------|
|`name` |string  |Name of the color formatting tag|

Returns the colour defined for the given name. If the colour cannot be found then this function returns `undefined`.

&nbsp;

## ScribblejrDeleteColor

**Usage:** `ScribblejrDeleteColor(name)`

**Returns:** Color

|Name   |Datatype|Purpose                         |
|-------|--------|--------------------------------|
|`name` |string  |Name of the color formatting tag|

Deletes the colour formatting tag, meaning it can no longer be used to format text. Calling this function will not change the colour of text that's already being drawn (i.e. it won't change the appearance of text that has already been cached).