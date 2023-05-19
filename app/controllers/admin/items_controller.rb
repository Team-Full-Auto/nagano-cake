class Admin::ItemsController < ApplicationController
  def new
    @form = Item.new
  end

  def create
    @form = Item.new(item_params)
    @form.admin_id = current_user.id
    @form.save
    redirect_to admin_item_path(@form)
  end

  def index
    @items = Item.page(params[:page])
    @form = Item.new
  end

  private

  def item_params
    params.require(:item).permit(:name,:detail,:price)
  end

end
