const mobileBtn = document.querySelector('#nav-btn');
const leftNav = document.querySelector('#left-nav');

function showMenu() {
  if (!leftNav.classList.contains('show')) {
    leftNav.classList.add('show');
    leftNav.classList.remove('hidden');
    mobileBtn.classList.add('close-menu');
    mobileBtn.classList.remove('open-menu');
  } else {
    leftNav.classList.add('hidden');
    leftNav.classList.remove('show');
    mobileBtn.classList.add('open-menu');
    mobileBtn.classList.remove('close-menu');
  }
}

mobileBtn.addEventListener('click', showMenu);
