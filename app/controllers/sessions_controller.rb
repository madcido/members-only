class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to root_path
    else
      flash.now[:error] = "Invalid login/password"
      render :new 
    end
  end

  def destroy
    log_out current_user if logged_in?
    redirect_to root_path
  end
end
