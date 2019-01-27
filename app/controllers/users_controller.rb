class UsersController < ApplicationController
  # protect_from_forgery
  before_action :authenticate_user!

  def index
    @users = User.all.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def friends
    @user = User.find(params[:id])
    @users = @user.friends.paginate(page: params[:page])
  end

end
