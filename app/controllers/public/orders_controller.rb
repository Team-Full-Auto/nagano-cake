class Public::OrdersController < ApplicationController
def new
  @order =order.new
   @addresses = current_customers.addresses.all
end

def index

  @order = Order.new
  @orders = current_customer.orders.latest
end

def show
@order = current_customer.orders.find(params[:id])
end
def update
   @order.update(order_params)
    redirect_to admin_order_path(@order), notice: 'Successfully updated order status'
     flash[:notice]
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

def confirm
 @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
end
def complete
end
private
def order_params
  params.require(:order).permit(:payment_method)
end
end


