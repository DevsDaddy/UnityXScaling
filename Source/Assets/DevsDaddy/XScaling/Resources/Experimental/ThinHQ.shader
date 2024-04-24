Shader "Hidden/XScaling_Thin_HQ"
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
            #pragma fragment Fragment_Thin_HQ_Luma_0
            #include "../Common.hlsl"
            #include "ThinHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_HQ_Sobel_X_1
            #include "../Common.hlsl"
            #include "ThinHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_HQ_Sobel_Y_2
            #include "../Common.hlsl"
            #include "ThinHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_HQ_Gaussian_X_3
            #include "../Common.hlsl"
            #include "ThinHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_HQ_Gaussian_Y_4
            #include "../Common.hlsl"
            #include "ThinHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_HQ_Kernel_X_5
            #include "../Common.hlsl"
            #include "ThinHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_HQ_Kernel_Y_6
            #include "../Common.hlsl"
            #include "ThinHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Thin_HQ_Warp_7
            #include "../Common.hlsl"
            #include "ThinHQ.hlsl"
            ENDCG
        }
    }
}