var radioChoices = document.querySelectorAll('.adv-radio-choices input');
var inputs = document.querySelectorAll('#os_install_select');
var btn = document.querySelector('.install_os_continue');
btn.href = window.location.pathname + 'oss/osx.html';

function sendLocalStorageItem() {
  if (this.value) {
    localStorage.setItem('Edition', this.value);
  } else {
    radioChoices.forEach(function(input) {
      var edition = localStorage.getItem('Edition');
      if (input.value === edition) {
        input.checked = true;
      } else {
        radioChoices[0].checked = true;
      }
    });
  }
  changeLink(localStorage.getItem('Edition'));
}

function changeLink(edition) {
  if (edition === 'OSS') {
    btn.href = btn.href.replace('enterprise', 'oss');
  } else if(edition === 'Enterprise') {
    btn.href = btn.href.replace('oss', 'enterprise');
  }
}

radioChoices.forEach(function(choice) {
  return choice.addEventListener('change', sendLocalStorageItem);
});

document.addEventListener('DOMContentLoaded', sendLocalStorageItem);
