class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    if auth
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
      end
      session[:user_id] = @user.id
      redirect_to home_path
    else
      @user = User.find_by(email: params[:session][:email])
      if @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        redirect_to home_path
      else
        flash[:message] = "There was an error, please try again."
        redirect_to login_path
      end
    end
  end

  def destroy
    if session[:user_id]
      session.delete :user_id
    end
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end