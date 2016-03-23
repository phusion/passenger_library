// http://help.crazyegg.com/articles/61-user-variables
function CE_READY() {
  if (window.localStorage) {
    var integrationMode = window.localStorage.getItem('library_integration_mode');
    var language = window.localStorage.getItem('programming_language');
    var edition = window.localStorage.getItem('product_edition');

    if (integrationMode) {
      CE2.set(1, integrationMode);
    }
    if (language) {
      CE2.set(2, language);
    }
    if (edition) {
      CE2.set(3, edition);
    }
    console.log(integrationMode, language, edition);
  }
}
