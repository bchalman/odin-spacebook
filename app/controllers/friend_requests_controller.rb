class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:recipient_id])
    current_user.send_friend_request_to(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @request = FriendRequest.find(params[:id])
    @user = @request.recipient
    current_user.remove_friend_request(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
