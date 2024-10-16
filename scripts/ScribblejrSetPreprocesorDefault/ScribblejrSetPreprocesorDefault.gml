// Feather disable all

/// Sets the default preprocessor. Any future calls to the extended functions (`ScribblejrExt`
/// etc.) will use this preprocessor as the default. Calling `ScribblejrResetPreprocesor()` will
/// reset the current preprocessor to the default preprocessor set by this function.
/// 
/// N.B. Any text elements that have already cached will **not** be updated.
/// 
/// @param [method=SCRIBBLEJR_NO_PREPROCESS]

function ScribblejrSetPreprocesorDefault(_method = SCRIBBLEJR_NO_PREPROCESS)
{
    static _system = __ScribblejrSystem();
    
    with(_system)
    {
        if (__preprocessorDefault != SCRIBBLEJR_NO_PREPROCESS)
        {
            __preprocessorDefault     = _method;
            __preprocessorDefaultName = string(_method);
            
            if (__preprocessorUsingDefault)
            {
                __preprocessorMethod = __preprocessorDefault;
                __preprocessorName   = __preprocessorDefaultName;
            }
        }
    }
}