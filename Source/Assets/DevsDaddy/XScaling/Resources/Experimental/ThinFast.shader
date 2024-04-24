Shader "Hidden/XScaling_Thin_Fast"
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
            #pragma fragment Fragment_Thin_Fast_Luma_0
            #include "../Common.hlsl"
            #include "ThinFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_Fast_Sobel_X_1
            #include "../Common.hlsl"
            #include "ThinFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_Fast_Sobel_Y_2
            #include "../Common.hlsl"
            #include "ThinFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_Fast_Gaussian_X_3
            #include "../Common.hlsl"
            #include "ThinFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_Fast_Gaussian_Y_4
            #include "../Common.hlsl"
            #include "ThinFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_Fast_Kernel_X_5
            #include "../Common.hlsl"
            #include "ThinFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_Fast_Kernel_Y_6
            #include "../Common.hlsl"
            #include "ThinFast.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_Fast_Warp_7
            #include "../Common.hlsl"
            #include "ThinFast.hlsl"
            ENDCG
        }
    }
}