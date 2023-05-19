class Public::OrdersController < ApplicationController
def new
  @order =order.new
end
def create
  cart_items = current_custamer.cart_item.all
  @order = current_custamer.orders.new
end
end
