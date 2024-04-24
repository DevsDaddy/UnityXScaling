using System;
using System.Collections;
using DevsDaddy.XScaling.Core.Upscale;
using DevsDaddy.XScaling.Enum;
using DevsDaddy.XScaling.Utils;
using UnityEngine;

namespace DevsDaddy.XScaling.Components.Texture
{
    /// <summary>
    /// Material Texture Upscale
    /// </summary>
    public class MaterialTextureUpscale : MonoBehaviour
    {
        [Header("Upscale Settings")]
        [SerializeField] private float distanceToUpscale = 20f;
        [SerializeField] private UpscaleMode upscaleMode = UpscaleMode.Balanced;
        [SerializeField] private UpscaleTechnique upscaleTechnique = UpscaleTechnique.TechniqueA;
        [SerializeField] private int upscaleMultiplier = 3;

        public bool IsUpscaled => isUpscaled;
        public Action OnUpscaled;
        public Action OnDownscaled;
        
        // Internal Fields
        private bool isDestroying = false;
        private bool isUpscaled = false;
        private Material materialContainer;
        private Texture2D originalTexture;
        private Texture2D cachedTexture;
        private Camera mainCamera;
        
        // Main Texture
        private static readonly int mainTex = Shader.PropertyToID("_MainTex");

        /// <summary>
        /// On Awake
        /// </summary>
        private void Awake() {
            Renderer meshRenderer = GetComponent<Renderer>();
            materialContainer = meshRenderer.material;
            originalTexture = (Texture2D)materialContainer.GetTexture(mainTex);
            XRender.OnStateChanged += OnRenderStateChanged;
        }

        /// <summary>
        /// On Start
        /// </summary>
        private void Start() {
            mainCamera = Camera.main;
            if (Vector3.Distance(mainCamera.transform.position, transform.position) < distanceToUpscale)
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

            if (Vector3.Distance(mainCamera.transform.position, transform.position) < distanceToUpscale)
                Upscale();
        }

        /// <summary>
        /// On Fixed Update
        /// </summary>
        private void FixedUpdate() {
            if(mainCamera == null || !XRender.IsActive) return;
            if (Vector3.Distance(mainCamera.transform.position, transform.position) < distanceToUpscale) {
                if(!isUpscaled) Upscale();
            }
            else {
                if(isUpscaled) DisableUpscale();
            }
        }

        /// <summary>
        /// Disable Upscale
        /// </summary>
        private void DisableUpscale() {
            if (!isUpscaled) return;
            StopCoroutine(UpscaleTexture());
            materialContainer.SetTexture(mainTex, originalTexture);
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
                Debug.Log($"Complete Upscale for {gameObject.name} (Material Texture): {cachedTexture.width}/{cachedTexture.height} from {originalTexture.width}/{originalTexture.height}.");
            }));
            isUpscaled = true;
        }

        private IEnumerator UpscaleTexture(Action onComplete = null) {
            if (cachedTexture == null) {
                cachedTexture = UpscaleProcessor.UpscaleToTexture(originalTexture, upscaleMode, upscaleTechnique, new UpscaleSize(originalTexture.width * upscaleMultiplier, originalTexture.height * upscaleMultiplier));
            }

            materialContainer.SetTexture(mainTex, cachedTexture);
            yield return new WaitForSeconds(0.0f);
            onComplete?.Invoke();
        }
    }
}