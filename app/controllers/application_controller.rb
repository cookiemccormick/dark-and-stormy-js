#ActionController - controlling the flow of data between the model and the view
#Controllers - connect the models, views and routes
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  private

  def require_login
    if !current_user
      flash[:message] = "You must be logged in to access this section."
      redirect_to login_path
    end
  end
end