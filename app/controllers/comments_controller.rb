class CommentsController < ApplicationController
  
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.append('comments_list', partial: 'comments/comment', locals: { comment: @comment }) }
    end

    # refresh_or_redirect_to @post
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
      format.html { redirect_to @post }
    end
    #refresh_or_redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end

end