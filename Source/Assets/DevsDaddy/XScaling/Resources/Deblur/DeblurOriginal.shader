Shader "Hidden/XScaling_Deblur_Original"
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
            #pragma fragment Fragment_Deblur_Original_Luma_0
            #include "../Common.hlsl"
            #include "DeblurOriginal.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Deblur_Original_Kernel_X_1
            #include "../Common.hlsl"
            #include "DeblurOriginal.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Deblur_Original_Kernel_Y_2
            #include "../Common.hlsl"
            #include "DeblurOriginal.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Deblur_Original_Kernel_X_3
            #include "../Common.hlsl"
            #include "DeblurOriginal.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Deblur_Original_Kernel_Y_4
            #include "../Common.hlsl"
            #include "DeblurOriginal.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Deblur_Original_Apply_5
            #include "../Common.hlsl"
            #include "DeblurOriginal.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Deblur_Original_Resample_6
            #include "../Common.hlsl"
            #include "DeblurOriginal.hlsl"
            ENDCG
        }
    }
}