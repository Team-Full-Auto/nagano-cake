class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @form = Item.new
  end
  
  def show 
    @item = Item.find(params[:id])
  end
end
