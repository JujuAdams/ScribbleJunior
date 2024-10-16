// Feather disable all

/// @param method

function ScribblejrSetPreprocesor(_method)
{
    static _system = __ScribblejrSystem();
    
    with(_system)
    {
        if (__preprocessor != _method)
        {
            __preprocessorUsingDefault = false;
            
            __preprocessor     = _method;
            __preprocessorName = string(_method);
            
            __preprocessorOnce = false;
        }
    }
}