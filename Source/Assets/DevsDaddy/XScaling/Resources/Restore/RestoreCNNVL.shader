Shader "Hidden/XScaling_Restore_CNN_VL"
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
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x3_0
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x3_1
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_2
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_3
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_4
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_5
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_6
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_7
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_8
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_9
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_10
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_11
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_12
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_13
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_14
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_4x3x3x16_15
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_VL_Conv_3x1x1x112_16
            #include "../Common.hlsl"
            #include "RestoreCNNVL.hlsl"
            ENDCG
        }
    }
}