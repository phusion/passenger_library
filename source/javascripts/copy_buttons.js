import jQuery from 'jquery';
import 'bootstrap';

function fallback(text) {
  window.prompt(`Copy to clipboard: ${window.navigator.platform.startsWith('Mac')?"⌘":"Ctrl"}+C, Enter`, text);
}

function copyTextToClipboard(event) {
  const classes = ['btn', 'btn-copy-spacer', 'label', 'prompt', 'output', 'nocopy'];
  const text = Array.from(event.target.childNodes)
                    .filter(c=>c.nodeType == 3 || (c.nodeType == 1 && !classes.some(n=>c.classList.contains(n))))
                    .map(e=>e.nodeType == 3 ? e.data : e.innerText)
                    .join("\n")
                    .trim();

  if (document.queryCommandSupported('copy')
      && document.queryCommandEnabled('copy')) {
    var textArea = document.createElement("textarea");
    var s = textArea.style;
    s.position = 'fixed';
    s.top = 0;
    s.left = 0;
    s.width = '2em';
    s.height = '2em';
    s.padding = 0;
    s.border = 'none';
    s.outline = 'none';
    s.boxShadow = 'none';
    s.background = 'transparent';
    textArea.style = s;
    textArea.value = text;
    document.body.appendChild(textArea);
    textArea.select();

    try {
      var successful = document.execCommand('copy');

const modal = jQuery('#modal');
modal.on('shown.bs.modal', () => window.setTimeout(()=>modal.modal('hide'), 2000));
modal.modal('show');

    } catch (err) {
      fallback(text);
    } finally {
      document.body.removeChild(textArea);
    }
  } else {
    fallback(text);
  }
  return false;
}

document.addEventListener("DOMContentLoaded", () => document.querySelectorAll('#main-content pre').forEach(e=>e.addEventListener('click', copyTextToClipboard)));
