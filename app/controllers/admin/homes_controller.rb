class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page]).reverse_order
  end
  
  private
  
  def top_params
    params.require(:order).permit(:name,:detail,:price,:image,:genre,:page)
end
