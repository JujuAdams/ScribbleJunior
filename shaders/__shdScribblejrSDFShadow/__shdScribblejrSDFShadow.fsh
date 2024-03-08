varying float v_fAlpha;
varying vec2  v_vTexcoord;

uniform vec4 u_vData;

void main()
{
    float sdfDistance = texture2D(gm_BaseTexture, v_vTexcoord).a;
    float range = max(fwidth(sdfDistance), 0.001) / sqrt(2.0);
    range = mix(range, 0.5, u_vData.w);
    float alpha = smoothstep(0.5 - range, 0.5 + range, sdfDistance);   
    
    gl_FragColor = vec4(u_vData.rgb, alpha*v_fAlpha);
}
