class Public::OrdersController < ApplicationController
def new
  @order =order.new
end
def create
  cart_items = current_custamer.cart_item.all
  @order = current_custamer.orders.new(order_params)
  if@order.save
    cart_items.each do|cart|
    order_item=OrderItem.new
    order_item.item_id = cart.item_id
    order_item.order_id = @order.id
    order_item.order_quantity = cart.quantity
  　 order_item..order_price = cart.item.price
    order_item.save
  end
    redirect_to
    cart_items.destroy_all
  else
      @order = Order.new(order_params)
      render :new
  end
end

end


