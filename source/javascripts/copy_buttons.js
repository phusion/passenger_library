const codeBlocks = document.querySelectorAll('pre');

codeBlocks.forEach(block => {
  block.insertAdjacentHTML('afterbegin', '<span class="copy-btn">copy</span>');
});

const copyBtn = document.querySelectorAll('pre .copy-btn');

function filterText(text) {
  const classes = ['btn', 'copy-btn', 'btn-copy-spacer', 'label', 'prompt', 'output', 'nocopy'];
  const newText = Array.from(text)
    .filter(c=>c.nodeType == 3 || (c.nodeType == 1 && !classes.some(n=>c.classList.contains(n))))
    .map(e=>e.nodeType == 3 ? e.data : e.innerText)
    .join("")
    .trim();

  return newText;
}

function copyToken(e) {
  const mehr = this.parentNode;
  const element = document.createElement('textarea');
  element.value = filterText(this.parentNode.childNodes);
  mehr.appendChild(element);
  element.select();
  element.setSelectionRange(0, element.value.length);
  if (document.queryCommandSupported('copy') && document.queryCommandEnabled('copy')) {
    if (document.execCommand('copy')) {
      mehr.removeChild(element);
      this.textContent = 'copied!';
      setTimeout(() => {
        this.textContent = 'copy';
        this.classList.remove('copied');
      }, 1500);
    }
  } else {
    mehr.removeChild(element);
  }
}

copyBtn.forEach(b => b.addEventListener('click', copyToken));
