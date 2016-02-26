(function($, document) {
  $().ready(function() {
    var orderData = $('#order-data'),
      typeDdl = $('#type-ddl-menu'),
      sizeDdl = $('#size-ddl-menu');

    ajaxOrders();

    $(orderData).on('click', 'ul.pagination a', function(e) {
      e.preventDefault();
      ajaxOrders(parseInt(getUrlParams($(this).attr('href')).page || 1));
    });

    $(typeDdl).find('a').click(function() {
      var drink_type = $(this).text(),
        cur = $(typeDdl).data('q');
      if (!cur || cur != drink_type) {
        $(typeDdl).data('q', drink_type);
        $('#type-text').text(drink_type);
        ajaxOrders();
      }
    });

    $(sizeDdl).find('a').click(function() {
      var cup_size = $(this).text(),
        cur = $(sizeDdl).data('q');
      if (!cur || cur != cup_size) {
        $(sizeDdl).data('q', cup_size);
        $('#size-text').text(cup_size);
        ajaxOrders();
      }
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
