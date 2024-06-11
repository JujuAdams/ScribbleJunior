varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform int u_iPMA;

void main()
{
    float sdfDistance = texture2D(gm_BaseTexture, v_vTexcoord).a;
    float range = max(fwidth(sdfDistance), 0.001) / sqrt(2.0);
    float alpha = smoothstep(0.5 - range, 0.5 + range, sdfDistance);   
    gl_FragColor = vec4(v_vColour.rgb, alpha*v_vColour.a);
    
    if (u_iPMA > 0) gl_FragColor.rgb *= gl_FragColor.a;
}
