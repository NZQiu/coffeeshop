(function($, document) {
  $().ready(function() {
    var orderData = $('#order-data');

    ajaxOrders(1);

    $(orderData).on('click', 'ul.pagination a', function(e) {
      e.preventDefault();
      ajaxOrders(parseInt(getUrlParams($(this).attr('href')).page || 1));
    });

    function ajaxOrders(page) {
      $('span.loading-icon').show();
      $.get($(orderData).data('url'), {
        page: page
      }).done(function(data) {
        $(orderData).html(data);
        $('span.loading-icon').hide();
      });
    }

    function getUrlParams(url) {
      var params = {};
      url.substring(1).replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) {
        params[key] = value;
      });
      return params;
    }

  });
})(jQuery, document);
