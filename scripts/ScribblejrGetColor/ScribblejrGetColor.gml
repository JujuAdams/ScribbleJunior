// Feather disable all

/// @param name

function ScribblejrGetColor(_name)
{
    static _colourDict = __ScribblejrSystem().__colourDict;
    return _colourDict[$ _name];
}