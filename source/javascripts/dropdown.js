import applySelection from './install_to_production';

function reindex() {
  let step = 0;
  let substep = 0;
  Array.from(document.querySelectorAll('[data-step_placeholder], [data-substep_placeholder]')).filter(e=>e.offsetParent !== null).forEach((e,i,a)=>{
    if ('step_placeholder' in e.dataset) {
      if (e.parentElement.tagName !== "H3") {
        step += 1;
        substep = 0;
      }
      e.innerText = step;
    } else {
      substep += 1;
      e.innerText = substep;
    }
  });
}

function makeDropdown(dropdown_type, dropdown_items) {
  const format = s => s.toLowerCase().replace(/[\s]/,'_');
  const unformat = s => (s?s.split(/[_\s]+/).map(s=>s.replace(/^(.)(.*)/, (match, p1, p2) =>
    p1.toUpperCase() + p2.toLowerCase()
  )).join(' '):s);
  const element = document.querySelector(`.${dropdown_type.toLowerCase()} select`);
  const array = dropdown_items.map(format);

  function changeHandler() {
    const self = this;
    const location = window.location.href;
    const value = format(self.value);

    array.forEach(function(item) {
      if (item !== value && location.includes(item)) {
        window.location = location.replace(item, value);
      }

      // change logo if this's value doesn't change the content
      self.style.backgroundImage = `url("/images/${value}.svg")`;

      array.forEach(needle => {
        document.querySelectorAll(`a[href*="/${needle}/"]`).forEach(a=>{a.href=a.href.replace(`/${needle}/`, `/${value}/`)});
        document.querySelectorAll(`[data-${needle}_only]`).forEach(e=>e.style.display = (`${value}_only` in e.dataset ? (e.tagName == "SPAN" ? "inline" : "inherit") : "none"));
      });
      document.querySelectorAll(`[data-${dropdown_type.toLowerCase()}_placeholder]`).forEach(e=>{e.innerText=value});

      // save selection in localStorage
      localStorage.setItem(self.name, self.value);
    });
    reindex();
    applySelection(self.name, self.value);
  }

  element.addEventListener('change', changeHandler.bind(element));

  const location = window.location.href;
  let value = unformat(array.find(item => location.includes(`/${item}/`)))
           || localStorage.getItem(element.name)
           || array[0];

  value = value.length < 4 ? value.toUpperCase() : unformat(value);

  localStorage.setItem(element.name, value);
  const option = element.querySelector(`option[value="${value}"]`);
  option.setAttribute('selected', true);
  changeHandler.bind(element)();
}

export default makeDropdown;
