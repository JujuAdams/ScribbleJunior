// Feather disable all

/// @param name

function ScribblejrDeleteColor(_name)
{
    static _colourDict = __ScribblejrSystem().__colourDict;
    variable_struct_remove(_colourDict, _name);
}