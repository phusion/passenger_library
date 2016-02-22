var Search = {};

Search.initialize = function() {
  var container = Search.container = $('.st-injected-content-generated');
  Search.paginationContainer = container.find('.st-ui-pagination .st-query-present');

  // We change the default values for the integration mode and language dropdowns,
  // but NOT the edition dropdown, because we want people to discover enterprise
  // features by default.

  var integrationMode = $('head .swiftype[name=integration_mode]').prop('content');
  var language = $('head .swiftype[name=language]').prop('content');
  if (integrationMode == 'none') {
    integrationMode = null;
  }
  if (language == 'none') {
    language = null;
  }
  if (window.localStorage) {
    if (!integrationMode) {
      integrationMode = window.localStorage.getItem('library_integration_mode');
    }
    if (!language) {
      language = window.localStorage.getItem('programming_language');
    }
  }
  if (integrationMode) {
    container.find('.st-search-integration-mode').val(integrationMode);
  }
  if (language) {
    container.find('.st-search-language').val(language);
  }

  container.find('.st-default-search-input').closest('form').submit(Search.searchAgain);
  container.find('.st-search-integration-mode').change(Search.searchAgain);
  container.find('.st-search-language').change(Search.searchAgain);
  container.find('.st-search-edition').change(Search.searchAgain);
  container.find('.st-ui-close-button').click(Search.close);
  container.find('.st-search-hide-outputs').click(Search.close);

  $('#st-search-input').swiftypeSearch({
    engineKey: 'TjFWanQXAnosV-zNDxsk',
    resultContainingElement: container.find('.st-search-results .st-query-present'),
    filters: Search.getFilters,
    loadingFunction: Search.onLoad,
    renderFunction: Search.renderResult,
    renderResultsFunction: Search.renderResults
  });

  $('.st-masthead-search-input').keyup(Search.processSecondarySearchInputKeyup);
}

Search.close = function() {
  Search.container.hide();
  location.hash = '';
}

Search.onLoad = function(query) {
  var container = Search.container;
  Search.clearResults();
  container.find('.st-search-results .st-query-present').text('Loading...');
  container.find('.st-default-search-input').val(query);
  container.show();
}

Search.searchAgain = function() {
  var container = Search.container;
  var query = container.find('.st-default-search-input').val();
  var input = $('#st-search-input');
  location.hash = ''; // Force Swiftype to reload search results
  input.val(query);
  input.closest('form').submit();
}

Search.clearResults = function() {
  var container = Search.container;
  container.find('.st-search-results > a').remove();
  container.find('.st-search-summary').hide();
  Search.paginationContainer.find('> *').remove();
}

Search.renderResult = function(documentType, item) {
  var result = $(
    '<a href="" class="st-ui-result __swiftype_result" data-st-result-doc-id="">' +
      '<span class="st-ui-type-heading"></span>' +
      '<span class="st-ui-type-detail">' +
      '</span>' +
    '</a>'
  );
  result.prop('href', item.url);
  result.data('st-result-doc-id', item.id);
  result.find('.st-ui-type-heading').html(item.highlight.title || item.title);
  result.find('.st-ui-type-detail').html(item.highlight.body || item.body);
  return result;
}

Search.renderResults = function(ctx, data) {
  $.fn.swiftypeSearch.defaults.renderResultsFunction(ctx, data);

  var container = Search.container;
  var paginationContainer = Search.paginationContainer;

  var pagination = container.find('.st-page');
  pagination.remove()
  pagination.find('a').addClass('st-ui-pagination-link st-result-pagination-link');

  paginationContainer.find('> *').remove();
  paginationContainer.append(pagination);

  container.find('.st-ui-pagination').show();
}

Search.getFilters = function() {
  var result = {};
  var container = Search.container;

  var integrationMode = container.find('.st-search-integration-mode').val();
  var language = container.find('.st-search-language').val();
  var edition = container.find('.st-search-edition').val();

  if (integrationMode != 'all') {
    result.integration_mode = [integrationMode, 'none'];
  }
  if (language != 'all') {
    result.language = [language, 'none'];
  }
  if (edition != 'all') {
    result.edition = [edition, 'none'];
  }

  return { page: result };
}

Search.processSecondarySearchInputKeyup = function(event) {
  if (event.keyCode == 13) {
    var searchTerm = $(this).val();
    var input = $('#st-search-input');
    input.val(searchTerm);
    input.closest('form').submit();
  }
}

$(document).ready(function() {
  Search.initialize();
});
