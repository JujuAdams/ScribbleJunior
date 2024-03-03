//Scaling values passed to Scribblejr*Ext functions will scale up and down text. However, you may
//not want to scale sprites that have been inserted into the string in the same way. Setting this
//macro to <false> will keep sprites unscaled (scaling factor = 1) relative to the specified text
//scale.
//
// N.B. If ScribblejrShrinkExt() or ScribblejrFitExt() require the string to be scaled down then
//      sprites will be scaled down regardless of this macro's value.
#macro SCRIBBLEJR_SCALE_SPRITES  true

//Whether to reset draw state after Scribblejr calls. This will slighly negatively impact
//performance but is convenient.
#macro SCRIBBLEJR_AUTO_RESET_DRAW_STATE  true

//How many iterations to perform when fitting text inside the bounding box. This only applies to
//ScribblejrFit() and ScribblejrFitExt(). Higher numbers are more accurate but slower.
#macro SCRIBBLEJR_FIT_ITERATIONS  6

//Amount of time per frame that Scribblejr is allowed to bake vertex buffers. This limit is
//approximate. You can adjust the budget time at runtime by calling ScribblejrSetBudget().
#macro SCRIBBLEJR_BUDGET  200 //microseconds

//How many glyphs to write per text element per frame during progressive building. Higher values
//will build vertex buffers faster but may cause Scribblejr to exceed the time budget.
#macro SCRIBBLEJR_BUILD_GLYPH_ITERATIONS  20

//Default "forceNative" value for Scribblejr draw calls. Settings this macro to <true> will force
//draw calls to use GameMaker's native draw calls. This is useful if you don't want to use
//Scribblejr's vertex buffer implementation at all.
#macro SCRIBBLEJR_DEFAULT_FORCE_NATIVE  false

//Whether to emit lots of additional debug messages to help track Scribblejr's behaviour.
#macro SCRIBBLEJR_VERBOSE  false

//Functions to call when Scribblejr emits messages. Change these if you want to redirect Scribblejr
//messages to something other than the console / native error handler.
#macro SCRIBBLEJR_SHOW_DEBUG_MESSAGE  show_debug_message //Warnings and general information
#macro SCRIBBLEJR_SHOW_ERROR          show_error         //Fatal errors