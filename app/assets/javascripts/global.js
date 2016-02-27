(function() {

  this.coffeeshop = function() {};

  coffeeshop.showNotice = function(msg, duration, is_error) {
    var mainContainer = $('#main'),
      alertContainer = $(mainContainer).find('.alert');

    if ($(alertContainer).length) {
      var msgContainer = $(alertContainer).find('span');
      if ($(msgContainer).length) {
        $(msgContainer).text(msg);
      } else {
        $(alertContainer).append('<span>' + msg + '</span>');
      }
    } else {
      $(mainContainer).prepend(
        '<div class="alert fade in text-center hidden"><button type="button" class="close" data-dismiss="alert">&times</button><span>' +
        msg + '</span></div>');
      alertContainer = $(mainContainer).find('.alert');
    }

    if (is_error) {
      $(alertContainer).addClass('alert-danger').removeClass('alert-success');
    } else {
      $(alertContainer).addClass('alert-success').removeClass('alert-danger');
    }

    $(alertContainer).slideDown('slow').removeClass('hidden');
    $(alertContainer).delay(duration || 2000).slideUp('slow');
  };

  coffeeshop.showError = function(msg, duration) {
    window.showNotice(msg, duration, true);
  };

  coffeeshop.getUrlParams = function(url) {
    var params = {};
    url.substring(1).replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) {
      params[key] = value;
    });
    return params;
  };

  coffeeshop.debounce = function(func, wait, immediate) {
    var timeout, args, context, timestamp, result;
    var now = Date.now || function() {
      return new Date().getTime();
    };
    var later = function() {
      var last = now() - timestamp;

      if (last < wait && last >= 0) {
        timeout = setTimeout(later, wait - last);
      } else {
        timeout = null;
        if (!immediate) {
          result = func.apply(context, args);
          if (!timeout) context = args = null;
        }
      }
    };

    return function() {
      context = this;
      args = arguments;
      timestamp = now();
      var callNow = immediate && !timeout;
      if (!timeout) timeout = setTimeout(later, wait);
      if (callNow) {
        result = func.apply(context, args);
        context = args = null;
      }
      return result;
    };
  };

  $(function() {
    $('[data-toggle="popover"]').popover();
  });
}.call(this));
