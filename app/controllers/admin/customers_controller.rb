class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(parmas[:id])
  end

  def edit
    @customer = Customer.find(parmas[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to admin_customer_path(cutomer.id)
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:family_name,:last_name,:family_name_kana,:last_name_kana,:email,:postcode,:address,:phone_number)
  end
end
