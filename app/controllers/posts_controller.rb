class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    
    def index
        @posts = Post.all
    end

    def show
    rescue ActiveRecord::RecordNotFound
        redirect_to posts_path
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to @post, notice: "Post was successfully created"
        else
            render :new, status: :unprocessable_entity, locals: { post: @post }
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to @post, notice: "Post was successfully updated"
        else
            render :edit, status: :unprocessable_entity, locals: { post: @post }
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path, notice: "Post was successfully destroyed"
    end


    private

    def post_params 
        params.require(:post).permit(:title, :content, :cover)
    end 

    def set_post
        @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = " post not found"
        redirect_to root_url
    end

    def authenticate_user
        unless user_signed_in?
          redirect_to new_user_session_path
        end
    end
end
