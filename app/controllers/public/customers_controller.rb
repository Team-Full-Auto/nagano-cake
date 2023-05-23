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
    if customer.update(customer_params)
      flash[:notice] = "更新に成功しました"
      redirect_to customer_path(customer.id)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def check
  end

  def withdrawal
    @customer = Customer.find(params[:id])
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
    unless customer.id == current_customer.id
      redirect_to customer_path(customer.id)
    end
  end
end
