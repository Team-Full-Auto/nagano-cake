class Admin::ItemsController < ApplicationController
  def new
    @form = Item.new
  end

  def create
    @form = Item.new(item_params)
    @form.save
    redirect_to admin_item_path(@form)
  end

  def index
    @items = Item.all
    @form = Item.new
  end
  
  def show 
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end 
  
  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item)
  end 
  
  private

  def item_params
    params.require(:item).permit(:name,:detail,:price,:image, :genre_id, :is_selling)
  end

end
