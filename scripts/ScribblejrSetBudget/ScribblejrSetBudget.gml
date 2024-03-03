// Feather disable all

/// Sets the time budget for vertex buffer baking. This is approximate and the baker will sometimes
/// slightly overstep the budget. If this function is never called then the baker budget is set to
/// the value defined in the SCRIBBLEJR_BUDGET macro.
/// 
/// @param microseconds

function ScribblejrSetBudget(_microseconds)
{
    static _system = __ScribblejrSystem();
    _system.__budget = _microseconds;
}