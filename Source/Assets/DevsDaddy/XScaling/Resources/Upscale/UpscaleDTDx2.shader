Shader "Hidden/XScaling_Upscale_DTD_x2"
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
            #pragma fragment Fragment_Upscale_DTD_x2_Luma_0
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_X_1
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_Y_2
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_X_3
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_Y_4
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_5
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Luma_6
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_X_7
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_Y_8
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_X_9
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_Y_10
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_X_11
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_Y_12
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_13
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Luma_14
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_X_15
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_Kernel_Y_16
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DTD_x2_17
            #include "../Common.hlsl"
            #include "UpscaleDTDx2.hlsl"
            ENDCG
        }
    }
}
