class PostsController < ApplicationController
    include SessionsHelper

    before_action :is_member?, only: [:new, :create]

    def index
        @posts = Post.all.order("created_at DESC")   
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to root_path
        else
            render "new"
        end
    end

    private

    def post_params
        params[:post][:user_id] = session[:id]
        params.require(:post).permit(:content, :user_id)
    end

    def is_member?
        redirect_to login_path unless logged_in?
    end

end
