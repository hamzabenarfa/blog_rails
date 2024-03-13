class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    
    def index
        posts = user_signed_in? ? current_user.posts : Post.published
        render "posts/index", assigns: {posts: posts}
    end

    def show
    rescue ActiveRecord::RecordNotFound
        redirect_to posts_path
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.new(post_params)
        if @post.save
            redirect_to @post, notice: "Post was successfully created"
        else
            render :new, status: :unprocessable_entity, locals: { post: @post }
        end
    end

    def edit
        @post = Post.find(params[:id])
        authorize_user(@post)
    end

    def update
        authorize_user(@post)
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
        params.require(:post).permit(:title, :content, :cover, :published_at)
    end 

    def set_post
        if user_signed_in?
          @post = Post.find(params[:id])
        else
          @post = Post.published.find(params[:id])
        end  
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = " post not found"
        redirect_to root_url
    end

    def authenticate_user
        unless user_signed_in?
          redirect_to new_user_session_path
        end
    end

    def authorize_user(post)
        unless current_user == post.user
          flash[:alert] = "You are not authorized to perform this action."
          redirect_to root_path
        end
    end
end
