// Feather disable all

/// @param x
/// @param y
/// @param string
/// @param wrapWidth
/// @param sdfEffects

function __ScribblejrDrawTextExt(_x, _y, _string, _wrapWidth, _sdfEffects)
{
    static _system = __ScribblejrSystem();
    
    var _font = draw_get_font();
    
    if (_system.__preMultipliedAlpha)
    {
        __SCRIBBLEJR_SHADER_SET(__ScribblejrGetUsesSDF(_font)? __shdScribblejrPMA_SDF : __shdScribblejrPMA);
        draw_text_ext(_x, _y, _string, -1, _wrapWidth);
        __SCRIBBLEJR_SHADER_RESET();
    }
    else
    {
        if (_sdfEffects == undefined)
        {
            font_enable_effects(_font, true, _sdfEffects);
            draw_text_ext(_x, _y, _string, -1, _wrapWidth);
            if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) font_enable_effects(_font, false);
        }
        else
        {
            draw_text_ext(_x, _y, _string, -1, _wrapWidth);
        }
    }
}