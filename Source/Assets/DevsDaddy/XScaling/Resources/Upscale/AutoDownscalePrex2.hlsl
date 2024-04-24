Texture2D HOOKED;
float4 HOOKED_TexelSize;
Texture2D NATIVE;
float4 NATIVE_TexelSize;

float4 hook_AutoDownscalePre_x2_0(float2 uv) {
	return HOOKED.Sample(linear_clamp_sampler, uv);
}
float4 Fragment_AutoDownscalePre_x2_0(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_AutoDownscalePre_x2_0(texCoord);
}

