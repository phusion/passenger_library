// JavaScript for displaying OS-specific installation instructions
// in the "Getting Started" tutorials.

import $ from 'jquery';

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

    if (window.localStorage.getItem('Integration').toLowerCase() === 'nginx'
        && name.match(/zesty/i)) {
      $('.replace_nginx_package_message').show();
    } else {
      $('.replace_nginx_package_message').hide();
    }
  }
  $('.debian_hideable').hide();
  $('.debian_hideable.'+selection).show();
  setDebianText();
  if(dynamic_module_supported()) {
    $('.dynamic_nginx_package').show();
    $('.compiled_in_nginx_package').hide();
  } else {
    $('.dynamic_nginx_package').hide();
    $('.compiled_in_nginx_package').show();
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
  if (window.localStorage.getItem('Integration').toLowerCase() === 'nginx' && selection == "el7") {
      $('.replace_nginx_package_message').show();
  } else {
      $('.replace_nginx_package_message').hide();
  }
  $('[class^="el"]').hide();
  $('.'+selection).show();
  $('.no_'+selection).hide();
  $('.redhat_distro_name').text(selection);
  $('.rhel_version').text(selection.replace('el',''));
  setRedhatText();
}

function genericInstallationMethodChanged() {
  var selection = $('#generic_install_method_select').val();
  $('.generic_install').hide();
  $('.generic_install_' + selection).show();
}

function updateOsSelectionContinueButton(target) {
  var btn = document.querySelector('.install_os_continue');
  if (btn) {
    btn.href = btn.href.replace(/[^/]+$/, target + '.html');
  }
}

function showGenericInstallationInstructions() {
  $('#os_install_select').val('other').change();
}

$(document).ready(function() {
  $('.os_install_loading_indicator').hide();
  $('#os_install_select').show().change(installOsChanged);
  $('#debian_version_select').change(installOsChanged);
  $('#redhat_version_select').change(installOsChanged);
  $('#generic_install_method_select').change(installOsChanged);
  installOsChanged();
});

function setDebianText() {
  let packages = "";
  let packages_title = "";
  if (window.localStorage.getItem('Edition')) {
    switch (window.localStorage.getItem('Integration').toLowerCase()) {
      case 'apache':
        if (window.localStorage.getItem('Edition').toLowerCase() === 'oss') {
          packages = "libapache2-mod-passenger";
          packages_title = "Passenger + Apache module";
        } else {
          packages = "libapache2-mod-passenger-enterprise";
          packages_title = "Passenger Enterprise + Apache module";
        }
        break;
      case 'nginx':
        if (dynamic_module_supported()) {
          if (window.localStorage.getItem('Edition').toLowerCase() === 'oss') {
            packages = "libnginx-mod-http-passenger";
            packages_title = "Passenger + Nginx module";
          }else{
            packages = "libnginx-mod-http-passenger-enterprise";
            packages_title = "Passenger Enterprise + Nginx module";
          }
        } else {
          if (window.localStorage.getItem('Edition').toLowerCase() === 'oss') {
            packages = "nginx-extras passenger";
            packages_title = "Passenger + Nginx";
          }else{
            packages = "nginx-extras passenger-enterprise";
            packages_title = "Passenger Enterprise + Nginx";
          }
        }
        break;
      default:
        if (window.localStorage.getItem('Edition').toLowerCase() === 'oss') {
          packages = "passenger";
          packages_title = "Passenger";
        } else {
          packages = "passenger-enterprise";
          packages_title = "Passenger Enterprise";
        }
    }
  }
  $('[data-packages_title]').text(packages_title);
  $('[data-packages]').text(packages);
}

function dynamic_module_supported() {
  const distro = $('#os_install_select').val();
  return [
    "buster",
    "stretch",
    "bullseye",
    "bookworm",
    "artful",
    "bionic",
    "cosmic",
    "disco",
    "eoan",
    "focal",
    "groovy",
    "hirsute",
    "impish",
    "jammy",
    "kinetic",
    "lunar",
    "mantic",
    "el7",
    "el8",
    "el9"
  ].includes($(`#${distro}_version_select`).val());
}

function setRedhatText() {
  let packages = "";
  let packages_title = "";
  if (window.localStorage.getItem('Edition')) {
    switch (window.localStorage.getItem('Integration').toLowerCase()) {
      case "apache":
        if (window.localStorage.getItem('Edition').toLowerCase() === 'oss') {
          packages = "mod_passenger"
          packages_title = "Passenger + Apache module"
        }else{
          packages = "mod_passenger_enterprise"
          packages_title = "Passenger Enterprise + Apache module"
        }
        break;
      case "nginx":
        if (dynamic_module_supported()) {
          if (window.localStorage.getItem('Edition').toLowerCase() === 'oss') {
            packages = "nginx-mod-http-passenger"
            packages_title = "Passenger dynamic Nginx module"
          } else {
            packages = "nginx-mod-http-passenger-enterprise"
            packages_title = "Passenger Enterprise dynamic Nginx module"
          }
        } else {
          if (window.localStorage.getItem('Edition').toLowerCase() === 'oss') {
            packages = "nginx passenger"
            packages_title = "Passenger Nginx"
          } else {
            packages = "nginx passenger-enterprise"
            packages_title = "Passenger Enterprise + Nginx"
          }
        }
        break;
      default:
        if (window.localStorage.getItem('Edition').toLowerCase() === 'oss') {
          packages = "passenger"
          packages_title = "Passenger"
        } else {
          packages = "passenger-enterprise"
          packages_title = "Passenger Enterprise"
        }
    }
  }
  $('[data-packages_title]').text(packages_title);
  $('[data-packages]').text(packages);
}
