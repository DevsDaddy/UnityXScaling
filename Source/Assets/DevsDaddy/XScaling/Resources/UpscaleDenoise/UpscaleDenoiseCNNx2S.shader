Shader "Hidden/XScaling_Upscale_Denoise_CNN_x2_S"
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
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_S_Conv_4x3x3x3_0
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2S.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_S_Conv_4x3x3x8_1
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2S.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_S_Conv_4x3x3x8_2
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2S.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_S_Conv_4x3x3x8_3
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2S.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_Denoise_CNN_x2_S_Depth_to_Space_4
            #include "../Common.hlsl"
            #include "UpscaleDenoiseCNNx2S.hlsl"
            ENDCG
        }
    }
}
