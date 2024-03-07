# Spritefonts

&nbsp;

## ScribblejrAttachSpritefont

**Usage:** `ScribblejrAttachSpritefont(font, proportional, separation)`

**Returns:** N/A (`undefined`)

|Name          |Datatype |Purpose                                                                          |
|--------------|---------|---------------------------------------------------------------------------------|
|`font`        |reference|Spritefont to attach to Scribble Junior (as returned from `font_add_sprite` etc.)|
|`proportional`|boolean  |Set as proportional font or not                                                  |
|`separation`  |number   |Space to leave between each letter                                               |

Unfortunately, due to limitations in GameMaker's `font_get_info()` it is not possible to automatically retrieve the `proportional` and `separation` values for a spritefont after that spritefont has been created. Scribble Junior needs that information to bake vertex buffers. To bridge the gap, you must call this function to add the necessary context for each spritefont you intend to use with Scribble Junior. The values passed to this function should be the same values you pass to GameMaker's native `font_add_sprite_ext()` and it is recommended that you call `ScribblejrAttachSpritefont()` immediately after `font_add_sprite_ext()`.