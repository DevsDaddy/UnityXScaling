Shader "Hidden/XScaling_Upscale_DoG_x2"
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
            #pragma fragment Fragment_Upscale_DoG_x2_Luma_0
            #include "../Common.hlsl"
            #include "UpscaleDoGx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DoG_x2_Kernel_X_1
            #include "../Common.hlsl"
            #include "UpscaleDoGx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DoG_x2_Kernel_Y_2
            #include "../Common.hlsl"
            #include "UpscaleDoGx2.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Upscale_DoG_x2_Apply_3
            #include "../Common.hlsl"
            #include "UpscaleDoGx2.hlsl"
            ENDCG
        }
    }
}
