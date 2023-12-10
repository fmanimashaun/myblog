require "kaminari"

class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    # Catch all the posts associates to this user and paginate them
    @posts = Post.where(author: @user).page(params[:page]).per(3)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
