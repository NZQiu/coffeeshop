new Vue({
  el: '#orders',

  data: {
    orders: [],
    items: []
  },

  ready: function() {
    this.fetchOrders();
  },

  methods: {
    fetchOrders: function() {
      this.$http.get('api/orders').then(function(response) {
        this.$set('orders', response.data.orders);
      }, function(err) {});
      this.$http.get('api/items').then(function(response) {
        this.$set('items', response.data.items);
      }, function(err) {});
    }
  }
});
