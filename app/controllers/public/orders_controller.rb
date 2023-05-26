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
    cart_items = current_customer.cart_item.all
    @order = current_customer.orders.new(order_params)
    if@order.save
      cart_items.each do|cart|
      order_item=OrderItem.new
      order_item.item_id = cart.item_id
      order_item.order_id = @order.id
       order_item.order_quantity = cart.quantity
      order_item.order_price = cart.item.price
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
   @cart_items = current_customer.cart_items
    #@order.post_code = @address.postal_code
    #@order.address = @address.address
    #@order.name = @address.name
    @shipping_cost = 800
    @total_price = 0
   #@order_item.each do |order_item|

    #@total_price += cart_item.item.add_tex_price*cart_item.quantity
    #end
   # @order.total_payment = @total_price + @shipping_cost
    @order.pay_method = params[:order][:payment_method]
    if params[:order][:select_number] == "0".to_s
     @order.post_code = current_customer.post_code
       @order.address = current_customer.address
       @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_number] == "1".to_s
        address = current_customer.addresses.find(params[:order][:address_id].to_i)#[:order][:address_id]の文字列を数字に変えるto_iを記述

        @order.post_code = address.post_code#上段で持ってきたaddressのidのpostal_codeを右辺に送る。
        @order.address = address.address
        @order.name = address.name
    elsif params[:order][:select_number] == "2".to_s

        @order.post_code = params[:order][:postal_code]#フォームで入力したデータをparamsが持ってきて[:order][:postal_code]で郵便番号を呼び出す。
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
    end
  end

  def complete
  end
  private

  def order_params
    params.require(:order).permit(:pay_method,:postcode,:address, :name,:customer_id, :total_payment )
  end
end