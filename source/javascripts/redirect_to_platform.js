function redirect_to_platform() {
  var value;
  if (!(value = localStorage.getItem('Platform'))) {
    value = 'aws';
  }
  const format = s => s.toLowerCase().replace(/[\s]/,'_');
  window.location = window.location.href.replace(/\/?$/, "/"+format(value)+"/");
}
export default redirect_to_platform;
