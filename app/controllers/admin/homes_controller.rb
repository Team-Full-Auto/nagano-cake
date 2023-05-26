class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
  end
  
  private
  
<<<<<<< HEAD
  def top_params
    params.require(:order).permit(:name,:detail,:price,:image,:genre,:page)
 end
=======
  
>>>>>>> origin/develop
end
