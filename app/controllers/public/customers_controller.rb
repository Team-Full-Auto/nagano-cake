class Public::CustomersController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  private
  def customer_params
    params.require(:customer).permit(:family_name)
  end
end
