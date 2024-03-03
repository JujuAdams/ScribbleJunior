// Feather disable all

/// Returns the Scribble compilation time budget.

function ScribblejrGetBudgetUsed()
{
    static _system = __ScribblejrSystem();
    return _system.__budgetUsedPrev;
}