namespace DevsDaddy.XScaling
{
    /// <summary>
    /// XScaling Controller for all components
    /// </summary>
    public static class XRender
    {
        // Active Flag
        public static bool IsActive { get; private set; } = true;
        
        // Delegates
        public delegate void StateChanged(bool currentState);
        public static StateChanged OnStateChanged;
        
        /// <summary>
        /// Activate XRender Features
        /// </summary>
        /// <param name="activeState"></param>
        public static void SetActive(bool activeState) {
            IsActive = activeState;
            OnStateChanged?.Invoke(activeState);
        }

        /// <summary>
        /// Toggle XRender Features
        /// </summary>
        public static void ToggleActive() {
            SetActive(!IsActive);
        }
    }
}