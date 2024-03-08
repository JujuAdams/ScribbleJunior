# Config Macros

The macros on this page can be found in the `__ScribblejrConfig` script. All macros start with `SCRIBBLEJR_` but this part of the macro name has been removed for brevity.

?> You should edit these macros to suit your own needs when using Scribble Junior.

&nbsp;

## `…SCALE_SPRITES`

*Typical value:* `true`

Scaling values passed to `Scribblejr*Ext` functions will scale up and down text. However, you may not want to scale sprites that have been inserted into the string in the same way. Setting this macro to `false` will keep sprites unscaled (scaling factor = 1) relative to the specified text scale.

?> If `ScribblejrShrinkExt()` or `ScribblejrFitExt()` require the string to be scaled down then sprites will be scaled down regardless of this macro's value.

&nbsp;

## `…AUTO_RESET_DRAW_STATE`

*Typical value:* `true`

Whether to reset draw state after Scribblejr calls. This slighly impacts performance for the worse but it is very convenient.

&nbsp;

## `…FIT_ITERATIONS`

*Typical value:* `6`

How many iterations to perform when fitting text inside the bounding box. This only applies to `ScribblejrFit()` and `ScribblejrFitExt()`. Higher numbers are more accurate but slower. Values lower than `4` tend to break!

&nbsp;

## `…SHADOW_SPRITES`

*Typical value:* `false`

Whether to give in-line sprites drop shadows in approximately the same fashion as SDF drop shadows. Sprite drop shadows will not respect the "softness" setting that is available for SDF drop shadows. Additionally, turning this feature on will incur a performance penalty.

&nbsp;

## `…BUDGET`

*Typical value:* `200`

Amount of time per frame that Scribble Junior is allowed to bake vertex buffers. This limit is approximate. You can adjust the budget time at runtime by calling `ScribblejrSetBudget()`. If this macro is set to zero or a negative number then all vertex buffer baking will be disabled until `ScribblejrSetBudget()` is called with a positive number.

&nbsp;

## `…BAKE_GLYPH_COUNT`

*Typical value:* `20`

How many glyphs to write per text element per frame during progressive baking. Higher values will bake vertex buffers faster but may cause Scribble Junior to exceed the time budget.

&nbsp;

## `…AUTO_BAKE`

*Typical value:* `true`

Whether to automatically bake vertex buffers for text drawn with Scribble Junior. Setting this macro to `false` will prevent Scribble Junior from optimising text drawing in the background.

&nbsp;

## `…VERBOSE`

*Typical value:* `false`

Whether to emit lots of additional debug messages to help track Scribble Junior's behaviour.

&nbsp;

## `…SHOW_DEBUG_MESSAGE`

*Typical value:* `show_debug_message`

Function to direct debug messages from Scribble Junior to.

&nbsp;

## `…SHOW_ERROR`

*Typical value:* `show_error`

Function to direct error messages from Scribble Junior to.
