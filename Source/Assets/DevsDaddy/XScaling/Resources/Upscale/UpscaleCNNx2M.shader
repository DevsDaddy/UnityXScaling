Shader "Hidden/XScaling_Upscale_CNN_x2_M"
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
            #pragma fragment Fragment_Upscale_CNN_x2_M_Conv_4x3x3x3_0
            #include "../Common.hlsl"
            #include "UpscaleCNNx2M.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_CNN_x2_M_Conv_4x3x3x8_1
            #include "../Common.hlsl"
            #include "UpscaleCNNx2M.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_CNN_x2_M_Conv_4x3x3x8_2
            #include "../Common.hlsl"
            #include "UpscaleCNNx2M.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_CNN_x2_M_Conv_4x3x3x8_3
            #include "../Common.hlsl"
            #include "UpscaleCNNx2M.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_CNN_x2_M_Conv_4x3x3x8_4
            #include "../Common.hlsl"
            #include "UpscaleCNNx2M.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_CNN_x2_M_Conv_4x3x3x8_5
            #include "../Common.hlsl"
            #include "UpscaleCNNx2M.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_CNN_x2_M_Conv_4x3x3x8_6
            #include "../Common.hlsl"
            #include "UpscaleCNNx2M.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_CNN_x2_M_Conv_4x1x1x56_7
            #include "../Common.hlsl"
            #include "UpscaleCNNx2M.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_CNN_x2_M_Depth_to_Space_8
            #include "../Common.hlsl"
            #include "UpscaleCNNx2M.hlsl"
            ENDCG
        }
    }
}
