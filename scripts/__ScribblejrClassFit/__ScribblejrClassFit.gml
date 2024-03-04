/// @param key
/// @param string
/// @param hAlign
/// @param vAlign
/// @param font
/// @param fontScale
/// @param maxWidth
/// @param maxHeight

function __ScribblejrClassFit(_key, _string, _hAlign, _vAlign, _font, _fontScale, _maxWidth, _maxHeight) : __ScribblejrClassBase() constructor
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
    
    __fontIsDynamic = ScribblejrCacheFontInfo(_font).__isDynamic;
    
    Draw = __Draw;
    
    __wrapped = true;
    __width   = undefined;
    __height  = undefined;
    
    
    
    
    
    if (is_infinity(_maxWidth))
    {
        //No limits!
        __wrapped = false;
        __scale = _fontScale;
        if (_fontScale != 1) Draw = __DrawScale;
    }
    else if (is_infinity(_maxHeight))
    {
        //No height limit, just draw wrapped as usual
        if (_fontScale == 1)
        {
            __scale      = 1;
            __wrapWidth  = _maxWidth;
            Draw = __DrawWrap;
        }
        else
        {
            __scale      = _fontScale;
            __wrapWidth  = _maxWidth/_fontScale;
            Draw = __DrawFit;
        }
    }
    else
    {
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) var _oldFont = draw_get_font();
        draw_set_font(__font);
        
        var _fitsAlready = true;
        var _height = _fontScale*string_height_ext(_string, -1, _maxWidth/_fontScale-1);
        if (_height > _maxHeight)
        {
            _fitsAlready = false;
        }
        else // _height <= _maxHeight
        {
            var _width = string_width(_string);
            if (_width > _maxWidth) _fitsAlready = false;
        }
        
        if (_fitsAlready)
        {
            //Height limit is enough, just draw wrapped as usual
            if (_fontScale == 1)
            {
                __scale      = 1;
                __wrapWidth  = _maxWidth;
                Draw = __DrawWrap;
            }
            else
            {
                __scale      = _fontScale;
                __wrapWidth  = _maxWidth/_fontScale;
                Draw = __DrawFit;
            }
        }
        else
        {
            var _upperScale = _fontScale;
            var _lowerScale = 0;
            
            //Perform a binary search to find the best fit
            repeat(SCRIBBLEJR_FIT_ITERATIONS)
            {
                //Bias scale search very slighty to be larger
                //This usually finds the global maxima rather than narrowing down on a local maxima
                var _tryScale = lerp(_lowerScale, _upperScale, 0.51);
                
                var _adjustedWidth  = _maxWidth/_tryScale;
                var _adjustedHeight = _maxHeight/_tryScale;
                
                var _width  = infinity;
                var _height = string_height_ext(_string, -1, _adjustedWidth-1); //Subtract 1 here to fix on off-by-one in GameMaker's text layout
                
                if (_height > _adjustedHeight)
                {
                    _upperScale = _tryScale;
                }
                else
                {
                    var _width = string_width_ext(_string, -1, _adjustedWidth-1);
                    if (_width > _adjustedWidth)
                    {
                        _upperScale = _tryScale;
                    }
                    else
                    {
                        _lowerScale = _tryScale;
                    }
                }
            }
            
            __scale     = _lowerScale;
            __wrapWidth = _maxWidth / _lowerScale;
            __width     = __scale*((_width  > _adjustedWidth)?  string_width_ext( _string, -1, __wrapWidth-1) : _width);
            __height    = __scale*((_height > _adjustedHeight)? string_height_ext(_string, -1, __wrapWidth-1) : _height);
            Draw = __DrawFit;
        }
        
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) draw_set_font(_oldFont);
    }
    
    __vertexBuffer  = undefined;
    __fontTexture   = ScribblejrCacheFontInfo(_font).__forcedTexturePointer;
    __vertexBuilder = new __ScribblejrClassBuilderFit(__string, _font, __hAlign, __vAlign, __wrapWidth);
    
    if (SCRIBBLEJR_VERBOSE) __ScribblejrTrace("Created ", self);
    
    
    
    
    
    static GetWidth = function()
    {
        if (__width == undefined)
        {
            var _oldFont = draw_get_font();
            draw_set_font(__font);
            
            if (__wrapped)
            {
                //Subtract 1 here to fix on off-by-one in GameMaker's text layout
                __width = __scale*string_width_ext(__string, -1, __wrapWidth);
            }
            else
            {
                __width = __scale*string_width(__string);
            }
            
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
            
            if (__wrapped)
            {
                //Subtract 1 here to fix on off-by-one in GameMaker's text layout
                __height = __scale*string_height_ext(__string, -1, __wrapWidth);
            }
            else
            {
                __height = __scale*string_height(__string);
            }
            
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
    
    static __DrawWrap = function(_x, _y, _colour = c_white, _alpha = 1)
    {
        draw_set_font(__font);
        draw_set_colour(_colour);
        draw_set_alpha(_alpha);
        draw_set_halign(__hAlign);
        draw_set_valign(__vAlign);
        
        draw_text_ext(_x, _y, __string, -1, __wrapWidth);
        if (SCRIBBLEJR_AUTO_BAKE) __BuildVertexBufferTimed();
        
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) ScribblejrResetDrawState();
    }
    
    static __DrawFit = function(_x, _y, _colour = c_white, _alpha = 1)
    {
        draw_set_font(__font);
        draw_set_colour(_colour);
        draw_set_alpha(_alpha);
        draw_set_halign(__hAlign);
        draw_set_valign(__vAlign);
        
        draw_text_ext_transformed(_x, _y, __string, -1, __wrapWidth, __scale, __scale, 0);
        if (SCRIBBLEJR_AUTO_BAKE) __BuildVertexBufferTimed();
        
        if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) ScribblejrResetDrawState();
    }
    
    
    
    
    
    static __DrawVertexBuffer = function(_x, _y, _colour = c_white, _alpha = 1)
    {
        static _shdScribblejr_u_vPositionAlphaScale = shader_get_uniform(__shdScribblejr, "u_vPositionAlphaScale");
        static _shdScribblejr_u_iColour = shader_get_uniform(__shdScribblejr, "u_iColour");
        
        shader_set(__shdScribblejr);
        shader_set_uniform_f(_shdScribblejr_u_vPositionAlphaScale, _x, _y, _alpha, __scale);
        shader_set_uniform_i(_shdScribblejr_u_iColour, _colour);
        vertex_submit(__vertexBuffer, pr_trianglelist, __fontTexture);
        shader_reset();
    }
    
    static __DrawVertexBufferSDF = function(_x, _y, _colour = c_white, _alpha = 1)
    {
        static _shdScribblejrSDF_u_vPositionAlphaScale = shader_get_uniform(__shdScribblejrSDF, "u_vPositionAlphaScale");
        static _shdScribblejrSDF_u_iColour = shader_get_uniform(__shdScribblejrSDF, "u_iColour");
        
        shader_set(__shdScribblejrSDF);
        shader_set_uniform_f(_shdScribblejrSDF_u_vPositionAlphaScale, _x, _y, _alpha, __scale);
        shader_set_uniform_i(_shdScribblejrSDF_u_iColour, _colour);
        vertex_submit(__vertexBuffer, pr_trianglelist, __fontTexture);
        shader_reset();
    }
}