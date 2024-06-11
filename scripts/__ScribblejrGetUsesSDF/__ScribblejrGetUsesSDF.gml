// Feather disable all

/// @param font

function __ScribblejrGetUsesSDF(_font)
{
    static _fontUsesSDFMap = __ScribblejrSystem().__fontUsesSDFMap;
    
    var _result = _fontUsesSDFMap[? _font];
    if (_result == undefined)
    {
        _result = ScribblejrCacheFontInfo(_font).sdfEnabled;
        _fontUsesSDFMap[? _font] = _result;
    }
    
    return _result;
}