class OrdersController < ApplicationController
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

  def index
    @orders = Order.all
  end

  def type
  end

  def size
  end

  private
  def order_params
    params.require(:order).permit(:item_id)
  end
end
