Texture2D HOOKED;
float4 HOOKED_TexelSize;

float get_luma_Denoise_Bilateral_Median_Luma_0(float4 rgba) {
	return dot(float4(0.299, 0.587, 0.114, 0.0), rgba);
}

float4 hook_Denoise_Bilateral_Median_Luma_0(float2 uv) {
    return float4(get_luma_Denoise_Bilateral_Median_Luma_0(HOOKED.Sample(linear_clamp_sampler, uv)), 0.0, 0.0, 0.0);
}
float4 Fragment_Denoise_Bilateral_Median_Luma_0(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Denoise_Bilateral_Median_Luma_0(texCoord);
}

Texture2D LINELUMA;
float4 LINELUMA_TexelSize;

#define INTENSITY_SIGMA 0.1 //Intensity window size, higher is stronger denoise, must be a positive real number
#define SPATIAL_SIGMA 1.0 //Spatial window size, higher is stronger denoise, must be a positive real number.
#define HISTOGRAM_REGULARIZATION 0.0 //Histogram regularization window size, higher values approximate a bilateral "closest-to-mean" filter.

#define INTENSITY_POWER_CURVE 1.0 //Intensity window power curve. Setting it to 0 will make the intensity window treat all intensities equally, while increasing it will make the window narrower in darker intensities and wider in brighter intensities.

#define KERNELSIZE int(max(int(SPATIAL_SIGMA), 1) * 2 + 1) //Kernel size, must be an positive odd integer.
#define KERNELHALFSIZE (int(KERNELSIZE/2)) //Half of the kernel size without remainder. Must be equal to trunc(KERNELSIZE/2).
#define KERNELLEN (KERNELSIZE * KERNELSIZE) //Total area of kernel. Must be equal to KERNELSIZE * KERNELSIZE.

#define GETOFFSET(i) float2((i % KERNELSIZE) - KERNELHALFSIZE, (i / KERNELSIZE) - KERNELHALFSIZE)

float gaussian_Denoise_Bilateral_Median_Apply_1(float x, float s, float m) {
	float scaled = (x - m) / s;
	return exp(-0.5 * scaled * scaled);
}

float4 getMedian_Denoise_Bilateral_Median_Apply_1(float4 v[KERNELLEN], float w[KERNELLEN], float n) {
	
	for (int i=0; i<KERNELLEN; i++) {
		float w_above = 0.0;
		float w_below = 0.0;
		for (int j=0; j<KERNELLEN; j++) {
			if (v[j].x > v[i].x) {
				w_above += w[j];
			} else if (v[j].x < v[i].x) {
				w_below += w[j];
			}
		}
		
		if ((n - w_above) / n >= 0.5 && w_below / n <= 0.5) {
			return v[i];
		}
	}
	return 0.0.xxxx;
}

float4 hook_Denoise_Bilateral_Median_Apply_1(float2 uv) {
	float4 histogram_v[KERNELLEN];
	float histogram_l[KERNELLEN];
	float histogram_w[KERNELLEN];
	float n = 0.0;
	
	float vc = LINELUMA.Sample(linear_clamp_sampler, uv).x;
	
	float is = pow(vc + 0.0001, INTENSITY_POWER_CURVE) * INTENSITY_SIGMA;
	float ss = SPATIAL_SIGMA;
	
	for (int i=0; i<KERNELLEN; i++) {
		float2 ipos = GETOFFSET(i);
		histogram_v[i] = HOOKED.Sample(linear_clamp_sampler, uv + ipos);
		histogram_l[i] = LINELUMA.Sample(linear_clamp_sampler, uv + ipos).x;
		histogram_w[i] = gaussian_Denoise_Bilateral_Median_Apply_1(histogram_l[i], is, vc) * gaussian_Denoise_Bilateral_Median_Apply_1(length(ipos), ss, 0.0);
		n += histogram_w[i];
	}
	
	if (HISTOGRAM_REGULARIZATION > 0.0) {
		float histogram_wn[KERNELLEN];
		n = 0.0;
		
		for (int i=0; i<KERNELLEN; i++) {
			histogram_wn[i] = 0.0;
		}
		
		for (int i=0; i<KERNELLEN; i++) {
			histogram_wn[i] += gaussian_Denoise_Bilateral_Median_Apply_1(0.0, HISTOGRAM_REGULARIZATION, 0.0) * histogram_w[i];
			for (int j=(i+1); j<KERNELLEN; j++) {
				float d = gaussian_Denoise_Bilateral_Median_Apply_1(histogram_l[j], HISTOGRAM_REGULARIZATION, histogram_l[i]);
				histogram_wn[j] += d * histogram_w[i];
				histogram_wn[i] += d * histogram_w[j];
			}
			n += histogram_wn[i];
		}
	
		return getMedian_Denoise_Bilateral_Median_Apply_1(histogram_v, histogram_wn, n);
	}
	
	return getMedian_Denoise_Bilateral_Median_Apply_1(histogram_v, histogram_w, n);
}
float4 Fragment_Denoise_Bilateral_Median_Apply_1(float4 position : SV_Position, float2 texCoord : TEXCOORD) : SV_Target
{
    return hook_Denoise_Bilateral_Median_Apply_1(texCoord);
}