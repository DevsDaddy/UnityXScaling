#include "UnityCG.cginc"

Texture2D _MainTex;
float4 _MainTex_TexelSize;
SamplerState point_clamp_sampler;
SamplerState linear_clamp_sampler;

void Vertex(
    float4 position : POSITION,
    float2 texCoord : TEXCOORD,
    out float4 outPosition : SV_Position,
    out float2 outTexCoord : TEXCOORD
)
{
    outPosition = UnityObjectToClipPos(position);
    outTexCoord = texCoord;
}