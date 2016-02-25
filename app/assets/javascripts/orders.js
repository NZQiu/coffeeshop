(function($, document) {
  $().ready(function() {
    ajaxOrders();

    function ajaxOrders() {
      var orderData = $('#order-data');
      $('span.loading-icon').show();
      $.get($(orderData).data('url')).done(function(data) {
        $(orderData).html(data);
        $('span.loading-icon').hide();
      });
    }
  });
})(jQuery, document);
