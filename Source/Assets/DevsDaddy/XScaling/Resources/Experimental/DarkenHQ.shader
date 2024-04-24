Shader "Hidden/XScaling_Darken_HQ"
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
            #pragma fragment Fragment_Darken_DoG_HQ_Luma_0
            #include "../Common.hlsl"
            #include "DarkenHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_HQ_Difference_X_1
            #include "../Common.hlsl"
            #include "DarkenHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_HQ_Difference_Y_2
            #include "../Common.hlsl"
            #include "DarkenHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_HQ_Gaussian_X_3
            #include "../Common.hlsl"
            #include "DarkenHQ.hlsl"
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment_Darken_DoG_HQ_Gaussian_Y_4
            #include "../Common.hlsl"
            #include "DarkenHQ.hlsl"
            ENDCG
        }
    }
}