class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = @user

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment added!'
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    if @comment.destroy
      redirect_to request.referrer, notice: 'Comment was successfully removed.'
    else
      redirect_to request.referrer, alert: 'There was an issue removing the comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
