const mobileBtn = document.querySelector('#nav-btn');
const leftNav = document.querySelector('#left-nav');
const footer = document.querySelector('footer');
const left = document.querySelector('#left-nav-content');
let last_known_scroll_position = 0;
let ticking = false;

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

function navScroll() {
  let leftRect = left.getBoundingClientRect();
  let footerRect = footer.getBoundingClientRect();

  if (footerRect.y - leftRect.y - leftRect.height <= 120 && leftRect.y <= 100) {
    left.classList.add('stop-nav');
  } else {
    left.classList.remove('stop-nav');
  }
}

mobileBtn.addEventListener('click', showMenu);
window.addEventListener('scroll', function(e) {
  last_known_scroll_position = window.scrollY;

  if (!ticking) {
    window.requestAnimationFrame(function() {
      navScroll(last_known_scroll_position);
      ticking = false;
    });
    ticking = true;
  }
});
