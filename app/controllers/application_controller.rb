class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, except: [:top,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_up_path_for(resource)
    flash[:notice] = "登録に成功しました"
    customer_path(current_customer)
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインに成功しました"
    customer_path(current_customer)
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトに成功しました"
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:family_name,:last_name,:family_name_kana,:last_name_kana,:postcode,:address,:phone_number])
  end
end
