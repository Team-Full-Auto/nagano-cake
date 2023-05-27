class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order =Order.new
    @orders = current_customer.orders.all
    @customer = current_customer
    @shipping_addresses= @customer.shipping_addresses
  end

  def confirm
    @customer = current_customer
    @total_price = 0
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    if order_params[:pay_method].nil?
      flash[:notice] = "支払い方法を選択してください"
      redirect_back(fallback_location: root_path)
    else
    # 自身の住所が選択された場合
      if params[:order][:select_address] === "0" #この場合は===になる
        @order.postcode = @customer.postcode
        @order.address = @customer.address
        @order.address_name = @customer.family_name + @customer.last_name
    # 登録先住所が選択された場合
      elsif params[:order][:select_address] === "1"
        @address = ShippingAddress.find(params[:order][:address_id])
        @order.postcode = @address.postcode
        @order.address = @address.address
        @order.address_name = @address.name
      # 新しいお届け先が選択された場合
      elsif params[:order][:select_address] === "2"
    # どのお届け先も選択されていないとき
      else
        flash[:notice] = "お届け先を選択してください"
        redirect_back(fallback_location: root_path)
      end
    end
  end


  def create
    @cart_items = current_customer.cart_items
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