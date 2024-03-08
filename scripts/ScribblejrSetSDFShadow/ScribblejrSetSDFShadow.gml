// Feather disable all

/// Turns SDF shadow effects on and off for subsequent draw calls
/// 
/// @param state

function ScribblejrSetSDFShadow(_state)
{
    static _sdfShadow = __ScribblejrSystem().__sdfShadow;
    _sdfShadow.__enabled = _state;
}