Texture2D HOOKED;
float4 HOOKED_TexelSize;

#define KERNELSIZE 5 //Kernel size, must be an positive odd integer.
#define KERNELHALFSIZE 2 //Half of the kernel size without remainder. Must be equal to trunc(KERNELSIZE/2).

float get_luma_De_Ring_Compute_Statistics_0(float4 rgba) {
	return dot(float4(0.299, 0.587, 0.114, 0.0), rgba);
}

float4 hook_De_Ring_Compute_Statistics_0(float2 uv) {

	float gmax = 0.0;
	
	for (int i=0; i<KERNELSIZE; i++) {
		float g = get_luma_De_Ring_Compute_Statistics_0(_MainTex.Sample(linear_clamp_sampler, uv + float2(i - KERNELHALFSIZE, 0)));
		
		gmax = max(g, gmax);
	}
	
	return float4(gmax, 0.0, 0.0, 0.0);
}
float4 Fragment_De_Ring_Compute_Statistics_0(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_De_Ring_Compute_Statistics_0(texCoord);
}

Texture2D STATSMAX;
float4 STATSMAX_TexelSize;

#define KERNELSIZE 5 //Kernel size, must be an positive odd integer.
#define KERNELHALFSIZE 2 //Half of the kernel size without remainder. Must be equal to trunc(KERNELSIZE/2).

float4 hook_De_Ring_Compute_Statistics_1(float2 uv) {

	float gmax = 0.0;
	
	for (int i=0; i<KERNELSIZE; i++) {
		float g = STATSMAX.Sample(linear_clamp_sampler, uv + float2(0, i - KERNELHALFSIZE)).x;
		
		gmax = max(g, gmax);
	}
	
	return float4(gmax, 0.0, 0.0, 0.0);
}
float4 Fragment_De_Ring_Compute_Statistics_1(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_De_Ring_Compute_Statistics_1(texCoord);
}

float get_luma_De_Ring_Clamp_2(float4 rgba) {
	return dot(float4(0.299, 0.587, 0.114, 0.0), rgba);
}

float4 hook_De_Ring_Clamp_2(float2 uv) {

	float current_luma = get_luma_De_Ring_Clamp_2(HOOKED.Sample(linear_clamp_sampler, uv));
	float new_luma = min(current_luma, STATSMAX.Sample(linear_clamp_sampler, uv).x);
	
	//This trick is only possible if the inverse Y->RGB matrix has 1 for every row... (which is the case for BT.709)
	//Otherwise we would need to convert RGB to YUV, modify Y then convert back to RGB.
    return HOOKED.Sample(linear_clamp_sampler, uv) - (current_luma - new_luma); 
}
float4 Fragment_De_Ring_Clamp_2(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_De_Ring_Clamp_2(texCoord);
}