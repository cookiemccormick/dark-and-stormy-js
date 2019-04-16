class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to home_path
    else
      redirect_to root_path
    end
  end

  def destroy
    if session[:user_id]
      session.delete :user_id
    end
    redirect_to root_path
  end
end