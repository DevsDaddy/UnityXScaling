Shader "Hidden/XScaling_Denoise_Bilateral_Median"
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
            #pragma fragment Fragment_Denoise_Bilateral_Median_Luma_0
            #include "../Common.hlsl"
            #include "DenoiseBilateralMedian.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Denoise_Bilateral_Median_Apply_1
            #include "../Common.hlsl"
            #include "DenoiseBilateralMedian.hlsl"
            ENDCG
        }
    }
}