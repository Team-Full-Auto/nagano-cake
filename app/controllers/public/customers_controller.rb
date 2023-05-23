class Public::CustomersController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit,:update]
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to customer_path(customer.id)
  end

  def check
  end

  def withdrawal
    @customer = current_customer
    #is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
  
  def customer_params
    params.require(:customer).permit(:family_name,:last_name,:family_name_kana,:last_name_kana,:postcode,:address,:phone_number,:email)
  end
  
  def is_matching_login_customer
    customer = Customer.find(params[:id])
    unless customer.id == current_user.id
      redirect_to customer_path(customer.id)
    end
  end
end
