# Preprocessor

&nbsp;

## …SetPreprocesorDefault

**Usage:** `ScribblejrSetPreprocesorDefault(method)`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                  |
|--------|--------|-----------------------------------------|
|`method`|method  |Method to set as the default preprocessor|

Sets the default preprocessor. Any future calls to the extended functions (`ScribblejrExt` etc.) will use this preprocessor as the default. Calling `ScribblejrResetPreprocesor()` will reset the current preprocessor to the default preprocessor set by this function.

!> Any text elements that have already cached will **not** be updated.

&nbsp;

## …SetPreprocesorOnce

**Usage:** `ScribblejrSetPreprocesorOnce()`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                          |
|--------|--------|---------------------------------|
|`method`|method  |Method to set as the preprocessor|

Sets the current preprocessor but only temporarily. The preprocessor set by this function will affect the next calls to an extended Scribble Jr. function (e.g. `ScribblejrExt()`). After that function has been called, the preprocessor will be set to the default preprocessor.

&nbsp;

## …SetPreprocesor

**Usage:** `ScribblejrSetPreprocesor()`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                          |
|--------|--------|---------------------------------|
|`method`|method  |Method to set as the preprocessor|

Sets the current preprocessor. This will affect all future calls to extended Scribble Jr. functions (e.g. `ScribblejrExt()`).

&nbsp;

## …ResetPreprocesor

**Usage:** `ScribblejrResetPreprocesor()`

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Resets the current preprocessor to the default, as set by `ScribblejrSetPreprocesorDefault()`.

&nbsp;

## …Reprocess

**Usage:** `ScribblejrReprocess()`

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Reprocesses all Scribble Jr. text elements. If any text elements have changed the string that they are displaying then the text element will be regenerated. This is useful to update text based on changing game state.

!> This function is very slow. You should only call this function when there has been a significant change in fundamental game state, such as the player changed what type of gamepad they're using. Do not use this function to rapdily update Scribble Jr. text elements.