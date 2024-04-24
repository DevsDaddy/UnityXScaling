Shader "Hidden/XScaling_Denoise_Bilateral_Mean"
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
            #pragma fragment Fragment_Denoise_Bilateral_Mean_0
            #include "../Common.hlsl"
            #include "DenoiseBilateralMean.hlsl"
            ENDCG
        }
    }
}