class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).reverse_order
    @form = Item.new
    @customer = current_customer
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @customer = current_customer
  end

  private

  def item_params
    params.require(:item).permit(:name,:detail,:price,:image,:genre,:page)
  end
end
