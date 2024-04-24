Shader "Hidden/XScaling_Darken_Fast"
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
            #pragma fragment Fragment_Darken_DoG_HQ_Luma_0
            #include "../Common.hlsl"
            #include "DarkenFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_Fast_Difference_X_1
            #include "../Common.hlsl"
            #include "DarkenFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_Fast_Difference_Y_2
            #include "../Common.hlsl"
            #include "DarkenFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_Fast_Gaussian_X_3
            #include "../Common.hlsl"
            #include "DarkenFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_Fast_Gaussian_Y_4
            #include "../Common.hlsl"
            #include "DarkenFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_Fast_Upsample_5
            #include "../Common.hlsl"
            #include "DarkenFast.hlsl"
            ENDCG
        }
    }
}