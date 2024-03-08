// Feather disable all

/// Returns the parameters for SDF shadows as a struct.
/// 
/// N.B. The struct that this function returns is statically allocated to the function and will be
///      reused for subsequent calls to the function.

function ScribblejrGetSDFShadowParams()
{
    static _sdfShadow = __ScribblejrSystem().__sdfShadow;
    static _result = {};
    
    with(_sdfShadow)
    {
        _result.color    = __color;
        _result.alpha    = __alpha;
        _result.xOffset  = __xOffset;
        _result.yOffset  = __yOffset;
        _result.softness = __softness;
    }
    
    return _result;
}