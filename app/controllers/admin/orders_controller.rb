class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    @order=Order.find(params[:id])
    @order_items =OrderItem.where(order_id: params[:id])
    if @order.update(order_params)
      @order_items.update_all(crreate_status: 1) if @order.status == "before_payment"
    end

    redirect_to admin_order_path(@order), notice: 'Successfully updated order status'
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
