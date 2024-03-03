/// @param key
/// @param string
/// @param hAlign
/// @param vAlign
/// @param font
/// @param fontScale

function __ScribblejrClass(_key, _string, _hAlign, _vAlign, _font, _fontScale) constructor
{
    static _system = __ScribblejrSystem();
    
    __wrapper = undefined;
    __lastDraw = current_time;
    
    __key    = _key;
    __string = _string;
    __hAlign = _hAlign;
    __vAlign = _vAlign;
    __font   = _font;
    __scale  = _fontScale;
    
    __fontIsDynamic = __ScribblejrGetFontInfo(_font).__isDynamic;
    
    Draw = (_fontScale == 1)? __Draw : __DrawScale;
    
    __vertexBuffer  = undefined;
    __fontTexture   = __ScribblejrGetFontInfo(_font).__forcedTexturePointer;
    __vertexBuilder = new __ScribblejrClassBuilder(__string, _font);
    
    __width  = undefined;
    __height = undefined;
    
    
    
    if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) var _oldFont = draw_get_font();
    draw_set_font(__font);
    
    //Cache string width/height to handle alignment positioning
    switch(_hAlign)
    {
        case fa_left:
            __xOffset = 0;
        break;
        
        case fa_center:
            __width = __scale*string_width(_string);
            __xOffset = -__width/2;
        break;
        
        case fa_right:
            __width = __scale*string_width(_string);
            __xOffset = -__width;
        break;
    }
    
    switch(_vAlign)
    {
        case fa_top:
            __yOffset = 0;
        break;
        
        case fa_middle:
            __height = __scale*string_height(_string);
            __yOffset = -__height/2;
        break;
        
        case fa_bottom:
            __height = __scale*string_height(_string);
            __yOffset = -__height;
        break;
    }
    
    if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) draw_set_font(_oldFont);
    if (SCRIBBLEJR_VERBOSE) __ScribblejrTrace("Created ", self);
    
    
    
    
    
    static toString = function()
    {
        return __key;
    }
    
    static GetWidth = function()
    {
        if (__width == undefined)
        {
            var _oldFont = draw_get_font();
            draw_set_font(__font);
            __width = __scale*string_width(__string);
            draw_set_font(_oldFont);
        }
       
        return __width;
    }
    
    static GetHeight = function()
    {
        if (__height == undefined)
        {
            var _oldFont = draw_get_font();
            draw_set_font(__font);
            __height = __scale*string_height(__string);
            draw_set_font(_oldFont);
        }
       
        return __height;
    }
    
    
    
    
    
    static __Draw = function(_x, _y, _colour = c_white, _alpha = 1, _forceNative = SCRIBBLEJR_DEFAULT_FORCE_NATIVE)
    {
        draw_set_font(__font);
        draw_set_colour(_colour);
        draw_set_alpha(_alpha);
        draw_set_halign(__hAlign);
        draw_set_valign(__vAlign);
        
        draw_text(_x, _y, __string);
        if (not _forceNative) __BuildVertexBufferTimed();
        
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) ScribblejrResetDrawState();
    }
    
    static __DrawScale = function(_x, _y, _colour = c_white, _alpha = 1, _forceNative = SCRIBBLEJR_DEFAULT_FORCE_NATIVE)
    {
        draw_set_font(__font);
        draw_set_colour(_colour);
        draw_set_alpha(_alpha);
        draw_set_halign(__hAlign);
        draw_set_valign(__vAlign);
        
        draw_text_transformed(_x, _y, __string, __scale, __scale, 0);
        if (not _forceNative) __BuildVertexBufferTimed();
        
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) ScribblejrResetDrawState();
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
        if (__fontIsDynamic) return; //Don't bake dynamic fonts
        
        if (__vertexBuilder != undefined) && (__vertexBuilder.__tickMethod())
        {
            if (SCRIBBLEJR_VERBOSE) __ScribblejrTrace("Compiled ", self);
            __vertexBuffer = __vertexBuilder.__vertexBuffer;
            Draw = __ScribblejrGetFontInfo(__font).sdfEnabled? __DrawVertexBufferSDF : __DrawVertexBuffer;
            __vertexBuilder = undefined;
        }
    }
    
    static __DrawVertexBuffer = function(_x, _y, _colour = c_white, _alpha = 1, _forceNative_UNUSED)
    {
        static _shdScribblejr_u_vPositionAlphaScale = shader_get_uniform(__shdScribblejr, "u_vPositionAlphaScale");
        static _shdScribblejr_u_iColour = shader_get_uniform(__shdScribblejr, "u_iColour");
        
        shader_set(__shdScribblejr);
        shader_set_uniform_f(_shdScribblejr_u_vPositionAlphaScale, _x + __xOffset, _y + __yOffset, _alpha, __scale);
        shader_set_uniform_i(_shdScribblejr_u_iColour, _colour);
        vertex_submit(__vertexBuffer, pr_trianglelist, __fontTexture);
        shader_reset();
    }
    
    static __DrawVertexBufferSDF = function(_x, _y, _colour = c_white, _alpha = 1, _forceNative_UNUSED)
    {
        static _shdScribblejrSDF_u_vPositionAlphaScale = shader_get_uniform(__shdScribblejrSDF, "u_vPositionAlphaScale");
        static _shdScribblejrSDF_u_iColour = shader_get_uniform(__shdScribblejrSDF, "u_iColour");
        
        shader_set(__shdScribblejrSDF);
        shader_set_uniform_f(_shdScribblejrSDF_u_vPositionAlphaScale, _x + __xOffset, _y + __yOffset, _alpha, __scale);
        shader_set_uniform_i(_shdScribblejrSDF_u_iColour, _colour);
        vertex_submit(__vertexBuffer, pr_trianglelist, __fontTexture);
        shader_reset();
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