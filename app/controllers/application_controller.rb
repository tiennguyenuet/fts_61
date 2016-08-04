class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  include PublicActivity::StoreController

  before_action :authenticate_user!

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def check_admin
    if user_signed_in?
      unless current_user.admin? || current_user.supper?
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def check_supper
    if user_signed_in?
      unless current_user.supper?
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit :name,
      :email, :password}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit :name,
      :email, :password, :current_password}
  end
end
