class Posts::LikesController < ApplicationController
    include ActionView::RecordIdentifier
    before_action :authenticate_user!
    before_action :set_post

    def update
        if @post.liked_by?(current_user)
             @post.unlike(current_user)
        else
            @post.like(current_user)
        end

        respond_to do |format|
            format.turbo_stream{
                render turbo_stream: turbo_stream.replace(dom_id(@post, :likes),partial:"posts/likes", locals: {post: @post})
            }
        end
    end

    private
    
    def set_post
        @post = Post.find(params[:post_id])
    end
    
end
