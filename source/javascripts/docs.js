/*!
 * JavaScript for Bootstrap's docs (http://getbootstrap.com)
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under the Creative Commons Attribution 3.0 Unported License. For
 * details, see http://creativecommons.org/licenses/by/3.0/.
 */

!function ($) {
  'use strict';

  $(function () {

    // Scrollspy
    var $window = $(window)
    var $body   = $(document.body)

    $body.scrollspy({
      target: '.bs-docs-sidebar'
    })
    $window.on('load', function () {
      $body.scrollspy('refresh')
    })

    // Kill links
    $('.bs-docs-container [href=#]').click(function (e) {
      e.preventDefault()
    })

    // Sidenav affixing
    function affixSidenav() {
      var $sideBar = $('.bs-docs-sidebar')

      $sideBar.affix({
        offset: {
          top: function () {
            var offsetTop      = $sideBar.offset().top
            var sideBarMargin  = parseInt($sideBar.children(0).css('margin-top'), 10)
            var navOuterHeight = $('.bs-docs-nav').height()
            return (this.top = offsetTop - navOuterHeight - sideBarMargin)
          },
          bottom: function () {
            return (this.bottom = $('.bs-docs-footer').outerHeight(true))
          }
        }
      })
    }

    setTimeout(affixSidenav, 100)
    $window.load(affixSidenav)
  })

}(jQuery);

/*!
 * AnchorJS - v0.1.0 - 2014-08-17
 * https://github.com/bryanbraun/anchorjs
 * Copyright (c) 2014 Bryan Braun; Licensed MIT
 */

function addAnchors(selector) {
  'use strict';

  // Sensible default selector, if none is provided.
  if (!selector) {
    selector = 'h1, h2, h3, h4, h5, h6';
  } else if (typeof selector !== 'string') {
    throw new Error('AnchorJS accepts only strings; you used a ' + typeof selector);
  }

  // Select any elements that match the provided selector.
  var elements = document.querySelectorAll(selector);

  // Loop through the selected elements.
  for (var i = 0; i < elements.length; i++) {
    var elementID;

    if (elements[i].hasAttribute('id')) {
      elementID = elements[i].getAttribute('id');
    } else {
      // We need to create an ID on our element. First, we find which text selection method is available to the browser.
      var textMethod = document.body.textContent ? 'textContent' : 'innerText';

      // Get the text inside our element
      var roughText = elements[i][textMethod];

      // Refine it so it makes a good ID. Makes all lowercase and hyphen separated.
      // Ex. Hello World > hello-world
      var tidyText = roughText.replace(/\s+/g, '-').toLowerCase();

      // Assign it to our element.
      // Currently the setAttribute element is only supported in IE9 and above.
      elements[i].setAttribute('id', tidyText);

      // Grab it for use in our anchor.
      elementID = tidyText;
    }
    var anchor = '<a class="anchorjs-link" href="#' + elementID + '"><span class="anchorjs-icon"></span></a>';

    elements[i].innerHTML = anchor + elements[i].innerHTML;
  }
}

(function () {
  'use strict';
  addAnchors('.bs-docs-container h1, .bs-docs-container h2, .bs-docs-container h3, .bs-docs-container h4, .bs-docs-container h5');
})();
