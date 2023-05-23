class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, except: [:top,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:family_name,:last_name,:family_name_kana,:last_name_kana,:postcode,:address,:phone_number])
  end
end
