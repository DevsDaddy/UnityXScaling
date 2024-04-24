using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace DevsDaddy.XScaling.Demos.Scripts
{
    [RequireComponent(typeof(Canvas))]
    internal class XRenderStateView : MonoBehaviour
    {
        [Header("Component References")] 
        [SerializeField] private Button activateButton;
        [SerializeField] private TextMeshProUGUI activateButtonText;
        [SerializeField] private TextMeshProUGUI basicStateText;

        /// <summary>
        /// On Started
        /// </summary>
        private void Start() {
            UpdateCurrentStates(XRender.IsActive);
            XRender.OnStateChanged += UpdateCurrentStates;
            activateButton.onClick.AddListener(XRender.ToggleActive);
        }

        /// <summary>
        /// On Destroy
        /// </summary>
        private void OnDestroy() {
            XRender.OnStateChanged -= UpdateCurrentStates;
            activateButton.onClick.RemoveListener(XRender.ToggleActive);
        }

        /// <summary>
        /// Update Current States
        /// </summary>
        private void UpdateCurrentStates(bool isActive) {
            activateButton.GetComponent<Image>().color = (isActive) ? new Color(1,0.13f,0,1) : new Color(0,1,0.6f,1);
            activateButtonText.SetText(isActive ? "Disable Upscale" : "Enable Upscale");
            basicStateText.SetText(isActive ? "Current Upscale State: <color=#00FF9A>Enabled</color>" : "Current Upscale State: <color=#FF2100>Disabled</color>");
        }
    }
}