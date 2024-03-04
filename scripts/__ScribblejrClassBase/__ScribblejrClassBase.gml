function __ScribblejrClassBase() constructor
{
    static toString = function()
    {
        return __key;
    }
	
	static __Bake = function()
	{
        if (__fontIsDynamic) return; //Don't bake dynamic fonts
		while(not __BuildVertexBuffer()) __BuildVertexBuffer();
	}
	
    static __BuildVertexBufferTimed = function()
    {
        if (__fontIsDynamic) return; //Don't bake dynamic fonts
        if (_system.__budgetUsed >= _system.__budget) return; //Don't exceed the baking budget
        
        var _timer = get_timer();
        __BuildVertexBuffer();
        _system.__budgetUsed += get_timer() - _timer;
    }
    
    static __BuildVertexBuffer = function()
    {
        if (__fontIsDynamic) return true; //Don't bake dynamic fonts
        if (__vertexBuilder == undefined) return true;
		
        if (__vertexBuilder.__tickMethod())
        {
            if (SCRIBBLEJR_VERBOSE) __ScribblejrTrace("Compiled ", self);
            __vertexBuffer = __vertexBuilder.__vertexBuffer;
            Draw = ScribblejrCacheFontInfo(__font).sdfEnabled? __DrawVertexBufferSDF : __DrawVertexBuffer;
            __vertexBuilder = undefined;
			
			return true;
        }
		
		return false;
    }
	
    static __Destroy = function()
    {
        if (__vertexBuilder != undefined)
        {
            __vertexBuilder.__Destroy();
            __vertexBuilder = undefined;
        }
        
        if (__vertexBuffer != undefined)
        {
            vertex_delete_buffer(__vertexBuffer);
            __vertexBuffer = undefined;
        }
    }
}