// Feather disable all

/// @param x
/// @param y
/// @param string
/// @param scale
/// @param sdfEffects

function __ScribblejrDrawTextTransformed(_x, _y, _string, _scale, _sdfEffects)
{
    static _system = __ScribblejrSystem();
    
    var _font = draw_get_font();
    
    if (_system.__preMultipliedAlpha)
    {
        __SCRIBBLEJR_SHADER_SET(__ScribblejrGetUsesSDF(_font)? __shdScribblejrPMA_SDF : __shdScribblejrPMA);
        draw_text_transformed(_x, _y, _string, _scale, _scale, 0);
        __SCRIBBLEJR_SHADER_RESET();
    }
    else
    {
        if (_sdfEffects == undefined)
        {
            font_enable_effects(_font, true, _sdfEffects);
            draw_text_transformed(_x, _y, _string, _scale, _scale, 0);
            if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) font_enable_effects(_font, false);
        }
        else
        {
            draw_text_transformed(_x, _y, _string, _scale, _scale, 0);
        }
    }
}