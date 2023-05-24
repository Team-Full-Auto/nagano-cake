class Public::OrdersController < ApplicationController
def new
  @order =Order.new
   @addresses = current_customer
end

def index

  #@order = Order.new
  @orders = current_customer.orders
end

def show
@order=current_customer.orders.find(params[:id])
@order_item= @order.ordering_item
    @order.shipping_cost = 800
    @total_price = 0
    @ordering_details.each do |ordering_detail|
     @total_price += ordering_detail.item.add_tax_price*ordering_detail.amount
    end
    @order.total_payment = @total_price + @order.shipping_cost
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
 #@order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
end
def complete
end
private
def order_params
  params.require(:order).permit(:payment_method,:post_code,:address, :name,:customer_id, :total_payment )
end
end


