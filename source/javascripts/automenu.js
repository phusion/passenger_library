function autoGenerateMenu() {
  // build side menu
  var toc = [];
  var html = '';

  $('.bs-docs-section h1[id], .bs-docs-section h2[id], .bs-docs-section h3[id]').each(function() {
    if (this.nodeName == "H1" || this.nodeName == "H2") {
      toc.push({ id: this.id, text: $(this).text(), children: [] });
    } else if (toc.length > 0) {
      var lastHead = toc[toc.length - 1];
      lastHead.children.push({ id:  this.id, text: $(this).text() });
    }
  });

  for (var i = 0; i < toc.length; i++) {
    html += '<li><a href="#' + toc[i].id +'">'+ toc[i].text +'</a>';
    if (toc[i].children.length > 0) {
      html += '<ul class="nav">';
      for (var j = 0; j < toc[i].children.length; j++) {
        html+= '<li><a href="#' + toc[i].children[j].id +'">' +
          toc[i].children[j].text +'</a></li>';
      }
      html += '</ul>';
    }
    html += '</li>';
  }

  $('.bs-docs-sidenav').html(html);
}

$(document).ready(function() {
  if ($(document.body).hasClass('automenu')) {
    autoGenerateMenu();
  }
});
