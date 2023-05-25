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
    @order = Order.new(order_params)
  
    #@order.post_code = @address.postal_code
    #@order.address = @address.address
    #@order.name = @address.name
    @shipping_cost = 800
    @total_prie = 0
    @order_items.each do |order_item|
    @total_price += cart_item.item.add_tex_price*cart_item.amount
    end
    @order.total_payment = @total_price + @order.shipping_ccost
    @order.payment_method = params[:order][:payment_method]
    if params[:order][:select_number] == "0".to_s
     @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_number] == "1".to_s
        address = current_customer.addresses.find(params[:order][:address_id].to_i)#[:order][:address_id]の文字列を数字に変えるto_iを記述

        @order.postal_code = address.postal_code#上段で持ってきたaddressのidのpostal_codeを右辺に送る。
        @order.address = address.address
        @order.name = address.name
    elsif params[:order][:select_number] == "2".to_s

        @order.postal_code = params[:order][:postal_code]#フォームで入力したデータをparamsが持ってきて[:order][:postal_code]で郵便番号を呼び出す。
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