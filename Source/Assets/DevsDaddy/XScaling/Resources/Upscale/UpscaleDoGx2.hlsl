Texture2D HOOKED;
float4 HOOKED_TexelSize;

float get_luma_Upscale_DoG_x2_Luma_0(float4 rgba) {
	return dot(float4(0.299, 0.587, 0.114, 0.0), rgba);
}

float4 hook_Upscale_DoG_x2_Luma_0(float2 uv) {
    return float4(get_luma_Upscale_DoG_x2_Luma_0(HOOKED.Sample(linear_clamp_sampler, uv)), 0.0, 0.0, 0.0);
}
float4 Fragment_Upscale_DoG_x2_Luma_0(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DoG_x2_Luma_0(texCoord);
}

Texture2D LINELUMA;
float4 LINELUMA_TexelSize;

// #define L_tex LINELUMA_tex

float max3v_Upscale_DoG_x2_Kernel_X_1(float a, float b, float c) {
	return max(max(a, b), c);
}
float min3v_Upscale_DoG_x2_Kernel_X_1(float a, float b, float c) {
	return min(min(a, b), c);
}

float2 minmax3_Upscale_DoG_x2_Kernel_X_1(float2 pos, float2 d) {
	float a = LINELUMA.Sample(linear_clamp_sampler, pos - d).x;
	float b = LINELUMA.Sample(linear_clamp_sampler, pos).x;
	float c = LINELUMA.Sample(linear_clamp_sampler, pos + d).x;
	
	return float2(min3v_Upscale_DoG_x2_Kernel_X_1(a, b, c), max3v_Upscale_DoG_x2_Kernel_X_1(a, b, c));
}

float lumGaussian7_Upscale_DoG_x2_Kernel_X_1(float2 pos, float2 d) {
	float g = (LINELUMA.Sample(linear_clamp_sampler, pos - (d + d)).x + LINELUMA.Sample(linear_clamp_sampler, pos + (d + d)).x) * 0.06136;
	g = g + (LINELUMA.Sample(linear_clamp_sampler, pos - d).x + LINELUMA.Sample(linear_clamp_sampler, pos + d).x) * 0.24477;
	g = g + (LINELUMA.Sample(linear_clamp_sampler, pos).x) * 0.38774;
	
	return g;
}


float4 hook_Upscale_DoG_x2_Kernel_X_1(float2 uv) {
    return float4(lumGaussian7_Upscale_DoG_x2_Kernel_X_1(uv, float2(HOOKED_TexelSize.xy.x, 0)), minmax3_Upscale_DoG_x2_Kernel_X_1(uv, float2(HOOKED_TexelSize.xy.x, 0)), 0);
}
float4 Fragment_Upscale_DoG_x2_Kernel_X_1(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DoG_x2_Kernel_X_1(texCoord);
}

Texture2D GAUSS_X2;
float4 GAUSS_X2_TexelSize;

// #define L_tex GAUSS_X2_tex

float max3v_Upscale_DoG_x2_Kernel_Y_2(float a, float b, float c) {
	return max(max(a, b), c);
}
float min3v_Upscale_DoG_x2_Kernel_Y_2(float a, float b, float c) {
	return min(min(a, b), c);
}

float2 minmax3_Upscale_DoG_x2_Kernel_Y_2(float2 pos, float2 d) {
	float a0 = GAUSS_X2.Sample(linear_clamp_sampler, pos - d).y;
	float b0 = GAUSS_X2.Sample(linear_clamp_sampler, pos).y;
	float c0 = GAUSS_X2.Sample(linear_clamp_sampler, pos + d).y;
	
	float a1 = GAUSS_X2.Sample(linear_clamp_sampler, pos - d).z;
	float b1 = GAUSS_X2.Sample(linear_clamp_sampler, pos).z;
	float c1 = GAUSS_X2.Sample(linear_clamp_sampler, pos + d).z;
	
	return float2(min3v_Upscale_DoG_x2_Kernel_Y_2(a0, b0, c0), max3v_Upscale_DoG_x2_Kernel_Y_2(a1, b1, c1));
}

float lumGaussian7_Upscale_DoG_x2_Kernel_Y_2(float2 pos, float2 d) {
	float g = (GAUSS_X2.Sample(linear_clamp_sampler, pos - (d + d)).x + GAUSS_X2.Sample(linear_clamp_sampler, pos + (d + d)).x) * 0.06136;
	g = g + (GAUSS_X2.Sample(linear_clamp_sampler, pos - d).x + GAUSS_X2.Sample(linear_clamp_sampler, pos + d).x) * 0.24477;
	g = g + (GAUSS_X2.Sample(linear_clamp_sampler, pos).x) * 0.38774;
	
	return g;
}


float4 hook_Upscale_DoG_x2_Kernel_Y_2(float2 uv) {
    return float4(lumGaussian7_Upscale_DoG_x2_Kernel_Y_2(uv, float2(0, HOOKED_TexelSize.xy.y)), minmax3_Upscale_DoG_x2_Kernel_Y_2(uv, float2(0, HOOKED_TexelSize.xy.y)), 0);
}
float4 Fragment_Upscale_DoG_x2_Kernel_Y_2(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DoG_x2_Kernel_Y_2(texCoord);
}

#define STRENGTH 0.8 //De-blur proportional strength, higher is sharper.

// #define L_tex LINELUMA_tex

float4 hook_Upscale_DoG_x2_Apply_3(float2 uv) {

	float c = (LINELUMA.Sample(linear_clamp_sampler, uv).x - GAUSS_X2.Sample(linear_clamp_sampler, uv).x) * STRENGTH;
	float cc = clamp(c + LINELUMA.Sample(linear_clamp_sampler, uv).x, GAUSS_X2.Sample(linear_clamp_sampler, uv).y, GAUSS_X2.Sample(linear_clamp_sampler, uv).z) - LINELUMA.Sample(linear_clamp_sampler, uv).x;
	
	//This trick is only possible if the inverse Y->RGB matrix has 1 for every row... (which is the case for BT.709)
	//Otherwise we would need to convert RGB to YUV, modify Y then convert back to RGB.
	return HOOKED.Sample(linear_clamp_sampler, uv) + cc;
}
float4 Fragment_Upscale_DoG_x2_Apply_3(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DoG_x2_Apply_3(texCoord);
}




