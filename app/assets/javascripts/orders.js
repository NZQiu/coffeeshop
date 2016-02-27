(function($, document) {
  $().ready(function() {
    var orderData = $('#order-data'),
      typeDdl = $('#type-ddl-menu'),
      sizeDdl = $('#size-ddl-menu'),
      orderDdl = $('#order-ddl-menu');

    ajaxOrders();

    $(orderDdl).find('a.menu-item').click(function() {
      $.when(ajaxNewOrder($(this).data('id'))).then(ajaxOrders(1));
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

    // Assume response time is 2 second, to protect server overload if keep refreshing.
    var dAjaxOrders = coffeeshop.debounce(ajaxOrders, 2000, true);
    $('#refresh-list').click(function() {
      dAjaxOrders();
    });

    $(orderData).on('click', 'ul.pagination a', function(e) {
      e.preventDefault();
      ajaxOrders(parseInt(coffeeshop.getUrlParams($(this).attr('href')).page || 1));
    });

    function ajaxNewOrder(item_id) {
      $.post($(orderDdl).data('url'), {
        id: item_id
      }).done(function(data) {
        data.is_succ ? coffeeshop.showNotice(data.msg) : coffeeshop.showError(data.msg);
      }).fail(function() {
        coffeeshop.showError('Order fail created!');
      });
    }

    function ajaxOrders(page) {
      var page = (page || 1),
        type = $('#type-ddl-menu').data('q') || '',
        size = $('#size-ddl-menu').data('q') || '';
      $('span.loading-icon').show();
      $.get($(orderData).data('url'), {
        page: page,
        type: type,
        size: size
      }).done(function(data) {
        $(orderData).html(data);
        var msg = 'Order Listing load successfully: ';
        type && (msg += '[Drink type : ' + type + '], ');
        size && (msg += '[Cup size : ' + size + '], ');
        msg += '[page ' + page + '].';
        coffeeshop.showNotice(msg, 4000);
      }).fail(function() {
        coffeeshop.showError('Order Listing load fail!');
      }).always(function() {
        $('span.loading-icon').hide();
      });
    }

  });
})(jQuery, document);
