class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def listing
    @orders = Order.all.order(created_at: :desc)
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
