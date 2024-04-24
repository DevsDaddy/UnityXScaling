using System;
using System.Collections;
using System.Collections.Generic;
using DevsDaddy.XScaling.Core.Render;
using DevsDaddy.XScaling.Core.Upscale;
using DevsDaddy.XScaling.Enum;
using DevsDaddy.XScaling.Utils;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;

namespace DevsDaddy.XScaling
{
    /// <summary>
    /// XScale Camera Render Upscaling Component
    /// </summary>
    [AddComponentMenu("XScaling/Camera/Upscale Camera")]
    [RequireComponent(typeof(Camera))]
    public class CameraUpscaler : MonoBehaviour
    {
        // Events
        public delegate void ApplyMipMapBiasDelegate(float biasOffset);
        public static ApplyMipMapBiasDelegate OnApplyMipMapBias;
        
        public delegate void UndoMipMapBiasDelegate();
        public static UndoMipMapBiasDelegate OnUndoMipMapBias;
        
        [Header("Basic Setup")]
        [Tooltip("Standard Upscale Presets")]
        public UpscaleMode qualityMode = UpscaleMode.HQQuality;

        private Vector2Int _maxRenderSize;
        private Vector2Int _displaySize;
        private bool _resetHistory;

        private Camera _renderCamera;
        private RenderTexture _originalRenderTarget;
        private DepthTextureMode _originalDepthTextureMode;
        private Rect _originalRect;

        private UpscaleMode _prevQualityMode;
        private Vector2Int _prevDisplaySize;

        private Material _copyWithDepthMaterial;

        private bool _isActiveRender = false;

        private void OnEnable()
        {
            _renderCamera = GetComponent<Camera>();
            _originalRenderTarget = _renderCamera.targetTexture;
            _originalDepthTextureMode = _renderCamera.depthTextureMode;
            _renderCamera.targetTexture = null;
            _renderCamera.depthTextureMode = _originalDepthTextureMode | DepthTextureMode.Depth | DepthTextureMode.MotionVectors;
            
            // Determine the desired rendering and display resolutions
            _displaySize = GetDisplaySize();
            UpscaleUtils.GetRenderResolutionFromQualityMode(out var maxRenderWidth, out var maxRenderHeight, _displaySize.x, _displaySize.y, qualityMode);
            _maxRenderSize = new Vector2Int(maxRenderWidth, maxRenderHeight);

            if (_maxRenderSize.x == 0 || _maxRenderSize.y == 0)
            {
                Debug.LogError($"XScaling Upscaler render size is invalid: {_maxRenderSize.x}x{_maxRenderSize.y}. Please check your screen resolution and camera viewport parameters.");
                enabled = false;
                return;
            }
            
            _copyWithDepthMaterial = new Material(Shader.Find("Hidden/BlitCopyWithDepth"));
            CreateContext();
            
            XRender.OnStateChanged += OnRenderStateChanged;
            OnRenderStateChanged(XRender.IsActive);
        }

        private void OnDisable()
        {
            DestroyContext();

            if (_copyWithDepthMaterial != null)
            {
                Destroy(_copyWithDepthMaterial);
                _copyWithDepthMaterial = null;
            }
            
            // Restore the camera's original state
            _renderCamera.depthTextureMode = _originalDepthTextureMode;
            _renderCamera.targetTexture = _originalRenderTarget;
            XRender.OnStateChanged -= OnRenderStateChanged;
        }

        private void OnRenderStateChanged(bool isRenderActive) {
            _isActiveRender = isRenderActive;
        }

        private void CreateContext()
        {
            _prevDisplaySize = _displaySize;
            _prevQualityMode = qualityMode;
            ApplyMipmapBias();
        }

        private void DestroyContext()
        {
            UndoMipmapBias();
        }

        private void ApplyMipmapBias()
        {
            // Apply a mipmap bias so that textures retain their sharpness
            float biasOffset = UpscaleUtils.GetMipmapBiasOffset(_maxRenderSize.x, _displaySize.x);
            if (!float.IsNaN(biasOffset) && !float.IsInfinity(biasOffset))
            {
                OnApplyMipMapBias?.Invoke(biasOffset);
            }
        }

        private void UndoMipmapBias()
        {
            OnUndoMipMapBias?.Invoke();
        }

        private void Update()
        {
            // Monitor for any changes in parameters that require a reset of the FSR3 Upscaler context
            var displaySize = GetDisplaySize();
            if (displaySize.x != _prevDisplaySize.x || displaySize.y != _prevDisplaySize.y || qualityMode != _prevQualityMode)
            {
                OnDisable();
                OnEnable();
            }
        }
        private void LateUpdate()
        {
            // Remember the original camera viewport before we modify it in OnPreCull
            _originalRect = _renderCamera.rect;
        }

        private void OnPreCull()
        {
            _renderCamera.aspect = (float)_displaySize.x / _displaySize.y;
            _renderCamera.rect = new Rect(0, 0, _originalRect.width * _maxRenderSize.x / _renderCamera.pixelWidth, _originalRect.height * _maxRenderSize.y / _renderCamera.pixelHeight);
        }

        private void OnRenderImage(RenderTexture src, RenderTexture dest)
        {
            // Restore the camera's viewport rect so we can output at full resolution
            _renderCamera.rect = _originalRect;
            _renderCamera.ResetProjectionMatrix();

            if (_isActiveRender) {
                // The backbuffer is not set up to allow random-write access, so we need a temporary render texture for FSR3 to output to
                RenderTexture renderTexture = UpscaleProcessor.UpscaleToRenderTexture(src, _prevQualityMode,
                    UpscaleTechnique.TechniqueB, new UpscaleSize(Screen.width, Screen.height));

                // Output the upscaled image
                if (_originalRenderTarget != null)
                    Graphics.Blit(renderTexture, _originalRenderTarget, _copyWithDepthMaterial);
                else
                    Graphics.Blit(renderTexture, dest);

                RenderTexture.ReleaseTemporary(renderTexture);
                renderTexture.Release();
                RenderTexture.active = dest;
            }
            else {
                // Output the upscaled image
                if (_originalRenderTarget != null)
                    Graphics.Blit(src, _originalRenderTarget, _copyWithDepthMaterial);
                else
                    Graphics.Blit(src, dest);
            }
        }

        private RenderTextureFormat GetDefaultFormat()
        {
            if (_originalRenderTarget != null)
                return _originalRenderTarget.format;

            return _renderCamera.allowHDR ? RenderTextureFormat.DefaultHDR : RenderTextureFormat.Default;
        }

        private Vector2Int GetDisplaySize()
        {
            if (_originalRenderTarget != null)
                return new Vector2Int(_originalRenderTarget.width, _originalRenderTarget.height);
            
            return new Vector2Int(_renderCamera.pixelWidth, _renderCamera.pixelHeight);
        }
    }
}
