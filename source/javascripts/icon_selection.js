(function($) {
  'use strict';

  $('.icon-selection-row-item[data-toggle]').click(function() {
    $(this).closest('.icon-selection-row-items').find('.icon-selection-row-item').removeClass('active');
    $(this).addClass('active');
  });
})(jQuery);