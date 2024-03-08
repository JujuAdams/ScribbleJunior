// Feather disable all

/// Returns whether the SDF shadow effect is enabled.

function ScribblejrGetSDFShadow()
{
    static _sdfShadow = __ScribblejrSystem().__sdfShadow;
    return _sdfShadow.__enabled;
}