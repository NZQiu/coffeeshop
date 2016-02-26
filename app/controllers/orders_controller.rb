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

  def new
    @order = Order.new
  end

  def create
    @order = Order.new order_params
    if @order.save
      redirect_to orders_path, alert: 'Order created'
    else
      render :new
    end
  end

  private
  def order_params
    params.require(:order).permit(:item_id)
  end
end
