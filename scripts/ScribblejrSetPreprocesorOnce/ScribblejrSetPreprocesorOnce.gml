// Feather disable all

/// Sets the current preprocessor but only temporarily. The preprocessor set by this function will
/// affect the next calls to an extended Scribble Jr. function (e.g. `ScribblejrExt()`). After that
/// function has been called, the preprocessor will be set to the default preprocessor.
/// 
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