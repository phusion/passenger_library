const mobileBtn = document.querySelector('#nav-btn');
const leftNav = document.querySelector('#left-nav');
const footer = document.querySelector('footer');
const left = document.querySelector('#left-nav-content');
const rightToC = document.querySelector('#right-content-toc');
let last_known_scroll_position = 0;
let ticking = false;

function showMenu() {
  if (!leftNav.classList.contains('show')) {
    leftNav.classList.add('show');
    mobileBtn.classList.add('close-menu');
    mobileBtn.classList.remove('open-menu');
  } else {
    leftNav.classList.remove('show');
    mobileBtn.classList.add('open-menu');
    mobileBtn.classList.remove('close-menu');
  }
}

function repositionNav(element) {
  if (window.scrollY > 30 && window.innerHeight > 680) {
    element.classList.add('repos-nav');
  } else {
    element.classList.remove('repos-nav');
  }
}

function navScroll() {
  let leftRect = left.getBoundingClientRect();
  let footerRect = footer.getBoundingClientRect();
  if (footerRect.y - leftRect.y - leftRect.height <= 120 && leftRect.y <= 30) {
    left.classList.add('stop-nav');
  } else if (leftRect.y >= 30) {
    left.classList.remove('stop-nav');
  }

  repositionNav(left);

  if (rightToC) {
    repositionNav(rightToC);
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
