(function($, document) {
  $().ready(function() {
    var orderData = $('#order-data'),
      typeDdl = $('#type-ddl-menu'),
      sizeDdl = $('#size-ddl-menu'),
      orderDdl = $('#order-ddl-menu');

    ajaxOrders();

    $(orderDdl).find('a.menu-item').click(function() {
      var item_id = $(this).data('id');
      $.post($(orderDdl).data('url'), {
        id: item_id
      }).done(function(data) {
        data.is_succ ? showNotice(data.msg) : showError(data.msg);
      });
    });

    $(typeDdl).find('a.menu-item').click(function() {
      var drink_type = $(this).text(),
        cur = $(typeDdl).data('q');
      if (!cur || cur != drink_type) {
        $(typeDdl).data('q', drink_type);
        $('#type-text').text(drink_type);
        ajaxOrders();
      }
    });

    $(sizeDdl).find('a.menu-item').click(function() {
      var cup_size = $(this).text(),
        cur = $(sizeDdl).data('q');
      if (!cur || cur != cup_size) {
        $(sizeDdl).data('q', cup_size);
        $('#size-text').text(cup_size);
        ajaxOrders();
      }
    });

    // Assume response time is 2 second
    var dAjaxOrders = debounce(ajaxOrders, 2000, true);
    $('#refresh-list').click(function() {
      dAjaxOrders();
    });

    $(orderData).on('click', 'ul.pagination a', function(e) {
      e.preventDefault();
      ajaxOrders(parseInt(getUrlParams($(this).attr('href')).page || 1));
    });

    function ajaxOrders(page) {
      $('span.loading-icon').show();
      $.get($(orderData).data('url'), {
        page: page || 1,
        type: $('#type-ddl-menu').data('q') || '',
        size: $('#size-ddl-menu').data('q') || ''
      }).done(function(data) {
        $(orderData).html(data);
        $('span.loading-icon').hide();
        showNotice('Order Listing load successfully', 4000);
      });
    }

  });
})(jQuery, document);
