Shader "Hidden/XScaling_Restore_CNN_Soft_L"
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
            #pragma fragment Fragment_Restore_CNN_Soft_L_Conv_4x3x3x3_0
            #include "../Common.hlsl"
            #include "RestoreCNNSoftL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_Soft_L_Conv_4x3x3x3_1
            #include "../Common.hlsl"
            #include "RestoreCNNSoftL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_Soft_L_Conv_4x3x3x16_2
            #include "../Common.hlsl"
            #include "RestoreCNNSoftL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_Soft_L_Conv_4x3x3x16_3
            #include "../Common.hlsl"
            #include "RestoreCNNSoftL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_Soft_L_Conv_4x3x3x16_4
            #include "../Common.hlsl"
            #include "RestoreCNNSoftL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_Soft_L_Conv_4x3x3x16_5
            #include "../Common.hlsl"
            #include "RestoreCNNSoftL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_Soft_L_Conv_4x3x3x16_6
            #include "../Common.hlsl"
            #include "RestoreCNNSoftL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_Soft_L_Conv_4x3x3x16_7
            #include "../Common.hlsl"
            #include "RestoreCNNSoftL.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_Soft_L_Conv_3x3x3x16_8
            #include "../Common.hlsl"
            #include "RestoreCNNSoftL.hlsl"
            ENDCG
        }
    }
}