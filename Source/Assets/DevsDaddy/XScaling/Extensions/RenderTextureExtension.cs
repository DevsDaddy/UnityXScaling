using UnityEngine;

namespace DevsDaddy.XScaling.Extensions
{
    /// <summary>
    /// Render Texture Extension
    /// </summary>
    public static class RenderTextureExtension
    {
        public static Texture2D ToTexture2D(this RenderTexture rTex)
        {
            Texture2D tex = new Texture2D(rTex.width, rTex.height, TextureFormat.ARGB32, false);
            Graphics.CopyTexture(rTex, tex);
            rTex.Release();
            return tex;
        }
    }
}