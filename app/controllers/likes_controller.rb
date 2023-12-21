class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    if @like.save
      redirect_to request.referrer, notice: 'Liked!'
    else
      redirect_to request.referrer, alert: 'Unable to like.'
    end
  end
end
