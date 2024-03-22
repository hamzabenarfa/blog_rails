class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
  
    def create
      @comment = @post.comments.build(comments_params)
      @comment.user = current_user
      
      if @comment.save
        flash[:notice] = "Comment was successfully created"
        respond_to do |format|
          format.html { redirect_to post_path(@post) }
          format.turbo_stream { render turbo_stream: turbo_stream.append('comments_stream', partial: 'comments/comment', locals: { comment: @comment }) }
        end
      else
        flash[:alert] = "Comment was not created"
        redirect_to post_path(@post)
      end
    end
  
    def destroy
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      render turbo_stream: turbo_stream.remove(@comment)
    end

  
    private 
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comments_params 
      params.require(:comment).permit(:body)
    end
end
  