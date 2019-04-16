class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  private

  def require_login
    redirect_to signup_path unless current_user
  end
end