using UnityEngine;

namespace DevsDaddy.XScaling.Utils
{
    [System.Serializable]
    public struct UpscaleSize
    {
        public int Width;
        public int Height;
        
        public UpscaleSize(int width, int height) {
            this.Width = width;
            this.Height = height;
        }
    }
}