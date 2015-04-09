// JavaScript for displaying OS-specific installation instructions
// in the "Getting Started" tutorials.

function installOsChanged() {
  var selection = $('#os_install_select').val();
  $('.install_os').hide();
  $('#install_os_' + selection).show();
}

function debianVersionChanged() {
  var selection = $('#debian_version_select').val();
  $('.debian_codename').text(selection);
}

$(document).ready(function() {
  $('#os_install_select').change(installOsChanged);
  $('#debian_version_select').change(debianVersionChanged);
  installOsChanged();
  debianVersionChanged();
});
