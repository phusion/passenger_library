class Mode {
  constructor(container, screenModes, localStorage) {
    this.body = document.querySelector('body');
    this.container = container;
    this.modes = screenModes;
    this.storage = localStorage;
    this.renderInput();
  }

  renderInput() {
    if (this.container) {
      this.container.insertAdjacentHTML('afterend', `
        <label class="switch">
          <input type="checkbox">
          <span class="slider round"></span>
        </label>
      `);

      const input = document.querySelector('.switch input');

      this.eventHandler(input);
      this.checkStorage(input);
    }
  }

  eventHandler(input) {
    input.addEventListener('change', this.changeMode.bind(this, input));
  }

  changeMode(input) {
    let mode = this.modes[input.checked];
    if(!this.body.classList.contains(mode)) {
      this.body.classList.toggle(this.modes[!input.checked]);
      this.body.classList.toggle(this.modes[input.checked]);
      this.storeData(mode);
    }
  }

  storeData(mode) {
    localStorage.setItem('screen_mode', mode);
  }

  checkStorage(input) {
    if(Object.values(this.modes).includes(this.storage)) {
      this.body.classList.add(this.storage);
      input.checked = this.storage == this.modes[true];
    } else {
      let dark = !!(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)'));
      this.body.classList.add(this.modes[dark]);
      input.checked = dark;
    }
  }
}

new Mode(
  document.querySelector('#screen-mode img'),
  { true: 'dark-mode', false: 'light-mode' },
  localStorage.getItem('screen_mode')
);
