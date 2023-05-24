class Admin::OrdersController < ApplicationController
  before_action :authenticate_customer!


def show

end
def update
    @order.find(params[:id])
    @order_item =OrderItem.where(order_id: params[:id])
    if @order.update(order_params)
      @order_itemupdate_all(making_status: 1)

      if @order.status == "payment_confirmation"
      end
    end


    redirect_to admin_order_path(@order), notice: 'Successfully updated order status'
  end
  private
def order_params
  params.require(:order).permit(:status)
end
end
