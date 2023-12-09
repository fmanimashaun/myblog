class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find_by(id: params[:id])
    flash[:alert] = 'User not found' if @user.nil?
  end
end
