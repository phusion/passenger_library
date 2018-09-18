function inputs() {
  return Array.from(document.querySelectorAll('.radio-choices input'));
}

function apply(fn) {
  return inputs().forEach(fn);
}

function applySelection(label, value) {
  const map = {
    "heroku":"deploying_your_app",
    "cloud66":"deploying_your_app",
    "aws":"launch_server",
    "ownserver":"installations",
    "digital_ocean":"launch_server",
  };
  const gem = {
    "os":"passenger",
    "enterprise":"passenger-enterprise-server"
  };
  const button = document.querySelector('#next-step a');
  const values = Object.keys( label == 'Edition' ? gem : map );
  let url = button.href.replace(new RegExp(`/(${values.join('|')})/`), `/${value}/`);
  if (Object.keys(map).includes(value)) {
    url = url.replace(new RegExp('/deploy_to_production/[^/]+'),'/deploy_to_production/'+map[value]);
  }
  button.href = url;

  window.localStorage.setItem(label, value);

  values.forEach(needle=> document.querySelectorAll(`[data-${needle}_only]`).forEach(e=>e.style.display = (value == needle ? "inherit" : "none")));
  document.querySelectorAll(`[data-${label.toLowerCase()}_placeholder]`).forEach(e=>{e.innerText=gem[value]});

  apply(e=>{if(e.dataset.label == label){e.checked=(e.value == value)}});
}

function handleChange(event) {
  const label = event.target.dataset.label;
  const value = event.target.value;

  applySelection(label, value);
}

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

document.addEventListener("DOMContentLoaded", () => {
  inputs().map(e=>e.dataset.label).filter((e,i,a)=>a.indexOf(e) == i).forEach(l=>{
    const location = window.location.href;
    let v = inputs().filter(i=>i.dataset.label == l).map(i=>i.value).find(i=>location.includes(`/${i}/`));
    if (v) {
      window.localStorage.setItem(l, v);
    } else {
      v = window.localStorage.getItem(l);
    }
    if (v) { applySelection(l, v) }
  });
  reindex();
  apply(e=>e.addEventListener('change', handleChange));
});

export default reindex;
