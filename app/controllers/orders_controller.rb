class OrdersController < ApplicationController

  ORDERS_PER_PAGE = 5

  def index
  end

  def listing
    drink_type = params[:type]
    cup_size = params[:size]

    @orders = Order.all
    @orders = @orders.by_drink_type(drink_type) if drink_type && !drink_type.empty? && drink_type.downcase != 'all'
    @orders = @orders.by_cup_size(cup_size) if cup_size && !cup_size.empty? && cup_size.downcase != 'all'
    @orders = @orders.order(created_at: :desc).page(params[:page]).per(ORDERS_PER_PAGE) if @orders

    respond_to do |f|
      f.html { render layout: false }
    end
  end

  def create
    item_id = params[:id]

    is_succ = item_id && Order.new(item_id: item_id).save
    msg = is_succ ? 'Order successfully created.' : 'Order fail created!'

    respond_to do |format|
      format.json { render json: {is_succ: is_succ, msg: msg}}
    end
  end

end
