function inputs() {
  return Array.from(document.querySelectorAll('.radio-choices input'));
}

function apply(fn) {
  return inputs().forEach(fn);
}

function applySelection(label, value) {
  const button = document.querySelector('#next-step a');
  const values = inputs().filter(e=>e.dataset.label == label).map(e=>e.value);
  button.href = button.href.replace(new RegExp(`/(${values.join('|')})/`), `/${value}/`);

  window.localStorage.setItem(label, value);

  return apply(e=>{if(e.dataset.label == label){e.checked=(e.value == value)}});
}

function handleChange(event) {
  const label = event.target.dataset.label;
  const value = event.target.value;

  applySelection(label, value);
}

document.addEventListener("DOMContentLoaded", () => {
  inputs().map(e=>e.dataset.label).filter((e,i,a)=>a.indexOf(e) == i).forEach(l=>{
    const v = window.localStorage.getItem(l);
    if (v) { applySelection(l, v) }
  });
  apply(e=>e.addEventListener('change', handleChange));
});
