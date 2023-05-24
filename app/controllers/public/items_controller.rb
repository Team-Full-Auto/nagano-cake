class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @form = Item.new
    @customer = Customer.find(params[:id])
  end
  
  def show 
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @customer = current_customer
  end
  
  private

  def item_params
    params.require(:item).permit(:name,:detail,:price,:image,:genre)
  end
end
