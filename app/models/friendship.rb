class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  validates :user_id,   presence: true
  validates :friend_id, presence: true
  after_create :mirror_friendship, :delete_friend_request
  after_destroy :destroy_mirror_friendship

  def mirror_friendship
    unless is_mirrored?
      Friendship.create(friend_id: self.user_id,
                          user_id: self.friend_id)
    end
  end

  def destroy_mirror_friendship
    if friendship = is_mirrored?
      friendship.destroy
    end
  end

  def delete_friend_request
    friend_req = FriendRequest.find_by(sender_id: self.friend_id,
                                    recipient_id: self.user_id)
    friend_req.destroy if friend_req
  end

  private

    def is_mirrored?
      Friendship.find_by(friend_id: self.user_id,
                           user_id: self.friend_id)
    end
end
