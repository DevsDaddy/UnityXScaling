using System.Collections.Generic;
using DevsDaddy.XScaling.Enum;
using DevsDaddy.XScaling.Extensions;
using DevsDaddy.XScaling.Utils;
using UnityEngine;

namespace DevsDaddy.XScaling.Core.Upscale
{
    /// <summary>
    /// Upscale Processor
    /// </summary>
    public static class UpscaleProcessor
    {
        // Processing Materials
        private static Dictionary<ProcessingMaterial, Material> processingMaterials = new Dictionary<ProcessingMaterial, Material>();
        
        // Shaders Cached Property Indexes
        private static readonly int hooked = Shader.PropertyToID("HOOKED");
        private static readonly int statsmax = Shader.PropertyToID("STATSMAX");
        private static readonly int conv2dTf = Shader.PropertyToID("conv2d_tf");
        private static readonly int conv2d1Tf = Shader.PropertyToID("conv2d_1_tf");
        private static readonly int conv2d2Tf = Shader.PropertyToID("conv2d_2_tf");
        private static readonly int conv2dLastTf = Shader.PropertyToID("conv2d_last_tf");
        private static readonly int conv2d3Tf = Shader.PropertyToID("conv2d_3_tf");
        private static readonly int conv2d4Tf = Shader.PropertyToID("conv2d_4_tf");
        private static readonly int conv2d5Tf = Shader.PropertyToID("conv2d_5_tf");
        private static readonly int conv2d6Tf = Shader.PropertyToID("conv2d_6_tf");
        private static readonly int conv2dTf1 = Shader.PropertyToID("conv2d_tf1");
        private static readonly int conv2d1Tf1 = Shader.PropertyToID("conv2d_1_tf1");
        private static readonly int conv2d2Tf1 = Shader.PropertyToID("conv2d_2_tf1");
        private static readonly int conv2d3Tf1 = Shader.PropertyToID("conv2d_3_tf1");
        private static readonly int conv2d4Tf1 = Shader.PropertyToID("conv2d_4_tf1");
        private static readonly int conv2d5Tf1 = Shader.PropertyToID("conv2d_5_tf1");
        private static readonly int conv2d6Tf1 = Shader.PropertyToID("conv2d_6_tf1");
        private static readonly int conv2dLastTf1 = Shader.PropertyToID("conv2d_last_tf1");
        private static readonly int conv2dLastTf2 = Shader.PropertyToID("conv2d_last_tf2");
        private static readonly int conv2d7Tf = Shader.PropertyToID("conv2d_7_tf");
        private static readonly int conv2d7Tf1 = Shader.PropertyToID("conv2d_7_tf1");
        
        /// <summary>
        /// Upscale to Texture
        /// </summary>
        /// <returns></returns>
        public static Texture2D UpscaleToTexture(Texture2D originalTexture, UpscaleMode upscaleMode, UpscaleTechnique upscaleTechnique, UpscaleSize upscaleSize) {
            RenderTexture currentRender = RenderTexture.GetTemporary(upscaleSize.Width, upscaleSize.Height, -1, RenderTextureFormat.ARGB32);
            TextureUpscaler.Upscale(originalTexture, currentRender, upscaleMode, upscaleTechnique);
            Texture2D cachedTexture = currentRender.ToTexture2D();
            RenderTexture.ReleaseTemporary(currentRender);
            return cachedTexture;
        }

        /// <summary>
        /// Upscale to Render Texture
        /// </summary>
        /// <param name="originalTexture"></param>
        /// <param name="upscaleMode"></param>
        /// <param name="upscaleTechnique"></param>
        /// <param name="upscaleSize"></param>
        /// <returns></returns>
        public static RenderTexture UpscaleToRenderTexture(RenderTexture originalTexture, UpscaleMode upscaleMode, UpscaleTechnique upscaleTechnique, UpscaleSize upscaleSize) {
            RenderTexture currentRender = RenderTexture.GetTemporary(upscaleSize.Width, upscaleSize.Height, -1, RenderTextureFormat.ARGB32);
            TextureUpscaler.Upscale(originalTexture, currentRender, upscaleMode, upscaleTechnique);
            return currentRender;
        }
        
        /// <summary>
        /// Process Upscale Using Denoise CNNx2S Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleDenoiseCNNx2S(Texture source, RenderTexture destination)
        {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.UpscaleDenoiseCNNx2S);

            var tempRTConv2dTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 1);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2dLastTf, processingMaterial, 3);
            processingMaterial.SetTexture(conv2dLastTf, tempRTConv2dLastTf);
            Graphics.Blit(source, destination, processingMaterial, 4);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf);

        }

        /// <summary>
        /// Process Upscale Using Denoise CNNx2M Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleDenoiseCNNx2M(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.UpscaleDenoiseCNNx2M);

            var tempRTConv2dTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 1);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2d3Tf, processingMaterial, 3);
            processingMaterial.SetTexture(conv2d3Tf, tempRTConv2d3Tf);
            Graphics.Blit(source, tempRTConv2d4Tf, processingMaterial, 4);
            processingMaterial.SetTexture(conv2d4Tf, tempRTConv2d4Tf);
            Graphics.Blit(source, tempRTConv2d5Tf, processingMaterial, 5);
            processingMaterial.SetTexture(conv2d5Tf, tempRTConv2d5Tf);
            Graphics.Blit(source, tempRTConv2d6Tf, processingMaterial, 6);
            processingMaterial.SetTexture(conv2d6Tf, tempRTConv2d6Tf);
            Graphics.Blit(source, tempRTConv2dLastTf, processingMaterial, 7);
            processingMaterial.SetTexture(conv2dLastTf, tempRTConv2dLastTf);
            Graphics.Blit(source, destination, processingMaterial, 8);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf);
        }

        /// <summary>
        /// Process Upscale Using Denoise CNNx2VL Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleDenoiseCNNx2VL(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.UpscaleDenoiseCNNx2VL);

            var tempRTConv2dTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dTf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2dTf1, processingMaterial, 1);
            processingMaterial.SetTexture(conv2dTf1, tempRTConv2dTf1);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d1Tf1, processingMaterial, 3);
            processingMaterial.SetTexture(conv2d1Tf1, tempRTConv2d1Tf1);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 4);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2d2Tf1, processingMaterial, 5);
            processingMaterial.SetTexture(conv2d2Tf1, tempRTConv2d2Tf1);
            Graphics.Blit(source, tempRTConv2d3Tf, processingMaterial, 6);
            processingMaterial.SetTexture(conv2d3Tf, tempRTConv2d3Tf);
            Graphics.Blit(source, tempRTConv2d3Tf1, processingMaterial, 7);
            processingMaterial.SetTexture(conv2d3Tf1, tempRTConv2d3Tf1);
            Graphics.Blit(source, tempRTConv2d4Tf, processingMaterial, 8);
            processingMaterial.SetTexture(conv2d4Tf, tempRTConv2d4Tf);
            Graphics.Blit(source, tempRTConv2d4Tf1, processingMaterial, 9);
            processingMaterial.SetTexture(conv2d4Tf1, tempRTConv2d4Tf1);
            Graphics.Blit(source, tempRTConv2d5Tf, processingMaterial, 10);
            processingMaterial.SetTexture(conv2d5Tf, tempRTConv2d5Tf);
            Graphics.Blit(source, tempRTConv2d5Tf1, processingMaterial, 11);
            processingMaterial.SetTexture(conv2d5Tf1, tempRTConv2d5Tf1);
            Graphics.Blit(source, tempRTConv2d6Tf, processingMaterial, 12);
            processingMaterial.SetTexture(conv2d6Tf, tempRTConv2d6Tf);
            Graphics.Blit(source, tempRTConv2d6Tf1, processingMaterial, 13);
            processingMaterial.SetTexture(conv2d6Tf1, tempRTConv2d6Tf1);
            Graphics.Blit(source, tempRTConv2dLastTf, processingMaterial, 14);
            processingMaterial.SetTexture(conv2dLastTf, tempRTConv2dLastTf);
            Graphics.Blit(source, tempRTConv2dLastTf1, processingMaterial, 15);
            processingMaterial.SetTexture(conv2dLastTf1, tempRTConv2dLastTf1);
            Graphics.Blit(source, tempRTConv2dLastTf2, processingMaterial, 16);
            processingMaterial.SetTexture(conv2dLastTf2, tempRTConv2dLastTf2);
            Graphics.Blit(source, destination, processingMaterial, 17);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2dTf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf1);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf2);
        }

        /// <summary>
        /// Process Upscale Using CNNx2S Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleCNNx2S(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.UpscaleCNNx2S);

            var tempRTConv2dTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 1);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2dLastTf, processingMaterial, 3);
            processingMaterial.SetTexture(conv2dLastTf, tempRTConv2dLastTf);
            Graphics.Blit(source, destination, processingMaterial, 4);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf);
        }

        /// <summary>
        /// Process Upscale Using CNNx2M Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleCNNx2M(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.UpscaleCNNx2M);

            var tempRTConv2dTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 1);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2d3Tf, processingMaterial, 3);
            processingMaterial.SetTexture(conv2d3Tf, tempRTConv2d3Tf);
            Graphics.Blit(source, tempRTConv2d4Tf, processingMaterial, 4);
            processingMaterial.SetTexture(conv2d4Tf, tempRTConv2d4Tf);
            Graphics.Blit(source, tempRTConv2d5Tf, processingMaterial, 5);
            processingMaterial.SetTexture(conv2d5Tf, tempRTConv2d5Tf);
            Graphics.Blit(source, tempRTConv2d6Tf, processingMaterial, 6);
            processingMaterial.SetTexture(conv2d6Tf, tempRTConv2d6Tf);
            Graphics.Blit(source, tempRTConv2dLastTf, processingMaterial, 7);
            processingMaterial.SetTexture(conv2dLastTf, tempRTConv2dLastTf);
            Graphics.Blit(source, destination, processingMaterial, 8);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf);
        }

        /// <summary>
        /// Process Upscale Using CNNx2VL Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void UpscaleCNNx2VL(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.UpscaleCNNx2VL);

            var tempRTConv2dTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dTf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf1 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dLastTf2 = RenderTexture.GetTemporary(source.width, source.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2dTf1, processingMaterial, 1);
            processingMaterial.SetTexture(conv2dTf1, tempRTConv2dTf1);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d1Tf1, processingMaterial, 3);
            processingMaterial.SetTexture(conv2d1Tf1, tempRTConv2d1Tf1);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 4);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2d2Tf1, processingMaterial, 5);
            processingMaterial.SetTexture(conv2d2Tf1, tempRTConv2d2Tf1);
            Graphics.Blit(source, tempRTConv2d3Tf, processingMaterial, 6);
            processingMaterial.SetTexture(conv2d3Tf, tempRTConv2d3Tf);
            Graphics.Blit(source, tempRTConv2d3Tf1, processingMaterial, 7);
            processingMaterial.SetTexture(conv2d3Tf1, tempRTConv2d3Tf1);
            Graphics.Blit(source, tempRTConv2d4Tf, processingMaterial, 8);
            processingMaterial.SetTexture(conv2d4Tf, tempRTConv2d4Tf);
            Graphics.Blit(source, tempRTConv2d4Tf1, processingMaterial, 9);
            processingMaterial.SetTexture(conv2d4Tf1, tempRTConv2d4Tf1);
            Graphics.Blit(source, tempRTConv2d5Tf, processingMaterial, 10);
            processingMaterial.SetTexture(conv2d5Tf, tempRTConv2d5Tf);
            Graphics.Blit(source, tempRTConv2d5Tf1, processingMaterial, 11);
            processingMaterial.SetTexture(conv2d5Tf1, tempRTConv2d5Tf1);
            Graphics.Blit(source, tempRTConv2d6Tf, processingMaterial, 12);
            processingMaterial.SetTexture(conv2d6Tf, tempRTConv2d6Tf);
            Graphics.Blit(source, tempRTConv2d6Tf1, processingMaterial, 13);
            processingMaterial.SetTexture(conv2d6Tf1, tempRTConv2d6Tf1);
            Graphics.Blit(source, tempRTConv2dLastTf, processingMaterial, 14);
            processingMaterial.SetTexture(conv2dLastTf, tempRTConv2dLastTf);
            Graphics.Blit(source, tempRTConv2dLastTf1, processingMaterial, 15);
            processingMaterial.SetTexture(conv2dLastTf1, tempRTConv2dLastTf1);
            Graphics.Blit(source, tempRTConv2dLastTf2, processingMaterial, 16);
            processingMaterial.SetTexture(conv2dLastTf2, tempRTConv2dLastTf2);
            Graphics.Blit(source, destination, processingMaterial, 17);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2dTf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf1);
            RenderTexture.ReleaseTemporary(tempRTConv2dLastTf2);
        }

        /// <summary>
        /// Process Restoring Using CNNS Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void RestoreCNNS(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.RestoreCNNS);

            var tempRTConv2dTf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 1);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, destination, processingMaterial, 3);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);

        }

        /// <summary>
        /// Process Restoring Using CNNM Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void RestoreCNNM(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.RestoreCNNM);

            var tempRTConv2dTf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d7Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 1);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2d3Tf, processingMaterial, 3);
            processingMaterial.SetTexture(conv2d3Tf, tempRTConv2d3Tf);
            Graphics.Blit(source, tempRTConv2d4Tf, processingMaterial, 4);
            processingMaterial.SetTexture(conv2d4Tf, tempRTConv2d4Tf);
            Graphics.Blit(source, tempRTConv2d5Tf, processingMaterial, 5);
            processingMaterial.SetTexture(conv2d5Tf, tempRTConv2d5Tf);
            Graphics.Blit(source, tempRTConv2d6Tf, processingMaterial, 6);
            processingMaterial.SetTexture(conv2d6Tf, tempRTConv2d6Tf);
            Graphics.Blit(source, tempRTConv2d7Tf, processingMaterial, 7);
            Graphics.Blit(tempRTConv2d7Tf, destination);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d7Tf);
        }

        /// <summary>
        /// Process Restoring Using CNNVL Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void RestoreCNNVL(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.RestoreCNNVL);

            var tempRTConv2dTf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dTf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d7Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d7Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2dTf1, processingMaterial, 1);
            processingMaterial.SetTexture(conv2dTf1, tempRTConv2dTf1);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d1Tf1, processingMaterial, 3);
            processingMaterial.SetTexture(conv2d1Tf1, tempRTConv2d1Tf1);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 4);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2d2Tf1, processingMaterial, 5);
            processingMaterial.SetTexture(conv2d2Tf1, tempRTConv2d2Tf1);
            Graphics.Blit(source, tempRTConv2d3Tf, processingMaterial, 6);
            processingMaterial.SetTexture(conv2d3Tf, tempRTConv2d3Tf);
            Graphics.Blit(source, tempRTConv2d3Tf1, processingMaterial, 7);
            processingMaterial.SetTexture(conv2d3Tf1, tempRTConv2d3Tf1);
            Graphics.Blit(source, tempRTConv2d4Tf, processingMaterial, 8);
            processingMaterial.SetTexture(conv2d4Tf, tempRTConv2d4Tf);
            Graphics.Blit(source, tempRTConv2d4Tf1, processingMaterial, 9);
            processingMaterial.SetTexture(conv2d4Tf1, tempRTConv2d4Tf1);
            Graphics.Blit(source, tempRTConv2d5Tf, processingMaterial, 10);
            processingMaterial.SetTexture(conv2d5Tf, tempRTConv2d5Tf);
            Graphics.Blit(source, tempRTConv2d5Tf1, processingMaterial, 11);
            processingMaterial.SetTexture(conv2d5Tf1, tempRTConv2d5Tf1);
            Graphics.Blit(source, tempRTConv2d6Tf, processingMaterial, 12);
            processingMaterial.SetTexture(conv2d6Tf, tempRTConv2d6Tf);
            Graphics.Blit(source, tempRTConv2d6Tf1, processingMaterial, 13);
            processingMaterial.SetTexture(conv2d6Tf1, tempRTConv2d6Tf1);
            Graphics.Blit(source, tempRTConv2d7Tf, processingMaterial, 14);
            processingMaterial.SetTexture(conv2d7Tf, tempRTConv2d7Tf);
            Graphics.Blit(source, tempRTConv2d7Tf1, processingMaterial, 15);
            processingMaterial.SetTexture(conv2d7Tf1, tempRTConv2d7Tf1);
            Graphics.Blit(source, destination, processingMaterial, 16);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2dTf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d7Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d7Tf1);
        }

        /// <summary>
        /// Process Restoring Using CNNS Soft Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void RestoreCNNSoftS(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.RestoreCNNSoftS);

            var tempRTConv2dTf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 1);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, destination, processingMaterial, 3);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
        }

        /// <summary>
        /// Process Restoring Using CNNM Soft Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void RestoreCNNSoftM(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.RestoreCNNSoftM);

            var tempRTConv2dTf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 1);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2d3Tf, processingMaterial, 3);
            processingMaterial.SetTexture(conv2d3Tf, tempRTConv2d3Tf);
            Graphics.Blit(source, tempRTConv2d4Tf, processingMaterial, 4);
            processingMaterial.SetTexture(conv2d4Tf, tempRTConv2d4Tf);
            Graphics.Blit(source, tempRTConv2d5Tf, processingMaterial, 5);
            processingMaterial.SetTexture(conv2d5Tf, tempRTConv2d5Tf);
            Graphics.Blit(source, tempRTConv2d6Tf, processingMaterial, 6);
            processingMaterial.SetTexture(conv2d6Tf, tempRTConv2d6Tf);
            Graphics.Blit(source, destination, processingMaterial, 7);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf);
        }

        /// <summary>
        /// Process Restoring Using CNNVL Soft Algorithm
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void RestoreCNNSoftVL(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.RestoreCNNSoftVL);

            var tempRTConv2dTf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2dTf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d1Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d2Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d3Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d4Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d5Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d6Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d7Tf = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTConv2d7Tf1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);

            Graphics.Blit(source, tempRTConv2dTf, processingMaterial, 0);
            processingMaterial.SetTexture(conv2dTf, tempRTConv2dTf);
            Graphics.Blit(source, tempRTConv2dTf1, processingMaterial, 1);
            processingMaterial.SetTexture(conv2dTf1, tempRTConv2dTf1);
            Graphics.Blit(source, tempRTConv2d1Tf, processingMaterial, 2);
            processingMaterial.SetTexture(conv2d1Tf, tempRTConv2d1Tf);
            Graphics.Blit(source, tempRTConv2d1Tf1, processingMaterial, 3);
            processingMaterial.SetTexture(conv2d1Tf1, tempRTConv2d1Tf1);
            Graphics.Blit(source, tempRTConv2d2Tf, processingMaterial, 4);
            processingMaterial.SetTexture(conv2d2Tf, tempRTConv2d2Tf);
            Graphics.Blit(source, tempRTConv2d2Tf1, processingMaterial, 5);
            processingMaterial.SetTexture(conv2d2Tf1, tempRTConv2d2Tf1);
            Graphics.Blit(source, tempRTConv2d3Tf, processingMaterial, 6);
            processingMaterial.SetTexture(conv2d3Tf, tempRTConv2d3Tf);
            Graphics.Blit(source, tempRTConv2d3Tf1, processingMaterial, 7);
            processingMaterial.SetTexture(conv2d3Tf1, tempRTConv2d3Tf1);
            Graphics.Blit(source, tempRTConv2d4Tf, processingMaterial, 8);
            processingMaterial.SetTexture(conv2d4Tf, tempRTConv2d4Tf);
            Graphics.Blit(source, tempRTConv2d4Tf1, processingMaterial, 9);
            processingMaterial.SetTexture(conv2d4Tf1, tempRTConv2d4Tf1);
            Graphics.Blit(source, tempRTConv2d5Tf, processingMaterial, 10);
            processingMaterial.SetTexture(conv2d5Tf, tempRTConv2d5Tf);
            Graphics.Blit(source, tempRTConv2d5Tf1, processingMaterial, 11);
            processingMaterial.SetTexture(conv2d5Tf1, tempRTConv2d5Tf1);
            Graphics.Blit(source, tempRTConv2d6Tf, processingMaterial, 12);
            processingMaterial.SetTexture(conv2d6Tf, tempRTConv2d6Tf);
            Graphics.Blit(source, tempRTConv2d6Tf1, processingMaterial, 13);
            processingMaterial.SetTexture(conv2d6Tf1, tempRTConv2d6Tf1);
            Graphics.Blit(source, tempRTConv2d7Tf, processingMaterial, 14);
            processingMaterial.SetTexture(conv2d7Tf, tempRTConv2d7Tf);
            Graphics.Blit(source, tempRTConv2d7Tf1, processingMaterial, 15);
            processingMaterial.SetTexture(conv2d7Tf1, tempRTConv2d7Tf1);
            Graphics.Blit(source, destination, processingMaterial, 16);

            RenderTexture.ReleaseTemporary(tempRTConv2dTf);
            RenderTexture.ReleaseTemporary(tempRTConv2dTf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d1Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d2Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d3Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d4Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d5Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d6Tf1);
            RenderTexture.ReleaseTemporary(tempRTConv2d7Tf);
            RenderTexture.ReleaseTemporary(tempRTConv2d7Tf1);
        }
        
        /// <summary>
        /// Clamp Highlights
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static void ClampHighlights(Texture source, RenderTexture destination) {
            Material processingMaterial = GetProcessingMaterial(ProcessingMaterial.ClampHighlights);

            var tempRTStatsmax1 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);
            var tempRTStatsmax2 = RenderTexture.GetTemporary(destination.width, destination.height, -1, RenderTextureFormat.ARGBHalf);

            processingMaterial.SetTexture(hooked, source);
            Graphics.Blit(source, tempRTStatsmax1, processingMaterial, 0);
            processingMaterial.SetTexture(statsmax, tempRTStatsmax1);
            Graphics.Blit(source, tempRTStatsmax2, processingMaterial, 1);
            processingMaterial.SetTexture(statsmax, tempRTStatsmax2);
            Graphics.Blit(source, destination, processingMaterial, 2);

            RenderTexture.ReleaseTemporary(tempRTStatsmax1);
            RenderTexture.ReleaseTemporary(tempRTStatsmax2);
        }
        
        /// <summary>
        /// Get Processing Material
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private static Material GetProcessingMaterial(ProcessingMaterial type) {
            if (processingMaterials.TryGetValue(type, out var material))
                return material;

            // Processing Shader
            Shader processingShader = null;
            switch (type) {
                case ProcessingMaterial.ClampHighlights : processingShader = Shader.Find("Hidden/XScaling_Clamp_Highlights");
                    break;
                case ProcessingMaterial.UpscaleDenoiseCNNx2S : processingShader = Shader.Find("Hidden/XScaling_Upscale_Denoise_CNN_x2_S");
                    break;
                case ProcessingMaterial.UpscaleDenoiseCNNx2M : processingShader = Shader.Find("Hidden/XScaling_Upscale_Denoise_CNN_x2_M");
                    break;
                case ProcessingMaterial.UpscaleDenoiseCNNx2VL : processingShader = Shader.Find("Hidden/XScaling_Upscale_Denoise_CNN_x2_VL");
                    break;
                case ProcessingMaterial.UpscaleCNNx2S : processingShader = Shader.Find("Hidden/XScaling_Upscale_CNN_x2_S");
                    break;
                case ProcessingMaterial.UpscaleCNNx2M : processingShader = Shader.Find("Hidden/XScaling_Upscale_CNN_x2_M");
                    break;
                case ProcessingMaterial.UpscaleCNNx2VL : processingShader = Shader.Find("Hidden/XScaling_Upscale_CNN_x2_VL");
                    break;
                case ProcessingMaterial.RestoreCNNS : processingShader = Shader.Find("Hidden/XScaling_Restore_CNN_S");
                    break;
                case ProcessingMaterial.RestoreCNNM : processingShader = Shader.Find("Hidden/XScaling_Restore_CNN_M");
                    break;
                case ProcessingMaterial.RestoreCNNVL : processingShader = Shader.Find("Hidden/XScaling_Restore_CNN_VL");
                    break;
                case ProcessingMaterial.RestoreCNNSoftS : processingShader = Shader.Find("Hidden/XScaling_Restore_CNN_Soft_S");
                    break;
                case ProcessingMaterial.RestoreCNNSoftM : processingShader = Shader.Find("Hidden/XScaling_Restore_CNN_Soft_M");
                    break;
                case ProcessingMaterial.RestoreCNNSoftVL : processingShader = Shader.Find("Hidden/XScaling_Restore_CNN_Soft_VL");
                    break;
            }

            if (processingShader == null) {
                Debug.LogError($"Failed to initialize processing material. Failed to found processing shader of type {type.ToString()}.");
                return null;
            }

            // Create and Cache Material
            Material processingMaterial = new Material(processingShader);
            processingMaterials.Add(type, processingMaterial);
            return processingMaterial;
        }
        
        /// <summary>
        /// Processing Material Type
        /// </summary>
        private enum ProcessingMaterial
        {
            ClampHighlights,
            UpscaleDenoiseCNNx2S,
            UpscaleDenoiseCNNx2M,
            UpscaleDenoiseCNNx2VL,
            UpscaleCNNx2S,
            UpscaleCNNx2M,
            UpscaleCNNx2VL,
            RestoreCNNS,
            RestoreCNNM,
            RestoreCNNVL,
            RestoreCNNSoftS,
            RestoreCNNSoftM,
            RestoreCNNSoftVL
        }
    }
}