var radioChoices = document.querySelectorAll('.adv-radio-choices input');
var editionTitle = document.querySelectorAll('.edition_title');
var gemName = document.querySelectorAll('.gem_name');
// vars for the upgrade page
var formulaName = document.querySelectorAll('.formula_name');
var nginxFormula = document.querySelectorAll('.nginx_formula');
var moduleName = document.querySelectorAll('.module_name');
// vars for the uninstall page
var packagesDebian = document.querySelectorAll('.packages_debian');
var packagesRpm = document.querySelectorAll('.packages_rpm');

function textConverter(varArr, newText) {
  varArr.forEach(function(variable, index) {
    variable.forEach(function(item) {
      item.textContent = newText[index];
    });
  });
}

function sendLocalStorageItem() {
  if (this.value) {
    localStorage.setItem('Edition', this.value);
  } else {
    radioChoices.forEach(function(input) {
      var edition = localStorage.getItem('Edition');
      if (input.value === edition) {
        input.checked = true;
      }
    });
  }
  changeEditionText(localStorage.getItem('Edition'));
}

function changeEditionText(edition) {
  var varArr = [editionTitle, gemName, formulaName, nginxFormula, moduleName, packagesDebian, packagesRpm];
  if (edition === 'OSS') {
    var textArr = ['Passenger', 'passenger', 'passenger', 'nginx --with-passenger', 'libnginx-mod-http-passenger', 'passenger', 'passenger'];
    textConverter(varArr, textArr);
  } else {
    var textArr = [
    'Passenger Enterprise', 'passenger-enterprise-server', 'passenger-enterprise', 'nginx-passenger-enterprise', 'libnginx-mod-http-passenger-enterprise', 'passenger-enterprise', 'passenger-enterprise'];
    textConverter(varArr, textArr);
  }
}

radioChoices.forEach(function(choice) {
  return choice.addEventListener('change', sendLocalStorageItem);
});
document.addEventListener('DOMContentLoaded', sendLocalStorageItem);
