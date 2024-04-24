Shader "Hidden/XScaling_Darken_VeryFast"
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
            #include "DarkenVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_VeryFast_Gaussian_X_1
            #include "../Common.hlsl"
            #include "DarkenVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_VeryFast_Gaussian_Y_2
            #include "../Common.hlsl"
            #include "DarkenVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_VeryFast_Gaussian_X_3
            #include "../Common.hlsl"
            #include "DarkenVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_VeryFast_Gaussian_Y_4
            #include "../Common.hlsl"
            #include "DarkenVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_VeryFast_Upsample_5
            #include "../Common.hlsl"
            #include "DarkenVeryFast.hlsl"
            ENDCG
        }
    }
}