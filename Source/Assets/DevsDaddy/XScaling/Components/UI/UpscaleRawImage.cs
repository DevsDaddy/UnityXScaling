using System;
using System.Collections;
using DevsDaddy.XScaling.Core.Upscale;
using DevsDaddy.XScaling.Enum;
using DevsDaddy.XScaling.Utils;
using UnityEngine;
using UnityEngine.UI;

namespace DevsDaddy.XScaling.Components.UI
{
    /// <summary>
    /// Upscaled Raw Image Component
    /// </summary>
    [DisallowMultipleComponent]
    [AddComponentMenu("XScaling/UI/Upscale Raw Image")]
    [RequireComponent(typeof(RawImage))]
    public class UpscaleRawImage : MonoBehaviour
    {
        // Image Container
        [Header("Upscale Settings")] 
        [SerializeField] private UIUpscaleActivationMode activationMode = UIUpscaleActivationMode.OnStart;
        [SerializeField] private UpscaleMode upscaleMode = UpscaleMode.Balanced;
        [SerializeField] private UpscaleTechnique upscaleTechnique = UpscaleTechnique.TechniqueA;
        [SerializeField] private UpscaleSize upscaleSize = new UpscaleSize(1024,1024);

        public bool IsUpscaled => isUpscaled;
        public Action OnUpscaled;
        public Action OnDownscaled;
        
        // Internal Fields
        private bool isDestroying = false;
        private bool isUpscaled = false;
        private RawImage imageContainer;
        private Texture2D originalTexture;
        private Texture2D cachedTexture;

        /// <summary>
        /// On Awake
        /// </summary>
        private void Awake() {
            imageContainer = GetComponent<RawImage>();
            originalTexture = (Texture2D)imageContainer.texture;
            XRender.OnStateChanged += OnRenderStateChanged;
        }

        /// <summary>
        /// On Start
        /// </summary>
        private void Start() {
            if(activationMode == UIUpscaleActivationMode.OnStart)
                OnRenderStateChanged(XRender.IsActive);
        }

        /// <summary>
        /// On Destroy
        /// </summary>
        private void OnDestroy() {
            isDestroying = true;
            XRender.OnStateChanged -= OnRenderStateChanged;
            DisableUpscale();
        }

        /// <summary>
        /// On Render State Changed
        /// </summary>
        /// <param name="isRenderActive"></param>
        private void OnRenderStateChanged(bool isRenderActive) {
            if (!isRenderActive) {
                DisableUpscale();
                return;
            }

            if (activationMode != UIUpscaleActivationMode.Manual)
                Upscale();
        }

        /// <summary>
        /// Disable Upscale
        /// </summary>
        private void DisableUpscale() {
            if (!isUpscaled) return;
            StopCoroutine(UpscaleTexture());

            if (!isDestroying) {
                imageContainer.texture = originalTexture;
            }

            Resources.UnloadUnusedAssets();
            OnDownscaled?.Invoke();
            isUpscaled = false;
        }

        /// <summary>
        /// Manual Upscale Request
        /// </summary>
        public void Upscale() {
            if(isUpscaled) return;
            StopCoroutine(UpscaleTexture());
            StartCoroutine(UpscaleTexture(() => {
                Resources.UnloadUnusedAssets();
                OnUpscaled?.Invoke();
                Debug.Log($"Complete Upscale for {gameObject.name} (Image): {cachedTexture.width}/{cachedTexture.height} from {originalTexture.width}/{originalTexture.height}.");
            }));
            isUpscaled = true;
        }
        
        private IEnumerator UpscaleTexture(Action onComplete = null) {
            if (cachedTexture == null) {
                cachedTexture = UpscaleProcessor.UpscaleToTexture(originalTexture, upscaleMode, upscaleTechnique, upscaleSize);
            }
            
            imageContainer.texture = cachedTexture;
            yield return new WaitForSeconds(0.0f);
            onComplete?.Invoke();
        }
    }
}