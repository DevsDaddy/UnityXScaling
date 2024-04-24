Shader "Hidden/XScaling_Upscale_Denoise_CNN_x2_VL"
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
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x3_0
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x3_1
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_2
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_3
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_4
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_5
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_6
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_7
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_8
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_9
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_10
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_11
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_12
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x3x3x16_13
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x1x1x112_14
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x1x1x112_15
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Conv_4x1x1x112_16
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_VL_Depth_to_Space_17
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2VL.hlsl"
            ENDCG
        }
    }
}
