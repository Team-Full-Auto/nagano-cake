class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total_price = 0
    @sub_totals = @order_items.map{|order_item| order_item.item.with_tax_price * order_item .quantity}
    @total_price = @sub_totals.sum
  end

  def update
    @order=Order.find(params[:id])
    @order_items =OrderItem.where(order_id: params[:id])
    if @order.update(order_params)
      # 注文ステータスが「入金確認」のとき、製作ステータスを全て「製作待ち」に更新する
      @order_items.update_all(create_status: 1) if @order.status == "confirm_payment"
    end
    redirect_to admin_order_path(@order), notice: 'Successfully updated order status'
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
