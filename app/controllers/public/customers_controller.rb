class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
  end

  def update
  end
  
  private
  customer_params
  params.require(:customer).permit(:name)
end
