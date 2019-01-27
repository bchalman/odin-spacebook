class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipient = User.find(params[:recipient_id])
    current_user.send_friend_request_to(@recipient)
    redirect_to @recipient
  end

  def destroy
    @request = FriendRequest.find(params[:id])
    @recipient = @request.recipient
    current_user.remove_friend_request(@recipient)
    redirect_to @recipient
  end

end
