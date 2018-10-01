function redirect_to_edition() {
  var value;
  if (!(value = localStorage.getItem('Edition'))) {
    value = 'oss';
  }
  window.location = window.location.href.replace(/\/?$/, "/"+value.toLowerCase()+"/");
}
export default redirect_to_edition;
