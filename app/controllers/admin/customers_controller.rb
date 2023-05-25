class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!, only: [:index,:show,:edit,:update]
  def index
    @customers = Customer.page(params[:page])
  end

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
      redirect_to admin_customer_path(customer.id)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:family_name,:last_name,:family_name_kana,:last_name_kana,:email,:postcode,:address,:phone_number)
  end
end
