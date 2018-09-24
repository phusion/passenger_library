function redirect_to_lang() {
  var value;
  if (!(value = localStorage.getItem('Language'))) {
    value = 'ruby';
  }
  window.location = window.location.href.replace(/\/?$/, "/"+value.toLowerCase()+"/");
}
export default redirect_to_lang;
