const axios = require('axios');
const uuidv4 = require('uuid/v4');
const feedbackBaseUrl = 'https://feedback.phusionpassenger.com'
const feedbackApiVersion = 'v1'
const feedbackUrl = `${feedbackBaseUrl}/api/${feedbackApiVersion}`

document.addEventListener('DOMContentLoaded', () => {
  let feedback = document.querySelector('#feedback')
  if(feedback && window.localStorage) {
    let elems = getElements(feedback);
    if(elems.vote == null) {
      elems.yes.addEventListener('click', (e) => {
        e.stopPropagation();
        e.preventDefault();
        handleVote(true, elems);
      })
      elems.no.addEventListener('click', (e) => {
        e.stopPropagation();
        e.preventDefault();
        handleVote(false, elems);
      })
    } else if(elems.vote == 'true') {
      disable(elems.buttons, elems.no);
    } else {
      disable(elems.buttons, elems.yes);
    }
    feedback.classList.remove('hide');
  }
});

function getElements(feedback) {
  let page = document.location.pathname;
  let vote = getVote(page);
  let buttons = feedback.querySelector('.buttons')
  let yes = buttons.querySelector('.yes');
  let no = buttons.querySelector('.no');
  let reason = feedback.querySelector('.reason');
  let reasonBox = reason.querySelector('textarea');
  let reasonButton = reason.querySelector('input[type=button]');
  let thankYou = feedback.querySelector('.thank-you');
  return {
    page: page,
    vote: vote,
    buttons: buttons,
    yes: yes,
    no: no,
    reason: reason,
    reasonBox: reasonBox,
    reasonButton:reasonButton,
    thankYou: thankYou
  }
}

function handleVote(vote, elems) {
  storeVote(elems.page, vote);
  //send vote
  sendVote(elems.page, vote);
  if(vote) {
    disable(elems.buttons, elems.no);
  } else {
    disable(elems.buttons, elems.yes);
  }
  //attach send reason event handler
  elems.reasonButton.addEventListener('click', (e) => {
    e.stopPropagation();
    e.preventDefault();
    sendReason(elems.page, elems.reasonBox.value)
    elems.reason.classList.add('hide');
    elems.thankYou.classList.remove('hide');
  });
  //show reason box
  elems.reason.classList.remove('hide');
  //send reason
}

function sendVote(page, vote) {
  let uuid = getUUID();
  axios.post(`${feedbackUrl}/vote`, {
    uuid: uuid,
    url: page,
    vote: vote
  })
}

function sendReason(page, reason) {
  let uuid = getUUID();
  axios.post(`${feedbackUrl}/reason`, {
    uuid: uuid,
    url: page,
    reason: reason
  })
}

function getUUID() {
  if (window.localStorage) {
    try {
      let uuid = window.localStorage.getItem('uuid');
      if(uuid == null) {
        uuid = uuidv4();
        window.localStorage.setItem('uuid', uuid);
      }
      return uuid;
    } catch (err) {
      if (window.console) {
        console.error(err);
      }
    }
  }
}

function storeVote(page, vote) {
  if (window.localStorage) {
    try {
      window.localStorage.setItem(page, vote);
    } catch (err) {
      if (window.console) {
        console.error(err);
      }
    }
  }
}

function getVote(page) {
  if (window.localStorage) {
    try {
      return window.localStorage.getItem(page);
    } catch (err) {
      if (window.console) {
        console.error(err);
      }
    }
  }
}

function disable(buttons, option) {
  buttons.classList.add('voted');
  option.classList.add('disabled');
}