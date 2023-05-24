class Admin::OrderItemsController < ApplicationController
def update
@order =Order.find(params[:order_id])
@order_item = OrderItem.find(params[:id])
 @order_items = @order.order_items.all
is_update = true
if @order_item.update(order.item_params)
  @order.update(status: 2)if @order_item.making_status=="making"
   # ②製作ステータスが「製作中」のときに、注文ステータスを「製作中」に更新する。
      # ここから下の内容は③の内容になります。
      # 紐付いている注文商品の製作ステータスが "すべて" [製作完了]になった際に注文ステータスを「発送準備中」に更新させたいので、
    @order_items.each do |order_item|
      if order_item.making_status != "finish"
        is_update = false
      end
    
     @order.update(status: 3) if is_update
    end
end
    redirect_to admin_order_path(@order)
end


 private

  def order_item_params
    params.require(:order_detail).permit(:making_status)
  end
end
