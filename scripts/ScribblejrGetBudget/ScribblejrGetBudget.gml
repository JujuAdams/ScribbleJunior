// Feather disable all

/// Returns the Scribble compilation time budget.

function ScribblejrGetBudget()
{
    static _system = __ScribblejrSystem();
    return _system.__budget;
}