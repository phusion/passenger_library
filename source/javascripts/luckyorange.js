// http://help.luckyorange.com/article/126-tagging-with-javascript
(function () {
  if (window.localStorage) {
    var integrationMode = window.localStorage.getItem('library_integration_mode');
    var language = window.localStorage.getItem('programming_language');
    var edition = window.localStorage.getItem('product_edition');

    window._loq = window._loq || [];

    if (integrationMode) {
      window._loq.push(['tag', integrationMode]);
    }
    if (language) {
      window._loq.push(['tag', language]);
    }
    if (edition) {
      window._loq.push(['tag', edition]);
    }
  }
})();
