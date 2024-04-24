Texture2D HOOKED;
float4 HOOKED_TexelSize;

float get_luma_Thin_HQ_Luma_0(float4 rgba) {
	return dot(float4(0.299, 0.587, 0.114, 0.0), rgba);
}

float4 hook_Thin_HQ_Luma_0(float2 uv) {
    return float4(get_luma_Thin_HQ_Luma_0(HOOKED.Sample(linear_clamp_sampler, uv)), 0.0, 0.0, 0.0);
}
float4 Fragment_Thin_HQ_Luma_0(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Thin_HQ_Luma_0(texCoord);
}

Texture2D LINELUMA;
float4 LINELUMA_TexelSize;

float4 hook_Thin_HQ_Sobel_X_1(float2 uv) {
	float l = LINELUMA.Sample(linear_clamp_sampler, uv + float2(-1.0, 0.0)).x;
	float c = LINELUMA.Sample(linear_clamp_sampler, uv).x;
	float r = LINELUMA.Sample(linear_clamp_sampler, uv + float2(1.0, 0.0)).x;
	
	float xgrad = (-l + r);
	float ygrad = (l + c + c + r);
	
	return float4(xgrad, ygrad, 0.0, 0.0);
}
float4 Fragment_Thin_HQ_Sobel_X_1(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Thin_HQ_Sobel_X_1(texCoord);
}

Texture2D LINESOBEL;
float4 LINESOBEL_TexelSize;

float4 hook_Thin_HQ_Sobel_Y_2(float2 uv) {
	float tx = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(0.0, -1.0)).x;
	float cx = LINESOBEL.Sample(linear_clamp_sampler, uv).x;
	float bx = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(0.0, 1.0)).x;
	
	float ty = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(0.0, -1.0)).y;
	float by = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(0.0, 1.0)).y;
	
	float xgrad = (tx + cx + cx + bx) / 8.0;
	
	float ygrad = (-ty + by) / 8.0;
	
	//Computes the luminance's gradient
	float norm = sqrt(xgrad * xgrad + ygrad * ygrad);
	return float4(pow(norm, 0.7).xxxx);
}
float4 Fragment_Thin_HQ_Sobel_Y_2(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Thin_HQ_Sobel_Y_2(texCoord);
}

#define SPATIAL_SIGMA (2.0 * float(HOOKED_TexelSize.zw.y) / 1080.0) //Spatial window size, must be a positive real number.

#define KERNELSIZE (max(int(ceil(SPATIAL_SIGMA * 2.0)), 1) * 2 + 1) //Kernel size, must be an positive odd integer.
#define KERNELHALFSIZE (int(KERNELSIZE/2)) //Half of the kernel size without remainder. Must be equal to trunc(KERNELSIZE/2).
#define KERNELLEN (KERNELSIZE * KERNELSIZE) //Total area of kernel. Must be equal to KERNELSIZE * KERNELSIZE.

float gaussian_Thin_HQ_Gaussian_X_3(float x, float s, float m) {
	float scaled = (x - m) / s;
	return exp(-0.5 * scaled * scaled);
}

float comp_gaussian_x_Thin_HQ_Gaussian_X_3(float2 uv) {

	float g = 0.0;
	float gn = 0.0;
	
	for (int i=0; i<KERNELSIZE; i++) {
		float di = float(i - KERNELHALFSIZE);
		float gf = gaussian_Thin_HQ_Gaussian_X_3(di, SPATIAL_SIGMA, 0.0);
		
		g = g + LINESOBEL.Sample(linear_clamp_sampler, uv + float2(di, 0.0)).x * gf;
		gn = gn + gf;
		
	}
	
	return g / gn;
}

float4 hook_Thin_HQ_Gaussian_X_3(float2 uv) {
    return float4(comp_gaussian_x_Thin_HQ_Gaussian_X_3(uv), 0.0, 0.0, 0.0);
}
float4 Fragment_Thin_HQ_Gaussian_X_3(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Thin_HQ_Gaussian_X_3(texCoord);
}

#define SPATIAL_SIGMA (2.0 * float(HOOKED_TexelSize.zw.y) / 1080.0) //Spatial window size, must be a positive real number.

#define KERNELSIZE (max(int(ceil(SPATIAL_SIGMA * 2.0)), 1) * 2 + 1) //Kernel size, must be an positive odd integer.
#define KERNELHALFSIZE (int(KERNELSIZE/2)) //Half of the kernel size without remainder. Must be equal to trunc(KERNELSIZE/2).
#define KERNELLEN (KERNELSIZE * KERNELSIZE) //Total area of kernel. Must be equal to KERNELSIZE * KERNELSIZE.

float gaussian_Thin_HQ_Gaussian_Y_4(float x, float s, float m) {
	float scaled = (x - m) / s;
	return exp(-0.5 * scaled * scaled);
}

float comp_gaussian_y_Thin_HQ_Gaussian_Y_4(float2 uv) {

	float g = 0.0;
	float gn = 0.0;
	
	for (int i=0; i<KERNELSIZE; i++) {
		float di = float(i - KERNELHALFSIZE);
		float gf = gaussian_Thin_HQ_Gaussian_Y_4(di, SPATIAL_SIGMA, 0.0);
		
		g = g + LINESOBEL.Sample(linear_clamp_sampler, uv + float2(0.0, di)).x * gf;
		gn = gn + gf;
		
	}
	
	return g / gn;
}

float4 hook_Thin_HQ_Gaussian_Y_4(float2 uv) {
    return float4(comp_gaussian_y_Thin_HQ_Gaussian_Y_4(uv), 0.0, 0.0, 0.0);
}
float4 Fragment_Thin_HQ_Gaussian_Y_4(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Thin_HQ_Gaussian_Y_4(texCoord);
}

float4 hook_Thin_HQ_Kernel_X_5(float2 uv) {
	float l = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(-1.0, 0.0)).x;
	float c = LINESOBEL.Sample(linear_clamp_sampler, uv).x;
	float r = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(1.0, 0.0)).x;
	
	float xgrad = (-l + r);
	float ygrad = (l + c + c + r);
	
	return float4(xgrad, ygrad, 0.0, 0.0);
}
float4 Fragment_Thin_HQ_Kernel_X_5(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Thin_HQ_Kernel_X_5(texCoord);
}

float4 hook_Thin_HQ_Kernel_Y_6(float2 uv) {
	float tx = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(0.0, -1.0)).x;
	float cx = LINESOBEL.Sample(linear_clamp_sampler, uv).x;
	float bx = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(0.0, 1.0)).x;
	
	float ty = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(0.0, -1.0)).y;
	float by = LINESOBEL.Sample(linear_clamp_sampler, uv + float2(0.0, 1.0)).y;
	
	float xgrad = (tx + cx + cx + bx) / 8.0;
	
	float ygrad = (-ty + by) / 8.0;
	
	//Computes the luminance's gradient
	return float4(xgrad, ygrad, 0.0, 0.0);
}
float4 Fragment_Thin_HQ_Kernel_Y_6(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Thin_HQ_Kernel_Y_6(texCoord);
}

#define STRENGTH 0.6 //Strength of warping for each iteration
#define ITERATIONS 1 //Number of iterations for the forwards solver, decreasing strength and increasing iterations improves quality at the cost of speed.

float4 hook_Thin_HQ_Warp_7(float2 uv) {
	float2 d = HOOKED_TexelSize.xy;
	
	float relstr = HOOKED_TexelSize.zw.y / 1080.0 * STRENGTH;
	
	float2 pos = uv;
	for (int i=0; i<ITERATIONS; i++) {
		float2 dn = LINESOBEL.Sample(linear_clamp_sampler, pos).xy;
		float2 dd = (dn / (length(dn) + 0.01)) * d * relstr; //Quasi-normalization for large vectors, avoids divide by zero
		pos -= dd;
	}
	
	return HOOKED.Sample(linear_clamp_sampler, pos);
	
}
float4 Fragment_Thin_HQ_Warp_7(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Thin_HQ_Warp_7(texCoord);
}