class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  # attr_accessor :name
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }

  has_many :sent_friend_requests, foreign_key: :sender_id, class_name: "FriendRequest", dependent: :destroy
  has_many :requested_friends, through: :sent_friend_requests, source: :recipient
  has_many :received_friend_requests, foreign_key: :recipient_id, class_name: "FriendRequest", dependent: :destroy
  has_many :requesting_friends, through: :received_friend_requests, source: :sender
  has_many :friendships, foreign_key: :user_id, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :liker_id, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :liked_post
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :posts_commented, through: :comments, source: :post

  after_create :send_welcome_email

  def send_friend_request_to(other_user)
    requested_friends << other_user
  end

  def already_sent_friend_request_to?(other_user)
    requested_friends.include?(other_user)
  end

  def remove_friend_request(other_user)
    requested_friends.delete(other_user)
  end

  def accept_friend_request_from(other_user)
    friends << other_user
  end

  def remove_friendship_with(other_user)
    friendships.find_by(friend_id: other_user.id).destroy
  end

  def feed
    friend_ids = "SELECT friend_id FROM friendships
                  WHERE  user_id = :author_id"
    Post.where("author_id IN (#{friend_ids})
                OR author_id = :author_id", author_id: id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def send_welcome_email
    UserMailer.welcome_letter(self).deliver
  end

end
