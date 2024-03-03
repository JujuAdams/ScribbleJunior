/// @param string
/// @param font

function __ScribblejrClassBuilder(_string, _font) constructor
{
    static _system       = __ScribblejrSystem();
    static _vertexFormat = _system.__vertexFormat;
    
    __string = _string;
    __font   = _font;
    
    __tickMethod = __Decompose;
    
    var _fontInfo = __ScribblejrGetFontInfo(_font);
    __fontGlyphStruct = _fontInfo.glyphs;
    
    var _spaceWidth = __ScribblejrGetSpaceWidth(_font);
    __spaceWidth = _spaceWidth;
    
    var _fontTexture = _fontInfo.__forcedTexturePointer;
    __texTexelW = texture_get_texel_width(_fontTexture);
    __texTexelH = texture_get_texel_height(_fontTexture);
        
    __vertexBuffer = vertex_create_buffer();
    vertex_begin(__vertexBuffer, _vertexFormat);
    vertex_float2(__vertexBuffer, 0, 0); vertex_texcoord(__vertexBuffer, 0, 0);
    vertex_float2(__vertexBuffer, 0, 0); vertex_texcoord(__vertexBuffer, 0, 0);
    vertex_float2(__vertexBuffer, 0, 0); vertex_texcoord(__vertexBuffer, 0, 0);
    
    __glyph = 0;
    __glyphCount = string_length(__string);
    __glyphX = 0;
    
    
    
    
    
    static __Destroy = function()
    {
        if (__vertexBuffer != undefined)
        {
            vertex_delete_buffer(__vertexBuffer);
            __vertexBuffer = undefined;
        }
    }
    
    
    
    
    
    static __Decompose = function()
    {
        __stringArray = __ScribblejrStringDecompose(__string, __glyphCount);
        __tickMethod = __Tick;
        return false;
    }
    
    static __Tick = function()
    {
        repeat(SCRIBBLEJR_BAKE_GLYPH_COUNT)
        {
            var _char = __stringArray[__glyph];
            if (_char == " ")
            {
                __glyphX += __spaceWidth;
            }
            else
            {
                var _glyphData = __fontGlyphStruct[$ _char];
                if (_glyphData == undefined)
                {
                    //Oh dear
                }
                else
                {
                    var _texL = _glyphData.x*__texTexelW;
                    var _texT = _glyphData.y*__texTexelH;
                    var _texR = _texL + _glyphData.w*__texTexelW;
                    var _texB = _texT + _glyphData.h*__texTexelH;
                    
                    var _glyphL = __glyphX + _glyphData.offset;
                    var _glyphT = _glyphData.yOffset;
                    var _glyphR = _glyphL + _glyphData.w;
                    var _glyphB = _glyphT + _glyphData.h;
                    
                    vertex_float2(__vertexBuffer, _glyphL, _glyphT); vertex_texcoord(__vertexBuffer, _texL, _texT);
                    vertex_float2(__vertexBuffer, _glyphR, _glyphT); vertex_texcoord(__vertexBuffer, _texR, _texT);
                    vertex_float2(__vertexBuffer, _glyphL, _glyphB); vertex_texcoord(__vertexBuffer, _texL, _texB);
                    vertex_float2(__vertexBuffer, _glyphR, _glyphT); vertex_texcoord(__vertexBuffer, _texR, _texT);
                    vertex_float2(__vertexBuffer, _glyphR, _glyphB); vertex_texcoord(__vertexBuffer, _texR, _texB);
                    vertex_float2(__vertexBuffer, _glyphL, _glyphB); vertex_texcoord(__vertexBuffer, _texL, _texB);
                    
                    __glyphX += _glyphData.shift;
                }
            }
            
            __glyph++;
            if (__glyph >= __glyphCount)
            {
                vertex_end(__vertexBuffer);
                
                __tickMethod = __Freeze;
                return false;
            }
        }
        
        return false;
    }
    
    static __Freeze = function()
    {
        if ((_system.__budget - _system.__budgetUsed > 500) || (_system.__budgetUsed == 0))
        {
            vertex_freeze(__vertexBuffer);
            __tickMethod = __Finished;
            return true;
        }
        else
        {
            return false;
        }
    }
    
    static __Finished = function()
    {
        return true;
    }
}