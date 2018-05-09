$(function () {

  $('#lang-select').val(getLangFromUrl() == '' ? 'ru' : getLangFromUrl());
  console.log('lang');
  console.log(getLangFromUrl());
  console.log($('#lang-select option:selected').val());

  $('#lang-select').change(function () {
    let lang = $('#lang-select option:selected').val();
    if (lang == getLangFromUrl) { return; }
    let url = changeLangInUrl(lang);

    window.location.href = url;
  });

  function getLangFromUrl() {
    let url = $(location).attr('pathname');
    if ((url[0] == '/') && ((url.length == 3) || (url[3] == '/'))) {
      return url.slice(1, 3);
    }

    return '';
  }

  function changeLangInUrl(lang) {
    let url = $(location).attr('pathname');
    if ((url[0] == '/') && ((url.length == 3) || (url[3] == '/'))) {
      url = '/' + lang + '/' + url.slice(4);
    }
    else {
      if (url[0] != '/') { url = '/' + url; }
      url = '/' + lang + url;
    }
    return url;
  }

});
