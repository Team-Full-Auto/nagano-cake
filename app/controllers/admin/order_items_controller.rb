class Admin::OrderItemsController < ApplicationController
   before_action :authenticate_admin!
   
def update
  @order =Order.find(params[:order_id])
  @order_item = OrderItem.find(params[:id])
  @order_items = @order.order_items.all
  is_updated = true
  if @order_item.update(order_item_params)
    @order.update(status: 2) if @order_item.create_status=="making"
      # 製作ステータスが「製作中」のときに、注文ステータスを「製作中」に更新する。
      # 紐付いている注文商品の製作ステータスが "すべて" [製作完了]になった際に注文ステータスを「発送準備中」に更新させる
    @order_items.each do |order_item|
      if order_item.create_status != "finish" #製作ステータスが製作完了ではない
        is_updated = false
      end
    end
   @order.update(status: 3) if is_updated 
  end
  redirect_to admin_order_path(@order)
end


 private

  def order_item_params
    params.require(:order_item).permit(:create_status)
  end
end
