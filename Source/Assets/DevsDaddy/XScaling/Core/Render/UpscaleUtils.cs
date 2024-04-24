using DevsDaddy.XScaling.Enum;
using UnityEngine;

namespace DevsDaddy.XScaling.Core.Render
{
    /// <summary>
    /// Upscale Utils Class
    /// </summary>
    public static class UpscaleUtils
    {
        /// <summary>
        /// Get Render Resolution from Quality Mode
        /// </summary>
        /// <param name="renderWidth"></param>
        /// <param name="renderHeight"></param>
        /// <param name="displayWidth"></param>
        /// <param name="displayHeight"></param>
        /// <param name="qualityMode"></param>
        public static void GetRenderResolutionFromQualityMode(out int renderWidth, out int renderHeight, int displayWidth, int displayHeight, UpscaleMode qualityMode) {
            float ratio = GetUpscaleRatioFromQualityMode(qualityMode);
            renderWidth = Mathf.RoundToInt(displayWidth / ratio);
            renderHeight = Mathf.RoundToInt(displayHeight / ratio);
        }
        
        /// <summary>
        /// Get Upscale Ratio from Quality Mode
        /// </summary>
        /// <param name="qualityMode"></param>
        /// <returns></returns>
        public static float GetUpscaleRatioFromQualityMode(UpscaleMode qualityMode)
        {
            switch (qualityMode)
            {
                case UpscaleMode.Performance:
                    return 1.5f;
                case UpscaleMode.Balanced:
                    return 1.5f;
                case UpscaleMode.HQPerformance:
                    return 1.0f;
                case UpscaleMode.HQQuality:
                    return 0.75f;
                default:
                    return 1.5f;
            }
        }

        /// <summary>
        /// Get Mipmap Bias Offset
        /// </summary>
        /// <param name="renderWidth"></param>
        /// <param name="displayWidth"></param>
        /// <returns></returns>
        public static float GetMipmapBiasOffset(int renderWidth, int displayWidth)
        {
            return Mathf.Log((float)renderWidth / displayWidth, 2.0f) - 1.0f;
        }
        
        /// <summary>
        /// Get Jitter Phase Count
        /// </summary>
        /// <param name="renderWidth"></param>
        /// <param name="displayWidth"></param>
        /// <returns></returns>
        public static int GetJitterPhaseCount(int renderWidth, int displayWidth)
        {
            const float basePhaseCount = 8.0f;
            int jitterPhaseCount = (int)(basePhaseCount * Mathf.Pow((float)displayWidth / renderWidth, 2.0f));
            return jitterPhaseCount;
        }

        /// <summary>
        /// Get Jitter Offset
        /// </summary>
        /// <param name="outX"></param>
        /// <param name="outY"></param>
        /// <param name="index"></param>
        /// <param name="phaseCount"></param>
        public static void GetJitterOffset(out float outX, out float outY, int index, int phaseCount) {
            if (index < 1) index = 1;
            if (phaseCount < 1) phaseCount = 1;
            outX = Halton((index % phaseCount) + 1, 2) - 0.5f;
            outY = Halton((index % phaseCount) + 1, 3) - 0.5f;
        }
        
        private static float Halton(int index, int @base)
        {
            float f = 1.0f, result = 0.0f;

            for (int currentIndex = index; currentIndex > 0;) {

                f /= @base;
                result += f * (currentIndex % @base);
                currentIndex = (int)Mathf.Floor((float)currentIndex / @base);
            }

            return result;
        }
    }
}