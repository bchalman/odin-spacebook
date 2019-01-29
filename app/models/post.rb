class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  default_scope -> { order(created_at: :desc)}
  has_many :likes, foreign_key: :liked_post_id
  has_many :likers, through: :likes, source: :liker

  validates :content, presence: true, length: { maximum: 300 }
  validates :author_id, presence: true
end
