class UsersController < ApplicationController
    include SessionsHelper

    before_action :is_admin?

    def index
        @users = User.all    
    end

    def new
        @user = User.new()
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "New user created"
            redirect_to users_path
        else
            flash.now[:error] = "Fill at least the password field..."
            render "new"
        end
    end

    def destroy
        User.find_by(id: params[:id]).delete
        flash[:success] = "User deleted"
        redirect_to users_path
    end

    private

    def is_admin?
        redirect_to root_path unless current_user.admin?
    end

    def user_params
        params[:user][:password_confirmation] = params[:user][:password]
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
end
