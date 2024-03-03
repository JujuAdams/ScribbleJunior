// Feather disable all

/// @param name
/// @param color

function ScribblejrAddColor(_name, _color)
{
    static _colourDict = __ScribblejrSystem().__colourDict;
    _colourDict[$ _name] = _color;
}