import $ from 'jquery';

function autoGenerateMenu() {
  // build side menu
  var toc = [];
  var html = '';

  function getClassName(node) {
    return "toc-" + node.nodeName.replace(/^H/g, '');
  }

  $('.bs-docs-section h1[id], .bs-docs-section h2[id], .bs-docs-section h3[id]').each(function() {
    if (!$(this).hasClass('notoc') && $(this).is(':visible')) {
      if (this.nodeName == "H1" || this.nodeName == "H2") {
        toc.push({
          id:   this.id,
          text: $(this).text(),
          children:  [],
          className: getClassName(this)
        });
      } else if (toc.length > 0) {
        var lastHead = toc[toc.length - 1];
        lastHead.children.push({
          id:   this.id,
          text: $(this).text(),
          className: getClassName(this)
        });
      }
    }
  });

  for (var i = 0; i < toc.length; i++) {
    html += '<li class="' + toc[i].className + '"><a href="#' + toc[i].id +'">'+ toc[i].text +'</a>';
    if (toc[i].children.length > 0) {
      html += '<ul>';
      for (var j = 0; j < toc[i].children.length; j++) {
        html+= '<li><a href="#' + toc[i].children[j].id +'">' +
          toc[i].children[j].text +'</a></li>';
      }
      html += '</ul>';
    }
    html += '</li>';
  }

  $('.bs-docs-sidenav').html(html);
  $('.bs-docs-sidenav ul').addClass('nav');
  $('.toc-container').html(html);
  $('.toc-container .toc-1').remove();
}

window.autoGenerateMenu = autoGenerateMenu;

$(document).ready(autoGenerateMenu);
