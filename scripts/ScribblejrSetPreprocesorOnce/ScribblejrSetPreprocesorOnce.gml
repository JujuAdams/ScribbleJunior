// Feather disable all

/// @param method

function ScribblejrSetPreprocesorOnce(_method)
{
    static _system = __ScribblejrSystem();
    
    with(_system)
    {
        if (__preprocessorMethod != _method)
        {
            __preprocessorUsingDefault = false;
            
            __preprocessorMethod = _method;
            __preprocessorName   = string(_method);
            
            __preprocessorOnce = true;
        }
    }
}