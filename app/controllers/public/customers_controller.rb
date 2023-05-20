class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
  end

  private
  def customer_params
    params.require(:customer).permit(:family_name)
  end
end
