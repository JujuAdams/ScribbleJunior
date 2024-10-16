// Feather disable all

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
                __preprocessor     = __preprocessorDefault;
                __preprocessorName = __preprocessorDefaultName;
            }
        }
    }
}