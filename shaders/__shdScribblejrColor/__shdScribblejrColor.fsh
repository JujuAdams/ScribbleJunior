varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform int u_iPMA;

void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    
    if (u_iPMA > 0) gl_FragColor.rgb *= gl_FragColor.a;
}
