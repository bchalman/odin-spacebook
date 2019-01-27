class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # attr_accessor :name
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }

  has_many :sent_friend_requests, foreign_key: :sender_id, class_name: "FriendRequest", dependent: :destroy
  has_many :requested_friends, through: :sent_friend_requests, source: :recipient
  has_many :received_friend_requests, foreign_key: :recipient_id, class_name: "FriendRequest", dependent: :destroy
  has_many :requesting_friends, through: :received_friend_requests, source: :sender

  def send_friend_request_to(other_user)
    requested_friends << other_user
    # other_user.requesting_friends << self
  end

  def already_sent_friend_request_to?(other_user)
    requested_friends.include?(other_user)
  end

  def remove_friend_request(other_user)
    requested_friends.delete(other_user)
  end
end
