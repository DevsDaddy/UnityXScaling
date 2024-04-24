Texture2D HOOKED;
float4 HOOKED_TexelSize;

float get_luma_Darken_DoG_HQ_Luma_0(float4 rgba) {
	return dot(float4(0.299, 0.587, 0.114, 0.0), rgba);
}

float4 hook_Darken_DoG_HQ_Luma_0(float2 uv) {
    return float4(get_luma_Darken_DoG_HQ_Luma_0(HOOKED.Sample(linear_clamp_sampler, uv)), 0.0, 0.0, 0.0);
}
float4 Fragment_Darken_DoG_HQ_Luma_0(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Darken_DoG_HQ_Luma_0(texCoord);
}

Texture2D LINELUMA;
float4 LINELUMA_TexelSize;

#define SPATIAL_SIGMA (1.0 * float(HOOKED_TexelSize.zw.y) / 1080.0) //Spatial window size, must be a positive real number.

#define KERNELSIZE (max(int(ceil(SPATIAL_SIGMA * 2.0)), 1) * 2 + 1) //Kernel size, must be an positive odd integer.
#define KERNELHALFSIZE (int(KERNELSIZE/2)) //Half of the kernel size without remainder. Must be equal to trunc(KERNELSIZE/2).
#define KERNELLEN (KERNELSIZE * KERNELSIZE) //Total area of kernel. Must be equal to KERNELSIZE * KERNELSIZE.

float gaussian_Darken_DoG_HQ_Difference_X_1(float x, float s, float m) {
	float scaled = (x - m) / s;
	return exp(-0.5 * scaled * scaled);
}

float comp_gaussian_x_Darken_DoG_HQ_Difference_X_1(float2 uv) {

	float g = 0.0;
	float gn = 0.0;
	
	for (int i=0; i<KERNELSIZE; i++) {
		float di = float(i - KERNELHALFSIZE);
		float gf = gaussian_Darken_DoG_HQ_Difference_X_1(di, SPATIAL_SIGMA, 0.0);
		
		g = g + LINELUMA.Sample(linear_clamp_sampler, uv + float2(di, 0.0)).x * gf;
		gn = gn + gf;
		
	}
	
	return g / gn;
}

float4 hook_Darken_DoG_HQ_Difference_X_1(float2 uv) {
    return float4(comp_gaussian_x_Darken_DoG_HQ_Difference_X_1(uv), 0.0, 0.0, 0.0);
}
float4 Fragment_Darken_DoG_HQ_Difference_X_1(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Darken_DoG_HQ_Difference_X_1(texCoord);
}

Texture2D LINEKERNEL;
float4 LINEKERNEL_TexelSize;

#define SPATIAL_SIGMA (1.0 * float(HOOKED_TexelSize.zw.y) / 1080.0) //Spatial window size, must be a positive real number.

#define KERNELSIZE (max(int(ceil(SPATIAL_SIGMA * 2.0)), 1) * 2 + 1) //Kernel size, must be an positive odd integer.
#define KERNELHALFSIZE (int(KERNELSIZE/2)) //Half of the kernel size without remainder. Must be equal to trunc(KERNELSIZE/2).
#define KERNELLEN (KERNELSIZE * KERNELSIZE) //Total area of kernel. Must be equal to KERNELSIZE * KERNELSIZE.

float gaussian_Darken_DoG_HQ_Difference_Y_2(float x, float s, float m) {
	float scaled = (x - m) / s;
	return exp(-0.5 * scaled * scaled);
}

float comp_gaussian_y_Darken_DoG_HQ_Difference_Y_2(float2 uv) {

	float g = 0.0;
	float gn = 0.0;
	
	for (int i=0; i<KERNELSIZE; i++) {
		float di = float(i - KERNELHALFSIZE);
		float gf = gaussian_Darken_DoG_HQ_Difference_Y_2(di, SPATIAL_SIGMA, 0.0);
		
		g = g + LINEKERNEL.Sample(linear_clamp_sampler, uv + float2(0.0, di)).x * gf;
		gn = gn + gf;
		
	}
	
	return g / gn;
}

float4 hook_Darken_DoG_HQ_Difference_Y_2(float2 uv) {
    return float4(min(LINELUMA.Sample(linear_clamp_sampler, uv).x - comp_gaussian_y_Darken_DoG_HQ_Difference_Y_2(uv), 0.0), 0.0, 0.0, 0.0);
}
float4 Fragment_Darken_DoG_HQ_Difference_Y_2(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Darken_DoG_HQ_Difference_Y_2(texCoord);
}

#define SPATIAL_SIGMA (1.0 * float(HOOKED_TexelSize.zw.y) / 1080.0) //Spatial window size, must be a positive real number.

#define KERNELSIZE (max(int(ceil(SPATIAL_SIGMA * 2.0)), 1) * 2 + 1) //Kernel size, must be an positive odd integer.
#define KERNELHALFSIZE (int(KERNELSIZE/2)) //Half of the kernel size without remainder. Must be equal to trunc(KERNELSIZE/2).
#define KERNELLEN (KERNELSIZE * KERNELSIZE) //Total area of kernel. Must be equal to KERNELSIZE * KERNELSIZE.

float gaussian_Darken_DoG_HQ_Gaussian_X_3(float x, float s, float m) {
	float scaled = (x - m) / s;
	return exp(-0.5 * scaled * scaled);
}

float comp_gaussian_x_Darken_DoG_HQ_Gaussian_X_3(float2 uv) {

	float g = 0.0;
	float gn = 0.0;
	
	for (int i=0; i<KERNELSIZE; i++) {
		float di = float(i - KERNELHALFSIZE);
		float gf = gaussian_Darken_DoG_HQ_Gaussian_X_3(di, SPATIAL_SIGMA, 0.0);
		
		g = g + LINEKERNEL.Sample(linear_clamp_sampler, uv + float2(di, 0.0)).x * gf;
		gn = gn + gf;
		
	}
	
	return g / gn;
}

float4 hook_Darken_DoG_HQ_Gaussian_X_3(float2 uv) {
    return float4(comp_gaussian_x_Darken_DoG_HQ_Gaussian_X_3(uv), 0.0, 0.0, 0.0);
}
float4 Fragment_Darken_DoG_HQ_Gaussian_X_3(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Darken_DoG_HQ_Gaussian_X_3(texCoord);
}

#define SPATIAL_SIGMA (1.0 * float(HOOKED_TexelSize.zw.y) / 1080.0) //Spatial window size, must be a positive real number.

#define KERNELSIZE (max(int(ceil(SPATIAL_SIGMA * 2.0)), 1) * 2 + 1) //Kernel size, must be an positive odd integer.
#define KERNELHALFSIZE (int(KERNELSIZE/2)) //Half of the kernel size without remainder. Must be equal to trunc(KERNELSIZE/2).
#define KERNELLEN (KERNELSIZE * KERNELSIZE) //Total area of kernel. Must be equal to KERNELSIZE * KERNELSIZE.

float gaussian_Darken_DoG_HQ_Gaussian_Y_4(float x, float s, float m) {
	float scaled = (x - m) / s;
	return exp(-0.5 * scaled * scaled);
}

float comp_gaussian_y_Darken_DoG_HQ_Gaussian_Y_4(float2 uv) {

	float g = 0.0;
	float gn = 0.0;
	
	for (int i=0; i<KERNELSIZE; i++) {
		float di = float(i - KERNELHALFSIZE);
		float gf = gaussian_Darken_DoG_HQ_Gaussian_Y_4(di, SPATIAL_SIGMA, 0.0);
		
		g = g + LINEKERNEL.Sample(linear_clamp_sampler, uv + float2(0.0, di)).x * gf;
		gn = gn + gf;
		
	}
	
	return g / gn;
}



#define STRENGTH 1.5 //Line darken proportional strength, higher is darker.

float4 hook_Darken_DoG_HQ_Gaussian_Y_4(float2 uv) {
	//This trick is only possible if the inverse Y->RGB matrix has 1 for every row... (which is the case for BT.709)
	//Otherwise we would need to convert RGB to YUV, modify Y then convert back to RGB.
    return HOOKED.Sample(linear_clamp_sampler, uv) + (comp_gaussian_y_Darken_DoG_HQ_Gaussian_Y_4(uv) * STRENGTH);
}
float4 Fragment_Darken_DoG_HQ_Gaussian_Y_4(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Darken_DoG_HQ_Gaussian_Y_4(texCoord);
}