// Feather disable all

#macro __SCRIBBLEJR_WRITE  ;\
vertex_float2(__vertexBuffer, _glyphL, _glyphB); vertex_texcoord(__vertexBuffer, _texL, _texB);\
vertex_float2(__vertexBuffer, _glyphR, _glyphB); vertex_texcoord(__vertexBuffer, _texR, _texB);\
vertex_float2(__vertexBuffer, _glyphR, _glyphT); vertex_texcoord(__vertexBuffer, _texR, _texT);\
vertex_float2(__vertexBuffer, _glyphR, _glyphT); vertex_texcoord(__vertexBuffer, _texR, _texT);\
vertex_float2(__vertexBuffer, _glyphL, _glyphT); vertex_texcoord(__vertexBuffer, _texL, _texT);\
vertex_float2(__vertexBuffer, _glyphL, _glyphB); vertex_texcoord(__vertexBuffer, _texL, _texB);

#macro __SCRIBBLEJR_WRITE_EXT  ;\
vertex_float2(__vertexBuffer, _glyphL, _glyphB); vertex_colour(__vertexBuffer, _glyphColour, _glyphAlpha); vertex_texcoord(__vertexBuffer, _texL, _texB);\
vertex_float2(__vertexBuffer, _glyphR, _glyphB); vertex_colour(__vertexBuffer, _glyphColour, _glyphAlpha); vertex_texcoord(__vertexBuffer, _texR, _texB);\
vertex_float2(__vertexBuffer, _glyphR, _glyphT); vertex_colour(__vertexBuffer, _glyphColour, _glyphAlpha); vertex_texcoord(__vertexBuffer, _texR, _texT);\
vertex_float2(__vertexBuffer, _glyphR, _glyphT); vertex_colour(__vertexBuffer, _glyphColour, _glyphAlpha); vertex_texcoord(__vertexBuffer, _texR, _texT);\
vertex_float2(__vertexBuffer, _glyphL, _glyphT); vertex_colour(__vertexBuffer, _glyphColour, _glyphAlpha); vertex_texcoord(__vertexBuffer, _texL, _texT);\
vertex_float2(__vertexBuffer, _glyphL, _glyphB); vertex_colour(__vertexBuffer, _glyphColour, _glyphAlpha); vertex_texcoord(__vertexBuffer, _texL, _texB);

#macro __SCRIBBLEJR_CLASS_SET_PMA_SHADER  ;\
if (_system.__preMultipliedAlpha)\
{\
    __SCRIBBLEJR_SHADER_SET(__ScribblejrGetUsesSDF(__font)? __shdScribblejrPMA_SDF : __shdScribblejrPMA);\
}

#macro __SCRIBBLEJR_CLASS_RESET_PMA_SHADER  ;\
if (_system.__preMultipliedAlpha) __SCRIBBLEJR_SHADER_RESET();

#macro __SCRIBBLEJR_CLASS_SET_SDF_EFFECTS  font_enable_effects(__font, true, _sdfEffects);

#macro __SCRIBBLEJR_CLASS_RESET_SDF_EFFECTS  if (SCRIBBLEJR_AUTO_RESET_DRAW_STATE) font_enable_effects(__font, false);