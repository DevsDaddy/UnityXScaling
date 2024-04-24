Shader "Hidden/XScaling_Restore_CNN_S"
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
            #pragma fragment Fragment_Restore_CNN_S_Conv_4x3x3x3_0
            #include "../Common.hlsl"
            #include "RestoreCNNS.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_S_Conv_4x3x3x8_1
            #include "../Common.hlsl"
            #include "RestoreCNNS.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_S_Conv_4x3x3x8_2
            #include "../Common.hlsl"
            #include "RestoreCNNS.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Restore_CNN_S_Conv_3x3x3x8_3
            #include "../Common.hlsl"
            #include "RestoreCNNS.hlsl"
            ENDCG
        }
    }
}