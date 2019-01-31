class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:friend_id])
    current_user.accept_friend_request_from(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @user = @friendship.friend
    @friendship.destroy
    # current_user.remove_friendship_with(@user)
    respond_to do |format|
      format.html { redirect_to request.referrer || @user }
      format.js
    end
  end

end
