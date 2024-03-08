# ScribblejrDrawNative

**Usage:** `ScribblejrDrawNative(x, y, string, [colour], [alpha], [hAlign], [vAlign], [font], [fontScale], [sdfEffects])`

**Returns:** N/A (`undefined`)

&nbsp;

## Description

|Name          |Datatype |Purpose                                                                             |
|--------------|---------|------------------------------------------------------------------------------------|
|`x`           |number   |x-coordinate to draw the text at                                                    |
|`y`           |number   |y-coordinate to draw the text at                                                    |
|`string`      |string   |Text to search for in the cache                                                     |
|`[hAlign]`    |constant |Horizontal alignment, one of `fa_left` `fa_center` `fa_right`. Defaults to `fa_left`|
|`[vAlign]`    |constant |Vertical alignment, one of `fa_top` `fa_middle` `fa_bottom`. Defaults to `fa_top`   |
|`[font]`      |reference|Font to use. Defaults to what has been set by `ScribblejrSetDefaultFont()`          |
|`[fontScale]` |number   |Scale of the font. Defaults to `1`, no change in scale                              |
|`[sdfEffects]`|struct   |SDF effects to apply                                                                |

Draws plain text without formatting or layout. This is a convenience function that wraps around GameMaker's native text drawing. Nothing special!

If you are using an SDF font, you may provide an SDF effects struct as you would use with the native function [`font_enable_effects()`](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Fonts/font_enable_effects.htm).

?> Only the drop shadow effect is supported at this time.

!> This function should only be used for extremely fast changing text such as a stopwatch. You should use `Scribblejr()` instead if you plan for the drawn text to persist for around a second or more.