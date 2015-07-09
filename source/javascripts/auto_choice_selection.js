function getUrlVar(key) {
	var result = new RegExp(key + "=([^&]*)", "i").exec(window.location.search); 
	return result && unescape(result[1]) || ""; 
}

function applyChoice(choiceMap, storageKey, uriKey, value, linkId, uriParamName, uriFromLocal) {
  if (window.localStorage) {
    window.localStorage.setItem(storageKey, value); 
  }
  choiceMap[uriKey] = value;

  if (uriFromLocal) {
    uri = uriFromLocal;
  } else {
    uri = getUrlVar(uriParamName);
  }
  for (var key in choiceMap) {
    // (filter out keys from the Object.prototype)
    if (choiceMap.hasOwnProperty(key)) {
      uri = uri.replace((":" + key + ":"), choiceMap[key]);
    }
  }
  
  document.getElementById(linkId).href = uri;
}
