class Admin::OrdersController < ApplicationController
  before_action :authenticate_customer!


def show
  
end
def update
     @order.update(order_params)
    redirect_to admin_order_path(@order), notice: 'Successfully updated order status'
  end
end
