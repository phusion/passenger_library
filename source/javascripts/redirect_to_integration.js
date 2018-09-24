function redirect_to_integration() {
  var value;
  if (!(value = localStorage.getItem('Integration'))) {
    value = 'nginx';
  }
  window.location = window.location.href.replace(/\/?$/, "/"+value.toLowerCase()+"/");
}
export default redirect_to_integration;
