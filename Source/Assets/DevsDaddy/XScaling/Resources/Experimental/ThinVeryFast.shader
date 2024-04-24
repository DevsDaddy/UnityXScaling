Shader "Hidden/XScaling_Thin_VeryFast"
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
            #pragma fragment Fragment_Thin_VeryFast_Luma_0
            #include "../Common.hlsl"
            #include "ThinVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_VeryFast_Sobel_X_1
            #include "../Common.hlsl"
            #include "ThinVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_VeryFast_Sobel_Y_2
            #include "../Common.hlsl"
            #include "ThinVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_VeryFast_Gaussian_X_3
            #include "../Common.hlsl"
            #include "ThinVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_VeryFast_Gaussian_Y_4
            #include "../Common.hlsl"
            #include "ThinVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_VeryFast_Kernel_X_5
            #include "../Common.hlsl"
            #include "ThinVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_VeryFast_Kernel_Y_6
            #include "../Common.hlsl"
            #include "ThinVeryFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_VeryFast_Warp_7
            #include "../Common.hlsl"
            #include "ThinVeryFast.hlsl"
            ENDCG
        }
    }
}