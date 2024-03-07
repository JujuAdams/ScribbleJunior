# Prefetching Font Data

&nbsp;

## ScribblejrCacheFontInfo

**Usage:** `ScribblejrCacheFontInfo(font)`

**Returns:** N/A (`undefined`)

|Name   |Datatype |Purpose               |
|-------|---------|----------------------|
|`font` |reference|Font to cache data for|

When drawing fonts that have a lot of glyphs defined (Chinese, Japanese, and Korean fonts are common examples) then you'll notice that Scribble Junior pauses briefly the first time these fonts are drawn. This is because Scribble Junior is requesting font information from GameMaker which is a very slow operation. This can be distracting for players so Scribble Junior caches this information as soon as possible so the font info only needs to be fetched once. Unfortunately, that first fetch does still need to happen at some point.

This function is provided so that you can choose to trigger the slow font information fetch at a moment of your choosing. You might want to call this function for every font at the start of the game or maybe only call it when changing language.