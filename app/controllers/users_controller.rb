class UsersController < ApplicationController
  def index
    # placeholder for index logic
    @users = User.all
    puts @users
  end

  def show
    @user = User.find_by(id: params[:id])
    puts params[:id]
    flash[:alert] = 'User not found' if @user.nil?
  end
end
