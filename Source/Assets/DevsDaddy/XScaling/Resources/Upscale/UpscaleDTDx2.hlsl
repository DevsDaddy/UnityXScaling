Texture2D HOOKED;
float4 HOOKED_TexelSize;

float get_luma_Upscale_DTD_x2_Luma_0(float4 rgba) {
	return dot(float4(0.299, 0.587, 0.114, 0.0), rgba);
}

float4 hook_Upscale_DTD_x2_Luma_0(float2 uv) {
    return float4(get_luma_Upscale_DTD_x2_Luma_0(HOOKED.Sample(linear_clamp_sampler, uv)), 0.0, 0.0, 0.0);
}
float4 Fragment_Upscale_DTD_x2_Luma_0(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Luma_0(texCoord);
}

Texture2D LINELUMA;
float4 LINELUMA_TexelSize;

// #define L_tex LINELUMA_tex

#define SIGMA 1.0

float gaussian_Upscale_DTD_x2_Kernel_X_1(float x, float s, float m) {
	return (1.0 / (s * sqrt(2.0 * 3.14159))) * exp(-0.5 * pow(abs(x - m) / s, 2.0));
}

float lumGaussian_Upscale_DTD_x2_Kernel_X_1(float2 pos, float2 d) {
	float s = SIGMA * HOOKED_TexelSize.zw.y / 1080.0;
	float kernel_size = s * 2.0 + 1.0;
	
	float g = (LINELUMA.Sample(linear_clamp_sampler, pos).x) * gaussian_Upscale_DTD_x2_Kernel_X_1(0.0, s, 0.0);
	float gn = gaussian_Upscale_DTD_x2_Kernel_X_1(0.0, s, 0.0);
	
	g += (LINELUMA.Sample(linear_clamp_sampler, pos - d).x + LINELUMA.Sample(linear_clamp_sampler, pos + d).x) * gaussian_Upscale_DTD_x2_Kernel_X_1(1.0, s, 0.0);
	gn += gaussian_Upscale_DTD_x2_Kernel_X_1(1.0, s, 0.0) * 2.0;
	
	for (int i=2; float(i)<kernel_size; i++) {
		g += (LINELUMA.Sample(linear_clamp_sampler, pos - (d * float(i))).x + LINELUMA.Sample(linear_clamp_sampler, pos + (d * float(i))).x) * gaussian_Upscale_DTD_x2_Kernel_X_1(float(i), s, 0.0);
		gn += gaussian_Upscale_DTD_x2_Kernel_X_1(float(i), s, 0.0) * 2.0;
	}
	
	return g / gn;
}

float4 hook_Upscale_DTD_x2_Kernel_X_1(float2 uv) {
    return float4(lumGaussian_Upscale_DTD_x2_Kernel_X_1(uv, float2(HOOKED_TexelSize.xy.x, 0)).xxxx);
}
float4 Fragment_Upscale_DTD_x2_Kernel_X_1(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_X_1(texCoord);
}

Texture2D MMKERNEL;
float4 MMKERNEL_TexelSize;

// #define L_tex MMKERNEL_tex

#define SIGMA 1.0

float gaussian_Upscale_DTD_x2_Kernel_Y_2(float x, float s, float m) {
	return (1.0 / (s * sqrt(2.0 * 3.14159))) * exp(-0.5 * pow(abs(x - m) / s, 2.0));
}

float lumGaussian_Upscale_DTD_x2_Kernel_Y_2(float2 pos, float2 d) {
	float s = SIGMA * HOOKED_TexelSize.zw.y / 1080.0;
	float kernel_size = s * 2.0 + 1.0;
	
	float g = (MMKERNEL.Sample(linear_clamp_sampler, pos).x) * gaussian_Upscale_DTD_x2_Kernel_Y_2(0.0, s, 0.0);
	float gn = gaussian_Upscale_DTD_x2_Kernel_Y_2(0.0, s, 0.0);
	
	g += (MMKERNEL.Sample(linear_clamp_sampler, pos - d).x + MMKERNEL.Sample(linear_clamp_sampler, pos + d).x) * gaussian_Upscale_DTD_x2_Kernel_Y_2(1.0, s, 0.0);
	gn += gaussian_Upscale_DTD_x2_Kernel_Y_2(1.0, s, 0.0) * 2.0;
	
	for (int i=2; float(i)<kernel_size; i++) {
		g += (MMKERNEL.Sample(linear_clamp_sampler, pos - (d * float(i))).x + MMKERNEL.Sample(linear_clamp_sampler, pos + (d * float(i))).x) * gaussian_Upscale_DTD_x2_Kernel_Y_2(float(i), s, 0.0);
		gn += gaussian_Upscale_DTD_x2_Kernel_Y_2(float(i), s, 0.0) * 2.0;
	}
	
	return g / gn;
}

float4 hook_Upscale_DTD_x2_Kernel_Y_2(float2 uv) {
    return float4(min(LINELUMA.Sample(linear_clamp_sampler, uv).x - lumGaussian_Upscale_DTD_x2_Kernel_Y_2(uv, float2(0, HOOKED_TexelSize.xy.y)), 0.0).xxxx);
}
float4 Fragment_Upscale_DTD_x2_Kernel_Y_2(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_Y_2(texCoord);
}

// #define L_tex MMKERNEL_tex

#define SIGMA 0.4

float gaussian_Upscale_DTD_x2_Kernel_X_3(float x, float s, float m) {
	return (1.0 / (s * sqrt(2.0 * 3.14159))) * exp(-0.5 * pow(abs(x - m) / s, 2.0));
}

float lumGaussian_Upscale_DTD_x2_Kernel_X_3(float2 pos, float2 d) {
	float s = SIGMA * HOOKED_TexelSize.zw.y / 1080.0;
	float kernel_size = s * 2.0 + 1.0;
	
	float g = (MMKERNEL.Sample(linear_clamp_sampler, pos).x) * gaussian_Upscale_DTD_x2_Kernel_X_3(0.0, s, 0.0);
	float gn = gaussian_Upscale_DTD_x2_Kernel_X_3(0.0, s, 0.0);
	
	g += (MMKERNEL.Sample(linear_clamp_sampler, pos - d).x + MMKERNEL.Sample(linear_clamp_sampler, pos + d).x) * gaussian_Upscale_DTD_x2_Kernel_X_3(1.0, s, 0.0);
	gn += gaussian_Upscale_DTD_x2_Kernel_X_3(1.0, s, 0.0) * 2.0;
	
	for (int i=2; float(i)<kernel_size; i++) {
		g += (MMKERNEL.Sample(linear_clamp_sampler, pos - (d * float(i))).x + MMKERNEL.Sample(linear_clamp_sampler, pos + (d * float(i))).x) * gaussian_Upscale_DTD_x2_Kernel_X_3(float(i), s, 0.0);
		gn += gaussian_Upscale_DTD_x2_Kernel_X_3(float(i), s, 0.0) * 2.0;
	}
	
	return g / gn;
}

float4 hook_Upscale_DTD_x2_Kernel_X_3(float2 uv) {
    return float4(lumGaussian_Upscale_DTD_x2_Kernel_X_3(uv, float2(HOOKED_TexelSize.xy.x, 0)).xxxx);
}
float4 Fragment_Upscale_DTD_x2_Kernel_X_3(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_X_3(texCoord);
}

// #define L_tex MMKERNEL_tex

#define SIGMA 0.4

float gaussian_Upscale_DTD_x2_Kernel_Y_4(float x, float s, float m) {
	return (1.0 / (s * sqrt(2.0 * 3.14159))) * exp(-0.5 * pow(abs(x - m) / s, 2.0));
}

float lumGaussian_Upscale_DTD_x2_Kernel_Y_4(float2 pos, float2 d) {
	float s = SIGMA * HOOKED_TexelSize.zw.y / 1080.0;
	float kernel_size = s * 2.0 + 1.0;
	
	float g = (MMKERNEL.Sample(linear_clamp_sampler, pos).x) * gaussian_Upscale_DTD_x2_Kernel_Y_4(0.0, s, 0.0);
	float gn = gaussian_Upscale_DTD_x2_Kernel_Y_4(0.0, s, 0.0);
	
	g += (MMKERNEL.Sample(linear_clamp_sampler, pos - d).x + MMKERNEL.Sample(linear_clamp_sampler, pos + d).x) * gaussian_Upscale_DTD_x2_Kernel_Y_4(1.0, s, 0.0);
	gn += gaussian_Upscale_DTD_x2_Kernel_Y_4(1.0, s, 0.0) * 2.0;
	
	for (int i=2; float(i)<kernel_size; i++) {
		g += (MMKERNEL.Sample(linear_clamp_sampler, pos - (d * float(i))).x + MMKERNEL.Sample(linear_clamp_sampler, pos + (d * float(i))).x) * gaussian_Upscale_DTD_x2_Kernel_Y_4(float(i), s, 0.0);
		gn += gaussian_Upscale_DTD_x2_Kernel_Y_4(float(i), s, 0.0) * 2.0;
	}
	
	return g / gn;
}

float4 hook_Upscale_DTD_x2_Kernel_Y_4(float2 uv) {
    return float4(lumGaussian_Upscale_DTD_x2_Kernel_Y_4(uv, float2(0, HOOKED_TexelSize.xy.y)).xxxx);
}
float4 Fragment_Upscale_DTD_x2_Kernel_Y_4(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_Y_4(texCoord);
}

#define STRENGTH 1.8 //Line darken proportional strength, higher is darker.

float4 hook_Upscale_DTD_x2_5(float2 uv) {
	float c = (MMKERNEL.Sample(linear_clamp_sampler, uv).x) * STRENGTH;
	//This trick is only possible if the inverse Y->RGB matrix has 1 for every row... (which is the case for BT.709)
	//Otherwise we would need to convert RGB to YUV, modify Y then convert back to RGB.
    return HOOKED.Sample(linear_clamp_sampler, uv) + c;
}
float4 Fragment_Upscale_DTD_x2_5(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_5(texCoord);
}

float get_luma_Upscale_DTD_x2_Luma_6(float4 rgba) {
	return dot(float4(0.299, 0.587, 0.114, 0.0), rgba);
}

float4 hook_Upscale_DTD_x2_Luma_6(float2 uv) {
    return float4(get_luma_Upscale_DTD_x2_Luma_6(HOOKED.Sample(linear_clamp_sampler, uv)), 0.0, 0.0, 0.0);
}
float4 Fragment_Upscale_DTD_x2_Luma_6(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Luma_6(texCoord);
}

// #define L_tex LINELUMA_tex

float4 hook_Upscale_DTD_x2_Kernel_X_7(float2 uv) {
	float2 d = HOOKED_TexelSize.xy;
	
	//[tl  t tr]
	//[ l  c  r]
	//[bl  b br]
	float l = LINELUMA.Sample(linear_clamp_sampler, uv + float2(-d.x, 0)).x;
	float c = LINELUMA.Sample(linear_clamp_sampler, uv).x;
	float r = LINELUMA.Sample(linear_clamp_sampler, uv + float2(d.x, 0)).x;
	
	
	//Horizontal Gradient
	//[-1  0  1]
	//[-2  0  2]
	//[-1  0  1]
	float xgrad = (-l + r);
	
	//Vertical Gradient
	//[-1 -2 -1]
	//[ 0  0  0]
	//[ 1  2  1]
	float ygrad = (l + c + c + r);
	
	//Computes the luminance's gradient
	return float4(xgrad, ygrad, 0, 0);
}
float4 Fragment_Upscale_DTD_x2_Kernel_X_7(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_X_7(texCoord);
}


Texture2D LUMAD;
float4 LUMAD_TexelSize;

float4 hook_Upscale_DTD_x2_Kernel_Y_8(float2 uv) {
	float2 d = HOOKED_TexelSize.xy;
	
	//[tl  t tr]
	//[ l cc  r]
	//[bl  b br]
	float tx = LUMAD.Sample(linear_clamp_sampler, uv + float2(0, -d.y)).x;
	float cx = LUMAD.Sample(linear_clamp_sampler, uv).x;
	float bx = LUMAD.Sample(linear_clamp_sampler, uv + float2(0, d.y)).x;
	
	
	float ty = LUMAD.Sample(linear_clamp_sampler, uv + float2(0, -d.y)).y;
	//float cy = LUMAD.Sample(linear_clamp_sampler, uv).y;
	float by = LUMAD.Sample(linear_clamp_sampler, uv + float2(0, d.y)).y;
	
	
	//Horizontal Gradient
	//[-1  0  1]
	//[-2  0  2]
	//[-1  0  1]
	float xgrad = (tx + cx + cx + bx) / 8.0;
	
	//Vertical Gradient
	//[-1 -2 -1]
	//[ 0  0  0]
	//[ 1  2  1]
	float ygrad = (-ty + by) / 8.0;
	
	//Computes the luminance's gradient
	float norm = sqrt(xgrad * xgrad + ygrad * ygrad);
	return float4(pow(norm, 0.7).xxxx);
}
float4 Fragment_Upscale_DTD_x2_Kernel_Y_8(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_Y_8(texCoord);
}

// #define L_tex LUMAD_tex

#define SIGMA (HOOKED_TexelSize.zw.y / 1080.0) * 2.0
#define KERNELSIZE (SIGMA * 2.0 + 1.0)

float gaussian_Upscale_DTD_x2_Kernel_X_9(float x, float s, float m) {
	return (1.0 / (s * sqrt(2.0 * 3.14159))) * exp(-0.5 * pow(abs(x - m) / s, 2.0));
}

float lumGaussian_Upscale_DTD_x2_Kernel_X_9(float2 pos, float2 d) {
	float g = (LUMAD.Sample(linear_clamp_sampler, pos).x) * gaussian_Upscale_DTD_x2_Kernel_X_9(0.0, SIGMA, 0.0);
	g = g + (LUMAD.Sample(linear_clamp_sampler, pos - d).x + LUMAD.Sample(linear_clamp_sampler, pos + d).x) * gaussian_Upscale_DTD_x2_Kernel_X_9(1.0, SIGMA, 0.0);
	for (int i=2; float(i)<KERNELSIZE; i++) {
		g = g + (LUMAD.Sample(linear_clamp_sampler, pos - (d * float(i))).x + LUMAD.Sample(linear_clamp_sampler, pos + (d * float(i))).x) * gaussian_Upscale_DTD_x2_Kernel_X_9(float(i), SIGMA, 0.0);
	}
	
	return g;
}

float4 hook_Upscale_DTD_x2_Kernel_X_9(float2 uv) {
    return float4(lumGaussian_Upscale_DTD_x2_Kernel_X_9(uv, float2(HOOKED_TexelSize.xy.x, 0)).xxxx);
}
float4 Fragment_Upscale_DTD_x2_Kernel_X_9(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_X_9(texCoord);
}

Texture2D LUMADG;
float4 LUMADG_TexelSize;

// #define L_tex LUMADG_tex

#define SIGMA (HOOKED_TexelSize.zw.y / 1080.0) * 2.0
#define KERNELSIZE (SIGMA * 2.0 + 1.0)

float gaussian_Upscale_DTD_x2_Kernel_Y_10(float x, float s, float m) {
	return (1.0 / (s * sqrt(2.0 * 3.14159))) * exp(-0.5 * pow(abs(x - m) / s, 2.0));
}

float lumGaussian_Upscale_DTD_x2_Kernel_Y_10(float2 pos, float2 d) {
	float g = (LUMADG.Sample(linear_clamp_sampler, pos).x) * gaussian_Upscale_DTD_x2_Kernel_Y_10(0.0, SIGMA, 0.0);
	g = g + (LUMADG.Sample(linear_clamp_sampler, pos - d).x + LUMADG.Sample(linear_clamp_sampler, pos + d).x) * gaussian_Upscale_DTD_x2_Kernel_Y_10(1.0, SIGMA, 0.0);
	for (int i=2; float(i)<KERNELSIZE; i++) {
		g = g + (LUMADG.Sample(linear_clamp_sampler, pos - (d * float(i))).x + LUMADG.Sample(linear_clamp_sampler, pos + (d * float(i))).x) * gaussian_Upscale_DTD_x2_Kernel_Y_10(float(i), SIGMA, 0.0);
	}
	
	return g;
}

float4 hook_Upscale_DTD_x2_Kernel_Y_10(float2 uv) {
	float g = lumGaussian_Upscale_DTD_x2_Kernel_Y_10(uv, float2(0, HOOKED_TexelSize.xy.y));
    return float4(g.xxxx);
}
float4 Fragment_Upscale_DTD_x2_Kernel_Y_10(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_Y_10(texCoord);
}

float4 hook_Upscale_DTD_x2_Kernel_X_11(float2 uv) {
	float2 d = HOOKED_TexelSize.xy;
	
	//[tl  t tr]
	//[ l  c  r]
	//[bl  b br]
	float l = LUMAD.Sample(linear_clamp_sampler, uv + float2(-d.x, 0)).x;
	float c = LUMAD.Sample(linear_clamp_sampler, uv).x;
	float r = LUMAD.Sample(linear_clamp_sampler, uv + float2(d.x, 0)).x;
	
	
	//Horizontal Gradient
	//[-1  0  1]
	//[-2  0  2]
	//[-1  0  1]
	float xgrad = (-l + r);
	
	//Vertical Gradient
	//[-1 -2 -1]
	//[ 0  0  0]
	//[ 1  2  1]
	float ygrad = (l + c + c + r);
	
	//Computes the luminance's gradient
	return float4(xgrad, ygrad, 0, 0);
}
float4 Fragment_Upscale_DTD_x2_Kernel_X_11(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_X_11(texCoord);
}


Texture2D LUMAD2;
float4 LUMAD2_TexelSize;

float4 hook_Upscale_DTD_x2_Kernel_Y_12(float2 uv) {
	float2 d = HOOKED_TexelSize.xy;
	
	//[tl  t tr]
	//[ l cc  r]
	//[bl  b br]
	float tx = LUMAD2.Sample(linear_clamp_sampler, uv + float2(0, -d.y)).x;
	float cx = LUMAD2.Sample(linear_clamp_sampler, uv).x;
	float bx = LUMAD2.Sample(linear_clamp_sampler, uv + float2(0, d.y)).x;
	
	
	float ty = LUMAD2.Sample(linear_clamp_sampler, uv + float2(0, -d.y)).y;
	//float cy = LUMAD2.Sample(linear_clamp_sampler, uv).y;
	float by = LUMAD2.Sample(linear_clamp_sampler, uv + float2(0, d.y)).y;
	
	
	//Horizontal Gradient
	//[-1  0  1]
	//[-2  0  2]
	//[-1  0  1]
	float xgrad = (tx + cx + cx + bx) / 8.0;
	
	//Vertical Gradient
	//[-1 -2 -1]
	//[ 0  0  0]
	//[ 1  2  1]
	float ygrad = (-ty + by) / 8.0;
	
	//Computes the luminance's gradient
	return float4(xgrad, ygrad, 0, 0);
}
float4 Fragment_Upscale_DTD_x2_Kernel_Y_12(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_Y_12(texCoord);
}

#define STRENGTH 0.4 //Strength of warping for each iteration
#define ITERATIONS 1 //Number of iterations for the forwards solver, decreasing strength and increasing iterations improves quality at the cost of speed.

// #define L_tex HOOKED_tex

float4 hook_Upscale_DTD_x2_13(float2 uv) {
	float2 d = HOOKED_TexelSize.xy;
	
	float relstr = HOOKED_TexelSize.zw.y / 1080.0 * STRENGTH;
	
	float2 pos = uv;
	for (int i=0; i<ITERATIONS; i++) {
		float2 dn = LUMAD2.Sample(linear_clamp_sampler, pos).xy;
		float2 dd = (dn / (length(dn) + 0.01)) * d * relstr; //Quasi-normalization for large vectors, avoids divide by zero
		pos -= dd;
	}
	
	return HOOKED.Sample(linear_clamp_sampler, pos);
	
}
float4 Fragment_Upscale_DTD_x2_13(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_13(texCoord);
}

Texture2D MAINTEMPTHIN;
float4 MAINTEMPTHIN_TexelSize;

float get_luma_Upscale_DTD_x2_Luma_14(float4 rgba) {
	return dot(float4(0.299, 0.587, 0.114, 0.0), rgba);
}

float4 hook_Upscale_DTD_x2_Luma_14(float2 uv) {
    return float4(get_luma_Upscale_DTD_x2_Luma_14(MAINTEMPTHIN.Sample(linear_clamp_sampler, uv)), 0.0, 0.0, 0.0);
}
float4 Fragment_Upscale_DTD_x2_Luma_14(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Luma_14(texCoord);
}

Texture2D MAINTEMP;
float4 MAINTEMP_TexelSize;

// #define L_tex MAINTEMP_tex

float max3v_Upscale_DTD_x2_Kernel_X_15(float a, float b, float c) {
	return max(max(a, b), c);
}
float min3v_Upscale_DTD_x2_Kernel_X_15(float a, float b, float c) {
	return min(min(a, b), c);
}

float2 minmax3_Upscale_DTD_x2_Kernel_X_15(float2 pos, float2 d) {
	float a = MAINTEMP.Sample(linear_clamp_sampler, pos - d).x;
	float b = MAINTEMP.Sample(linear_clamp_sampler, pos).x;
	float c = MAINTEMP.Sample(linear_clamp_sampler, pos + d).x;
	
	return float2(min3v_Upscale_DTD_x2_Kernel_X_15(a, b, c), max3v_Upscale_DTD_x2_Kernel_X_15(a, b, c));
}

float lumGaussian7_Upscale_DTD_x2_Kernel_X_15(float2 pos, float2 d) {
	float g = (MAINTEMP.Sample(linear_clamp_sampler, pos - (d + d)).x + MAINTEMP.Sample(linear_clamp_sampler, pos + (d + d)).x) * 0.06136;
	g = g + (MAINTEMP.Sample(linear_clamp_sampler, pos - d).x + MAINTEMP.Sample(linear_clamp_sampler, pos + d).x) * 0.24477;
	g = g + (MAINTEMP.Sample(linear_clamp_sampler, pos).x) * 0.38774;
	
	return g;
}


float4 hook_Upscale_DTD_x2_Kernel_X_15(float2 uv) {
    return float4(lumGaussian7_Upscale_DTD_x2_Kernel_X_15(uv, float2(HOOKED_TexelSize.xy.x, 0)), minmax3_Upscale_DTD_x2_Kernel_X_15(uv, float2(HOOKED_TexelSize.xy.x, 0)), 0);
}
float4 Fragment_Upscale_DTD_x2_Kernel_X_15(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_X_15(texCoord);
}

// #define L_tex MMKERNEL_tex

float max3v_Upscale_DTD_x2_Kernel_Y_16(float a, float b, float c) {
	return max(max(a, b), c);
}
float min3v_Upscale_DTD_x2_Kernel_Y_16(float a, float b, float c) {
	return min(min(a, b), c);
}

float2 minmax3_Upscale_DTD_x2_Kernel_Y_16(float2 pos, float2 d) {
	float a0 = MMKERNEL.Sample(linear_clamp_sampler, pos - d).y;
	float b0 = MMKERNEL.Sample(linear_clamp_sampler, pos).y;
	float c0 = MMKERNEL.Sample(linear_clamp_sampler, pos + d).y;
	
	float a1 = MMKERNEL.Sample(linear_clamp_sampler, pos - d).z;
	float b1 = MMKERNEL.Sample(linear_clamp_sampler, pos).z;
	float c1 = MMKERNEL.Sample(linear_clamp_sampler, pos + d).z;
	
	return float2(min3v_Upscale_DTD_x2_Kernel_Y_16(a0, b0, c0), max3v_Upscale_DTD_x2_Kernel_Y_16(a1, b1, c1));
}

float lumGaussian7_Upscale_DTD_x2_Kernel_Y_16(float2 pos, float2 d) {
	float g = (MMKERNEL.Sample(linear_clamp_sampler, pos - (d + d)).x + MMKERNEL.Sample(linear_clamp_sampler, pos + (d + d)).x) * 0.06136;
	g = g + (MMKERNEL.Sample(linear_clamp_sampler, pos - d).x + MMKERNEL.Sample(linear_clamp_sampler, pos + d).x) * 0.24477;
	g = g + (MMKERNEL.Sample(linear_clamp_sampler, pos).x) * 0.38774;
	
	return g;
}


float4 hook_Upscale_DTD_x2_Kernel_Y_16(float2 uv) {
    return float4(lumGaussian7_Upscale_DTD_x2_Kernel_Y_16(uv, float2(0, HOOKED_TexelSize.xy.y)), minmax3_Upscale_DTD_x2_Kernel_Y_16(uv, float2(0, HOOKED_TexelSize.xy.y)), 0);
}
float4 Fragment_Upscale_DTD_x2_Kernel_Y_16(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_Kernel_Y_16(texCoord);
}

#define STRENGTH 0.5 //De-blur proportional strength, higher is sharper. However, it is better to tweak BLUR_CURVE instead to avoid ringing.
#define BLUR_CURVE 0.8 //De-blur power curve, lower is sharper. Good values are between 0.3 - 1. Values greater than 1 softens the image;
#define BLUR_THRESHOLD 0.1 //Value where curve kicks in, used to not de-blur already sharp edges. Only de-blur values that fall below this threshold.
#define NOISE_THRESHOLD 0.004 //Value where curve stops, used to not sharpen noise. Only de-blur values that fall above this threshold.

// #define L_tex MAINTEMP_tex

float4 hook_Upscale_DTD_x2_17(float2 uv) {
	float c = (MAINTEMP.Sample(linear_clamp_sampler, uv).x - MMKERNEL.Sample(linear_clamp_sampler, uv).x) * STRENGTH;
	
	float t_range = BLUR_THRESHOLD - NOISE_THRESHOLD;
	
	float c_t = abs(c);
	if (c_t > NOISE_THRESHOLD) {
		c_t = (c_t - NOISE_THRESHOLD) / t_range;
		c_t = pow(c_t, BLUR_CURVE);
		c_t = c_t * t_range + NOISE_THRESHOLD;
		c_t = c_t * sign(c);
	} else {
		c_t = c;
	}
	
	float cc = clamp(c_t + MAINTEMP.Sample(linear_clamp_sampler, uv).x, MMKERNEL.Sample(linear_clamp_sampler, uv).y, MMKERNEL.Sample(linear_clamp_sampler, uv).z) - MAINTEMP.Sample(linear_clamp_sampler, uv).x;
	
	//This trick is only possible if the inverse Y->RGB matrix has 1 for every row... (which is the case for BT.709)
	//Otherwise we would need to convert RGB to YUV, modify Y then convert back to RGB.
	return MAINTEMPTHIN.Sample(linear_clamp_sampler, uv) + cc;
}
float4 Fragment_Upscale_DTD_x2_17(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Upscale_DTD_x2_17(texCoord);
}




