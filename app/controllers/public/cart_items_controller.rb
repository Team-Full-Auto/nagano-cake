class Public::CartItemsController < ApplicationController
  def create
    @cart_items = current_customer.cart_items.all
    @item = Item.find(cart_item_params([:id]))
  end  
  
  def index
    @cart_items = current_customer.cart_items.all
  end 
  
  def edit
  end
  
  def update
  end 
  
  private
  
  def cart_item_params
    params.require(:cart_item_id).permit(:item_id, :quantity)
  end 
end
