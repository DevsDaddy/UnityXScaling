Shader "Hidden/XScaling_Restore_CNN_M"
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
            #pragma fragment Fragment_Restore_CNN_M_Conv_4x3x3x3_0
            #include "../Common.hlsl"
            #include "RestoreCNNM.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_M_Conv_4x3x3x8_1
            #include "../Common.hlsl"
            #include "RestoreCNNM.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_M_Conv_4x3x3x8_2
            #include "../Common.hlsl"
            #include "RestoreCNNM.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_M_Conv_4x3x3x8_3
            #include "../Common.hlsl"
            #include "RestoreCNNM.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_M_Conv_4x3x3x8_4
            #include "../Common.hlsl"
            #include "RestoreCNNM.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_M_Conv_4x3x3x8_5
            #include "../Common.hlsl"
            #include "RestoreCNNM.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_M_Conv_4x3x3x8_6
            #include "../Common.hlsl"
            #include "RestoreCNNM.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_M_Conv_3x1x1x56_7
            #include "../Common.hlsl"
            #include "RestoreCNNM.hlsl"
            ENDCG
        }
    }
}