class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order =Order.new
    @orders = current_customer.orders.all
    @customer = current_customer
    @shipping_addresses= @customer.shipping_addresses
  end

  def confirm
    @total_price = 0
    @cart_items = current_customer.cart_items
    @customer = current_customer
    @order = Order.new(order_params)
    if order_params[:pay_method].nil?
      flash[:notice] = "支払い方法を選択してください"
      redirect_back(fallback_location: root_path)
    else
    # 自身の住所が選択された場合
      if params[:order][:select_address] = "1"
        @order.postcode = @customer.postcode
        @order.address = @customer.address
        @order.address_name = @customer.family_name + @customer.last_name
    # 登録先住所が選択された場合
      elsif params[:order][:select_address] = "2"
        @address = ShippingAddress.find_by(params[:order][:shipping_address_id])
        @order.postcode = @address.postcode
        @order.address = @address.address
        @order.address_name = @address.name
      # 新しいお届け先が選択された場合
      elsif params[:order][:select_address] = "3"
    # どのお届け先も選択されていないとき
      else 
        flash[:notice] = "お届け先を選択してください"
        redirect_back(fallback_location: root_path)
      end
    end
  end
  
  def create
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    if @order.save
      @cart_items.each do |cart|
        @order_item=OrderItem.new
        @order_item.item_id = cart.item_id
        @order_item.order_id = @order.id
        @order_item.quantity = cart.quantity
        @order_item.buy_price = cart.item.price
        @order_item.save
      end

    redirect_to 
    cart_items.destroy_all

      @cart_items.destroy_all
      redirect_to orders_complete_path

    else
    @order = Order.new(order_params)
    render :new
    end
  end
  def index
    @orders = current_customer.orders
  end

  def show
  @order=Order.find(params[:id])
er.ordering_item
    @order.shipping_cost = 800
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
    @ordering_details.each do |ordering_detail|
    @total_price += ordering_detail.item.add_tax_price*ordering_detail.amount
    end
    @order.total_payment = @total_price + @order.shipping_cost
    end

  @order_item= @order.order_items
  @order.postage = 800
  @total_price = 0
  @order_item.each do |ordering_detail|
    @total_price += ordering_detail.item.with_tax_price*ordering_detail.quantity
  end

  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :pay_method, :postcode, :address, :address_name, :payment, :postage)
  end
end