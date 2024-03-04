/// @param key
/// @param string
/// @param hAlign
/// @param vAlign
/// @param font
/// @param fontScale
/// @param maxWidth
/// @param maxHeight

function __ScribblejrClassShrink(_key, _string, _hAlign, _vAlign, _font, _fontScale, _maxWidth, _maxHeight) : __ScribblejrClassBase() constructor
{
    static _system = __ScribblejrSystem();
    
    __wrapper = undefined;
    __lastDraw = current_time;
    
    __key       = _key;
    __string    = _string;
    __hAlign    = _hAlign;
    __vAlign    = _vAlign;
    __font      = _font;
    __wrapWidth = undefined;
    
    __fontIsDynamic = __ScribblejrGetFontInfo(_font).__isDynamic;
    
    Draw = __Draw;
    
    __width  = undefined;
    __height = undefined;
    
    
    
    
    if (is_infinity(_maxWidth))
    {
        //No limits!
        __scale = _fontScale;
        if (__scale != 1) Draw = __DrawScale;
    }
    else
    {
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) var _oldFont = draw_get_font();
        draw_set_font(__font);
        
        //Scale down as appropriate
        __width  = string_width(_string);
        __height = string_height(_string);
        
        if (is_infinity(_maxHeight))
        {
            __scale = min(_fontScale, _maxWidth / __width);
        }
        else
        {
            __scale = min(_fontScale, _maxWidth / __width, _maxHeight / __height);
        }
        
        __width  *= __scale;
        __height *= __scale;
        
        if (__scale != 1) Draw = __DrawScale;
        
        //Cache string width/height to handle alignment positioning
        switch(_hAlign)
        {
            case fa_left:   __xOffset = 0;          break;
            case fa_center: __xOffset = -__width/2; break;
            case fa_right:  __xOffset = -__width;   break;
        }
        
        switch(_vAlign)
        { 
            case fa_top:    __yOffset = 0;           break;
            case fa_middle: __yOffset = -__height/2; break;
            case fa_bottom: __yOffset = -__height;   break;
        }
        
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) draw_set_font(_oldFont);
    }
    
    __vertexBuffer  = undefined;
    __fontTexture   = __ScribblejrGetFontInfo(_font).__forcedTexturePointer;
    __vertexBuilder = new __ScribblejrClassBuilder(__string, _font);
    
    if (SCRIBBLEJR_VERBOSE) __ScribblejrTrace("Created ", self);
    
    
    
    
    
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
    
    
    
    
    
    static __Draw = function(_x, _y, _colour = c_white, _alpha = 1)
    {
        draw_set_font(__font);
        draw_set_colour(_colour);
        draw_set_alpha(_alpha);
        draw_set_halign(__hAlign);
        draw_set_valign(__vAlign);
        
        draw_text(_x, _y, __string);
        if (SCRIBBLEJR_AUTO_BAKE) __BuildVertexBufferTimed();
        
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) ScribblejrResetDrawState();
    }
    
    static __DrawScale = function(_x, _y, _colour = c_white, _alpha = 1)
    {
        draw_set_font(__font);
        draw_set_colour(_colour);
        draw_set_alpha(_alpha);
        draw_set_halign(__hAlign);
        draw_set_valign(__vAlign);
        
        draw_text_transformed(_x, _y, __string, __scale, __scale, 0);
        if (SCRIBBLEJR_AUTO_BAKE) __BuildVertexBufferTimed();
        
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) ScribblejrResetDrawState();
    }
    
    
    
    
    
    static __DrawVertexBuffer = function(_x, _y, _colour = c_white, _alpha = 1)
    {
        static _shdScribblejr_u_vPositionAlphaScale = shader_get_uniform(__shdScribblejr, "u_vPositionAlphaScale");
        static _shdScribblejr_u_iColour = shader_get_uniform(__shdScribblejr, "u_iColour");
        
        shader_set(__shdScribblejr);
        shader_set_uniform_f(_shdScribblejr_u_vPositionAlphaScale, _x + __xOffset, _y + __yOffset, _alpha, __scale);
        shader_set_uniform_i(_shdScribblejr_u_iColour, _colour);
        vertex_submit(__vertexBuffer, pr_trianglelist, __fontTexture);
        shader_reset();
    }
    
    static __DrawVertexBufferSDF = function(_x, _y, _colour = c_white, _alpha = 1)
    {
        static _shdScribblejrSDF_u_vPositionAlphaScale = shader_get_uniform(__shdScribblejrSDF, "u_vPositionAlphaScale");
        static _shdScribblejrSDF_u_iColour = shader_get_uniform(__shdScribblejrSDF, "u_iColour");
        
        shader_set(__shdScribblejrSDF);
        shader_set_uniform_f(_shdScribblejrSDF_u_vPositionAlphaScale, _x + __xOffset, _y + __yOffset, _alpha, __scale);
        shader_set_uniform_i(_shdScribblejrSDF_u_iColour, _colour);
        vertex_submit(__vertexBuffer, pr_trianglelist, __fontTexture);
        shader_reset();
    }
}