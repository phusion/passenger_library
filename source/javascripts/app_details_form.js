import $ from 'jquery';

function appDetailsChanged() {
  var rails = !!$('input[name=app_details_rails]:checked', '.app_details_form').val();
  var rvm = !!$('input[name=app_details_rvm]:checked', '.app_details_form').val();
  $('.app_details').hide();
  $('.app_details_any').hide();
  if (rails) {
    $('.app_details_rails').show();
  } else {
    $('.app_details_nonrails').show();
  }
  if (rvm) {
    $('.app_details_rvm').removeClass('nocopy').show();
    $('.app_details_nonrvm').addClass('nocopy');
  } else {
    $('.app_details_nonrvm').removeClass('nocopy').show();
    $('.app_details_rvm').addClass('nocopy');
  }
  autoGenerateMenu();
}

$(document).ready(function() {
  $('.app_details_form input').change(appDetailsChanged);
  appDetailsChanged();
});
