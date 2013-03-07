// http://stackoverflow.com/questions/14247084/undefined-local-variables-in-templates
// ERB uses the same template delimiters as underscore
_.templateSettings = {
    interpolate : /\{\{=(.+?)\}\}/g,
    escape : /\{\{-(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
}

// http://stackoverflow.com/questions/6178366/backbone-js-fetch-results-cached
// Fetch results are cached on IE
$.ajaxSetup({ cache: false });

function showError(error) {
  if (!error) {
      error = "Unknown error has occurred";
  }
  $('.alert-error').text(error).show();
}

function hideError() {
  $('.alert-error').hide();
}