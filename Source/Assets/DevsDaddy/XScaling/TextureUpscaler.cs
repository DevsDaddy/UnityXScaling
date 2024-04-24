using System;
using System.Collections;
using System.Collections.Generic;
using DevsDaddy.XScaling.Core.Upscale;
using DevsDaddy.XScaling.Enum;
using DevsDaddy.XScaling.Extensions;
using UnityEngine;

namespace DevsDaddy.XScaling
{
    /// <summary>
    /// Texture Upscale Worker
    /// </summary>
    public static class TextureUpscaler
    {
        /// <summary>
        /// Upscale Texture with Render Texture Destination
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        /// <param name="mode"></param>
        /// <param name="technique"></param>
        public static void Upscale(Texture source, RenderTexture destination, UpscaleMode mode = UpscaleMode.Balanced, UpscaleTechnique technique = UpscaleTechnique.TechniqueA) {
            switch (mode) {
                case UpscaleMode.Performance : if(technique == UpscaleTechnique.TechniqueA) UpscaleA_Fast(source, destination); else UpscaleB_Fast(source, destination);
                    break;
                case UpscaleMode.Balanced : if(technique == UpscaleTechnique.TechniqueA) UpscaleA_HQ(source, destination); else UpscaleB_HQ(source, destination);
                    break;
                case UpscaleMode.HQPerformance : if(technique == UpscaleTechnique.TechniqueA) Upscalex2A_Fast(source, destination); else Upscalex2B_Fast(source, destination);
                    break;
                case UpscaleMode.HQQuality : if(technique == UpscaleTechnique.TechniqueA) Upscalex2A_HQ(source, destination); else Upscalex2B_HQ(source, destination);
                    break;
            }
        }
        
        /// <summary>
        /// Upscale Texture using Technique A with HQ Quality
        /// and Returns RenderTexture
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleA_HQ(Texture source, RenderTexture destination) {
            var tempRT1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT3 = RenderTexture.GetTemporary(source.width * 2, source.height * 2, -1, RenderTextureFormat.ARGBHalf);
            var tempRT4 = RenderTexture.GetTemporary(destination.width / 2, destination.height / 2, -1, RenderTextureFormat.ARGBHalf);

            UpscaleProcessor.ClampHighlights(source, tempRT1);
            UpscaleProcessor.RestoreCNNVL(tempRT1, tempRT2);
            UpscaleProcessor.UpscaleCNNx2VL(tempRT2, tempRT3);
            Graphics.Blit(tempRT3, tempRT4);
            UpscaleProcessor.UpscaleCNNx2M(tempRT4, destination);

            RenderTexture.ReleaseTemporary(tempRT1);
            RenderTexture.ReleaseTemporary(tempRT2);
            RenderTexture.ReleaseTemporary(tempRT3);
            RenderTexture.ReleaseTemporary(tempRT4);
        }

        /// <summary>
        /// Upscale Texture using Technique B with HQ Quality
        /// and Returns RenderTexture
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleB_HQ(Texture source, RenderTexture destination) {
            var tempRT1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT3 = RenderTexture.GetTemporary(source.width * 2, source.height * 2, -1, RenderTextureFormat.ARGBHalf);
            var tempRT4 = RenderTexture.GetTemporary(destination.width / 2, destination.height / 2, -1, RenderTextureFormat.ARGBHalf);

            UpscaleProcessor.ClampHighlights(source, tempRT1);
            UpscaleProcessor.RestoreCNNSoftVL(tempRT1, tempRT2);
            UpscaleProcessor.UpscaleCNNx2VL(tempRT2, tempRT3);
            Graphics.Blit(tempRT3, tempRT4);
            UpscaleProcessor.UpscaleCNNx2M(tempRT4, destination);

            RenderTexture.ReleaseTemporary(tempRT1);
            RenderTexture.ReleaseTemporary(tempRT2);
            RenderTexture.ReleaseTemporary(tempRT3);
            RenderTexture.ReleaseTemporary(tempRT4);
        }

        /// <summary>
        /// Upscale Texture using Technique A with Fast Quality
        /// and Returns RenderTexture
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleA_Fast(Texture source, RenderTexture destination) {
            var tempRT1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT3 = RenderTexture.GetTemporary(source.width * 2, source.height * 2, -1, RenderTextureFormat.ARGBHalf);
            var tempRT4 = RenderTexture.GetTemporary(destination.width / 2, destination.height / 2, -1, RenderTextureFormat.ARGBHalf);

            UpscaleProcessor.ClampHighlights(source, tempRT1);
            UpscaleProcessor.RestoreCNNM(tempRT1, tempRT2);
            UpscaleProcessor.UpscaleCNNx2M(tempRT2, tempRT3);
            Graphics.Blit(tempRT3, tempRT4);
            UpscaleProcessor.UpscaleCNNx2S(tempRT4, destination);

            RenderTexture.ReleaseTemporary(tempRT1);
            RenderTexture.ReleaseTemporary(tempRT2);
            RenderTexture.ReleaseTemporary(tempRT3);
            RenderTexture.ReleaseTemporary(tempRT4);
        }

        /// <summary>
        /// Upscale Texture using Technique B with Fast Quality
        /// and Returns RenderTexture
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleB_Fast(Texture source, RenderTexture destination) {
            var tempRT1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT3 = RenderTexture.GetTemporary(source.width * 2, source.height * 2, -1, RenderTextureFormat.ARGBHalf);
            var tempRT4 = RenderTexture.GetTemporary(destination.width / 2, destination.height / 2, -1, RenderTextureFormat.ARGBHalf);

            UpscaleProcessor.ClampHighlights(source, tempRT1);
            UpscaleProcessor.RestoreCNNSoftM(tempRT1, tempRT2);
            UpscaleProcessor.UpscaleCNNx2M(tempRT2, tempRT3);
            Graphics.Blit(tempRT3, tempRT4);
            UpscaleProcessor.UpscaleCNNx2S(tempRT4, destination);

            RenderTexture.ReleaseTemporary(tempRT1);
            RenderTexture.ReleaseTemporary(tempRT2);
            RenderTexture.ReleaseTemporary(tempRT3);
            RenderTexture.ReleaseTemporary(tempRT4);
        }

        /// <summary>
        /// Upscale Texture using Technique A with 2XHQ Quality
        /// and Returns RenderTexture
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void Upscalex2A_HQ(Texture source, RenderTexture destination) {
            var tempRT1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT3 = RenderTexture.GetTemporary(source.width * 2, source.height * 2, -1, RenderTextureFormat.ARGBHalf);

            UpscaleProcessor.ClampHighlights(source, tempRT1);
            UpscaleProcessor.RestoreCNNVL(tempRT1, tempRT2);
            UpscaleProcessor.UpscaleCNNx2VL(tempRT2, tempRT3);
            Graphics.Blit(tempRT3, destination);

            RenderTexture.ReleaseTemporary(tempRT1);
            RenderTexture.ReleaseTemporary(tempRT2);
            RenderTexture.ReleaseTemporary(tempRT3);
        }

        /// <summary>
        /// Upscale Texture using Technique B with 2XHQ Quality
        /// and Returns RenderTexture
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void Upscalex2B_HQ(Texture source, RenderTexture destination) {
            var tempRT1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT3 = RenderTexture.GetTemporary(source.width * 2, source.height * 2, -1, RenderTextureFormat.ARGBHalf);

            UpscaleProcessor.ClampHighlights(source, tempRT1);
            UpscaleProcessor.RestoreCNNSoftVL(tempRT1, tempRT2);
            UpscaleProcessor.UpscaleCNNx2VL(tempRT2, tempRT3);
            Graphics.Blit(tempRT3, destination);

            RenderTexture.ReleaseTemporary(tempRT1);
            RenderTexture.ReleaseTemporary(tempRT2);
            RenderTexture.ReleaseTemporary(tempRT3);
        }

        /// <summary>
        /// Upscale Texture using Technique A with 2XFast Quality
        /// and Returns RenderTexture
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void Upscalex2A_Fast(Texture source, RenderTexture destination) {
            var tempRT1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT3 = RenderTexture.GetTemporary(source.width * 2, source.height * 2, -1, RenderTextureFormat.ARGBHalf);

            UpscaleProcessor.ClampHighlights(source, tempRT1);
            UpscaleProcessor.RestoreCNNM(tempRT1, tempRT2);
            UpscaleProcessor.UpscaleCNNx2M(tempRT2, tempRT3);
            Graphics.Blit(tempRT3, destination);

            RenderTexture.ReleaseTemporary(tempRT1);
            RenderTexture.ReleaseTemporary(tempRT2);
            RenderTexture.ReleaseTemporary(tempRT3);
        }

        /// <summary>
        /// Upscale Texture using Technique B with 2XFast Quality
        /// and Returns RenderTexture
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void Upscalex2B_Fast(Texture source, RenderTexture destination) {
            var tempRT1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRT3 = RenderTexture.GetTemporary(source.width * 2, source.height * 2, -1, RenderTextureFormat.ARGBHalf);

            UpscaleProcessor.ClampHighlights(source, tempRT1);
            UpscaleProcessor.RestoreCNNSoftM(tempRT1, tempRT2);
            UpscaleProcessor.UpscaleCNNx2M(tempRT2, tempRT3);
            Graphics.Blit(tempRT3, destination);

            RenderTexture.ReleaseTemporary(tempRT1);
            RenderTexture.ReleaseTemporary(tempRT2);
            RenderTexture.ReleaseTemporary(tempRT3);
        }
    }
}