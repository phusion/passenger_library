function autoGenerateMenu() {
  // build side menu
  var html = '';

  $('.bs-docs-section').each(function() {
    var h1 = $(this).find('h1').first(),
        h23 = $(this).find('h2[id], h3[id]');

    if (h1.length && h1[0].id) {
      html+= '<li><a href="#' + h1[0].id +'">'+ h1.text() +'</a>';

      if (h23.length) {
        html+= '<ul class="nav">';
        h23.each(function() {
          html+= '<li><a href="#' + this.id +'">'+ $(this).text() +'</a></li>';
        });
        html+= '</ul>';
      }

      html+= '</li>';
    }
  });

  if (html == '') {
    $('[role=complementary]').hide();
    $('[role=main]').toggleClass('col-md-9 col-lg-offset-1 col-lg-8  col-md-offset-2 col-md-8');
  }
  else {
    $('.bs-docs-sidenav').html(html);
  }
}

$(document).ready(function() {
  if ($(document.body).hasClass('automenu')) {
    autoGenerateMenu();
  }
});
