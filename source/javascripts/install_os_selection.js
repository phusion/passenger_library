// JavaScript for displaying OS-specific installation instructions
// in the "Getting Started" tutorials.

function installOsChanged() {
  var selection = $('#os_install_select').val();
  $('.install_os').hide();
  $('.install_os_' + selection).show();

  var subselection, target;
  if (selection == 'debian') {
    subselection = target = $('#debian_version_select').val();
    debianVersionChanged();
  } else if (selection == 'redhat') {
    subselection = target = $('#redhat_version_select').val();
    redhatVersionChanged();
  } else if (selection == 'osx') {
    target = 'osx';
  } else if (selection == 'other') {
    subselection = target = $('#generic_install_method_select').val();
    genericInstallationMethodChanged();
  }

  if (selection == 'other') {
    if (subselection == 'none') {
      $('.install_os_none').show();
    } else {
      $('.install_os_any').show();
      updateOsSelectionContinueButton(target);
    }
  } else if (selection != 'none') {
    if (subselection == 'other') {
      $('.install_os_not_supported').show();
    } else {
      $('.install_os_any').show();
      updateOsSelectionContinueButton(target);
    }
  }

  autoGenerateMenu();
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

function redhatVersionChanged() {
  var selection = $('#redhat_version_select').val();
  if (selection == 'other') {
    $('.supported_redhat_instructions').hide();
    $('.unsupported_redhat_instructions').show();
  } else {
    $('.supported_redhat_instructions').show();
    $('.unsupported_redhat_instructions').hide();
  }
  if (selection == 'el6') {
    $('.el6').show();
    $('.no_el6').hide();
  } else {
    $('.el6').hide();
    $('.no_el6').show();
  }
  $('.redhat_distro_name').text(selection);
}

function genericInstallationMethodChanged() {
  var selection = $('#generic_install_method_select').val();
  $('.generic_install').hide();
  $('.generic_install_' + selection).show();
}

function updateOsSelectionContinueButton(target) {
  var button = $('.install_os_continue');
  var url = location.href.replace(/#.*/, "").replace(/(.+)\/.*/, function() {
    return arguments[1] + "/";
  });
  url += target + "/" + button.data('next-page');
  button.attr('href', url);
}

function showGenericInstallationInstructions() {
  $('#os_install_select').val('other').change();
}

$(document).ready(function() {
  $('#os_install_select').change(installOsChanged);
  $('#debian_version_select').change(installOsChanged);
  $('#redhat_version_select').change(installOsChanged);
  $('#generic_install_method_select').change(installOsChanged);
  installOsChanged();
});
