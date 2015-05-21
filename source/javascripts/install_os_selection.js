// JavaScript for displaying OS-specific installation instructions
// in the "Getting Started" tutorials.

function installOsChanged() {
  var selection = $('#os_install_select').val();
  $('.install_os').hide();
  $('#install_os_' + selection).show();
  if (selection == 'none') {
  	$('#post_install_check').hide();
  } else {
  	$('#post_install_check').show();
  }
}

function debianVersionChanged() {
  var selection = $('#debian_version_select').val();
  if (selection == 'other') {
    $('.supported_debian_instructions').hide();
    $('.unsupported_debian_instructions').show();
  } else {
    $('.supported_debian_instructions').show();
    $('.unsupported_debian_instructions').hide();
    $('.debian_codename').text(selection);

    var name = $('#debian_version_select option[value=' + selection + ']').text();
    if (name.match(/ubuntu/i) && !name.match(/LTS/)) {
      $('.limited_package_support_for_non_lts_ubuntu').show();
    } else {
      $('.limited_package_support_for_non_lts_ubuntu').hide();
    }
  }
}

function showTarballInstallationInstructions() {
  $('#os_install_select').val('other');
}

$(document).ready(function() {
  $('#os_install_select').change(installOsChanged);
  $('#debian_version_select').change(debianVersionChanged);
  installOsChanged();
  debianVersionChanged();
});
