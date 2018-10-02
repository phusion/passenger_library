var editionTitle = document.querySelectorAll('.edition_title');
var gemName = document.querySelectorAll('.gem_name');
var formulaName = document.querySelectorAll('.formula_name');
var nginxFormula = document.querySelectorAll('.nginx_formula');
var moduleName = document.querySelectorAll('.module_name');
var radioChoices = document.querySelectorAll('.adv-radio-choices input');

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
  if (edition === 'OSS') {
    var varArr = [editionTitle, gemName, formulaName, nginxFormula, moduleName];
    var textArr = ['Passenger', 'passenger', 'passenger', 'nginx --with-passenger', 'libnginx-mod-http-passenger'];
    textConverter(varArr, textArr);
  } else {
    var varArr = [editionTitle, gemName, formulaName, nginxFormula, moduleName];
    var textArr = ['Passenger Enterprise', 'passenger-enterprise-server', 'passenger-enterprise', 'nginx-passenger-enterprise', 'libnginx-mod-http-passenger-enterprise'];
    textConverter(varArr, textArr);
  }
}

radioChoices.forEach(function(choice) {
  return choice.addEventListener('change', sendLocalStorageItem);
});
document.addEventListener('DOMContentLoaded', sendLocalStorageItem);
