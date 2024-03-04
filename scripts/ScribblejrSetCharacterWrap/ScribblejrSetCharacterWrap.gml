// Feather disable all

/// @param state

function ScribblejrSetCharacterWrap(_state)
{
    static _system = __ScribblejrSystem();
    _system.__perCharacterWrap = _state;
}