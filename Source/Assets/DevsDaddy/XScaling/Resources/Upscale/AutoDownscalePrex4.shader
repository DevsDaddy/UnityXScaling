Shader "Hidden/XScaling_AutoDownscalePre_x4"
{
    Properties
    {
        _MainTex("", 2D) = ""{}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_AutoDownscalePre_x4_0
            #include "../Common.hlsl"
            #include "AutoDownscalePrex4.hlsl"
            ENDCG
        }
    }
}
