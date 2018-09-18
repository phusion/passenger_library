function makeDropdown(dropdown_type, dropdown_items) {
  const element = document.querySelector(`.${dropdown_type.toLowerCase()} select`);
  const array = dropdown_items.map(e=>e.toLowerCase());

  function changeHandler() {
    const self = this;
    const location = window.location.href;
    const value = self.value.toLowerCase();

    array.forEach(function(item) {
      if (item !== value && location.indexOf(item) !== -1) {
        window.location = location.replace(item, value);
      }

      // change logo if this's value doesn't change the content
      self.style.backgroundImage = `url("/images/${value}.svg")`;

      array.forEach(needle => {
        document.querySelectorAll(`a[href*="${needle}"]`).forEach(a=>{a.href=a.href.replace(needle, value)});
        document.querySelectorAll(`[data-${needle}_only]`).forEach(e=>e.style.display = (value == needle ? "inherit" : "none"));
      });
      document.querySelectorAll(`[data-${dropdown_type.toLowerCase()}_placeholder]`).forEach(e=>{e.innerText=value});

      // save selection in localStorage
      localStorage.setItem(self.name, self.value);
    });
    window.reindex();
  }

  element.addEventListener('change', changeHandler.bind(element));

  const location = window.location.href;
  let urlValue = array.find(item => location.includes(`/${item}/`));

  if (!urlValue && !localStorage.getItem(element.name)) {
    urlValue = array[0];
  }
  if (urlValue) {
    localStorage.setItem(element.name, urlValue.replace(/^(.)(.*)/, (match, p1, p2) =>
      p1.toUpperCase() + p2.toLowerCase()
    ));
  }

  const value = localStorage.getItem(element.name);
  const option = element.querySelector(`option[value=${value}]`);
  option.setAttribute('selected', true);
  changeHandler.bind(element)();
}

export default makeDropdown;
