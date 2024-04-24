Shader "Hidden/XScaling_Upscale_Denoise_CNN_x2_UL"
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
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x3_0
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x3_1
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x3_2
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_3
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_4
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_5
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_6
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_7
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_8
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_9
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_10
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_11
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_12
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_13
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_14
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_15
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_16
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_17
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_18
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_19
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x3x3x24_20
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x1x1x120_21
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x1x1x120_22
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Conv_4x1x1x120_23
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_UL_Depth_to_Space_24
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2UL.hlsl"
            ENDCG
        }
    }
}
