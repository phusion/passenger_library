function createBreadcrumbModalDialog() {
  var dialog = $('#js-template-modal').clone();
  dialog.attr('id', null);
  dialog.find('.modal-header').remove();
  dialog.on('hidden.bs.modal', function() {
    dialog.remove();
  });
  return dialog;
}

function changeIntegrationMode() {
  var dialog = createBreadcrumbModalDialog();
  var body = $('#js-template-integration-mode-selector .icon-selection-row-container').clone();
  body.find('.nginx').prop('href', location.href.replace(/(apache|nginx|standalone)/, 'nginx'));
  body.find('.apache').prop('href', location.href.replace(/(apache|nginx|standalone)/, 'apache'));
  body.find('.standalone').prop('href', location.href.replace(/(apache|nginx|standalone)/, 'standalone'));
  dialog.find('.modal-body').html(body.html());
  dialog.modal();
}

function changeEdition() {
  var dialog = createBreadcrumbModalDialog();
  var body = $('#js-template-edition-selector .icon-selection-row-container').clone();
  body.find('.oss').prop('href', location.href.replace(/(oss|enterprise)/, 'oss'));
  body.find('.enterprise').prop('href', location.href.replace(/(oss|enterprise)/, 'enterprise'));
  dialog.find('.modal-body').html(body.html());
  dialog.modal();
}
