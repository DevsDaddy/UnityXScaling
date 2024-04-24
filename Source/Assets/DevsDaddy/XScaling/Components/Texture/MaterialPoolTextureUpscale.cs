using System;
using System.Collections;
using System.Collections.Generic;
using DevsDaddy.XScaling.Core.Upscale;
using DevsDaddy.XScaling.Enum;
using DevsDaddy.XScaling.Utils;
using UnityEngine;

namespace DevsDaddy.XScaling.Components.Texture
{
    /// <summary>
    /// Material Pool Texture Upscale
    /// </summary>
    public class MaterialPoolTextureUpscale : MonoBehaviour
    {
        [Header("Upscale Settings")]
        [SerializeField] private float distanceToUpscale = 20f;
        [SerializeField] private UpscaleMode upscaleMode = UpscaleMode.Balanced;
        [SerializeField] private UpscaleTechnique upscaleTechnique = UpscaleTechnique.TechniqueA;
        [SerializeField] private int upscaleMultiplier = 3;

        [Header("Upscale Performance")] 
        [SerializeField] private float waitPerTexture = 0.0f;
        
        public bool IsUpscaled => isUpscaled;
        public Action OnUpscaled;
        public Action OnDownscaled;
        
        // Internal Fields
        private bool isDestroying = false;
        private bool isUpscaled = false;
        private List<MaterialPool> materialPool = new List<MaterialPool>();
        private Camera mainCamera;
        
        // Main Texture
        private static readonly int mainTex = Shader.PropertyToID("_MainTex");
        
        /// <summary>
        /// On Awake
        /// </summary>
        private void Awake() {
            CollectMaterialPool();
            XRender.OnStateChanged += OnRenderStateChanged;
        }

        /// <summary>
        /// Collect Material Pool
        /// </summary>
        private void CollectMaterialPool() {
            // Auto-collect Materials from Childs
            materialPool.Clear();
            foreach (var meshRenderer in gameObject.GetComponentsInChildren<Renderer>()) {
                foreach (var material in meshRenderer.materials) {
                    materialPool.Add(new MaterialPool {
                        baseMaterial = material,
                        originalTexture = (Texture2D)material.GetTexture(mainTex),
                        cachedTexture = null,
                        transform = meshRenderer.transform
                    });
                }
            }
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

            StopCoroutine(UpscaleTextures());
            foreach (var materialData in materialPool) {
                materialData.baseMaterial.SetTexture(mainTex, materialData.originalTexture);
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
            
            StopCoroutine(UpscaleTextures());
            StartCoroutine(UpscaleTextures(() => {
                Resources.UnloadUnusedAssets();
                OnUpscaled?.Invoke();
                Debug.Log($"Complete Upscale for {gameObject.name} (Materials Pool): {materialPool.Count} textures upscaled.");
            }));
            
            isUpscaled = true;
        }

        private IEnumerator UpscaleTextures(Action onComplete = null) {
            foreach (var materialData in materialPool) {
                if (materialData.cachedTexture == null) {
                    if (materialData.originalTexture != null) {
                        materialData.SetCachedTexture(UpscaleProcessor.UpscaleToTexture(materialData.originalTexture, upscaleMode, upscaleTechnique, new UpscaleSize(materialData.originalTexture.width * upscaleMultiplier, materialData.originalTexture.height * upscaleMultiplier)));
                    }
                }
                
                materialData.baseMaterial.SetTexture(mainTex, materialData.cachedTexture);
                yield return new WaitForSeconds(waitPerTexture);
            }
            
            onComplete?.Invoke();
        }
        
        /// <summary>
        /// Material Pool
        /// </summary>
        public struct MaterialPool
        {
            public Material baseMaterial;
            public Texture2D originalTexture;
            public Texture2D cachedTexture;
            public Transform transform;

            public void SetCachedTexture(Texture2D texture2D) {
                cachedTexture = texture2D;
            }
        }
    }
}