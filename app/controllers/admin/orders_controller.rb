class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @orders = Order.find(params[:id])
  end

  def update
    @order=Order.find(params[:id])
    @order_item =OrderItem.where(order_id: params[:id])
    @order.update(order_params)

    if @order.status == "confirm_payment"
      @order_item.update_all(making_status: 1)
    end

    redirect_to admin_order_path(@order), notice: 'Successfully updated order status'
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
