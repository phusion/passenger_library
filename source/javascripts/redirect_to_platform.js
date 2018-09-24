function redirect_to_platform() {
  var value;
  if (!(value = localStorage.getItem('Platform'))) {
    value = 'aws';
  }
  window.location = window.location.href.replace(/\/?$/, "/"+value.toLowerCase()+"/");
}
export default redirect_to_platform;
