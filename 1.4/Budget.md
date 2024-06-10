# Budget

&nbsp;

## …SetBudget

**Usage:** `ScribblejrSetBudget(microseconds)`

**Returns:** N/A (`undefined`)

|Name          |Datatype|Purpose                                         |
|--------------|--------|------------------------------------------------|
|`microseconds`|number  |Approximate time budget for vertex buffer baking|

Sets the time budget for vertex buffer baking. This is approximate and the baker will sometimes slightly overstep the budget. If this function is never called then the baker budget is set to the value defined in the `SCRIBBLEJR_BUDGET` macro. If the budget is set to zero or a negative number then all vertex buffer baking will be paused (though any existing baked vertex buffers will still be used).

&nbsp;

## …GetBudget

**Usage:** `ScribblejrGetBudget()`

**Returns:** Number, the baking time budget, measured in microseconds

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## …GetBudgetUsed

**Usage:** `ScribblejrGetBudgetUsed()`

**Returns:** Number, how much time Scribble Junior used to bake vertex buffers in the previous Step

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Returns how much time Scribble Junior used to bake vertex buffers in the previous Step, measured in microseconds. This value will sometimes be a little more than the time budget set by `ScribblejrGetBudget()`.