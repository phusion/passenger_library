function rememberIntegrationMode(integrationMode) {
  if (window.localStorage) {
    window.localStorage.setItem('library_integration_mode', integrationMode);
  }
}
