class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    if @like.save
      redirect_to user_post_path(@post.user, @post), notice: 'Liked!'
    else
      redirect_to user_post_path(@post.user, @post), alert: 'Unable to like.'
    end
  end
end
