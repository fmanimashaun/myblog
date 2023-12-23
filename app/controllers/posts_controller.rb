require 'kaminari'

class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    # Catch all the posts associates to this user and paginate them
    @posts =
      Post
        .includes(comments: :user)
        .where(author: @user)
        .order(created_at: :desc)
        .page(params[:page])
        .per(3)
  end

  def show
    @post = Post.includes(comments: :user).find(params[:id])
    @user = @post.author
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(current_user),
                  notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

 def destroy
     @post = Post.find(params[:id])
     if @post.author == current_user || current_user.admin?
       @post.destroy
       redirect_to user_posts_path(current_user), notice: 'Post was successfully deleted.'
     else
       redirect_to user_posts_path(current_user), alert: 'You do not have permission to delete this post.'
     end
   end

end
