// Feather disable all

/// Sets parameters for the SDF shadow effect. This effect will only be applied to SDF fonts, and
/// it will further only be applied if the effect is enabled by ScribblejrSetSDFShadow().
/// 
/// @param color
/// @param alpha
/// @param xOffset
/// @param yOffset
/// @param [softness=0]

function ScribblejrSetSDFShadowParams(_color, _alpha, _xOffset, _yOffset, _softness = 0)
{
    static _sdfShadow = __ScribblejrSystem().__sdfShadow;
    with(_sdfShadow)
    {
        __color    = _color;
        __red      = color_get_red(_color)/255;
        __green    = color_get_green(_color)/255;
        __blue     = color_get_blue(_color)/255;
        __alpha    = _alpha;
        __xOffset  = _xOffset;
        __yOffset  = _yOffset;
        __softness = clamp(_softness, 0, 1);
    }
}