// Feather disable all

/// @param font
/// @param proportional
/// @param separation

function ScribblejrAttachSpritefont(_font, _proportional, _separation)
{
    static _system = __ScribblejrSystem();
    _system.__spriteFontData[$ font_get_name(_font)] = {
        __proportional: _proportional,
        __separation:   _separation,
    };
}