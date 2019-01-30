class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  default_scope -> { order(created_at: :desc)}
  has_many :likes, foreign_key: :liked_post_id
  has_many :likers, through: :likes, source: :liker
  has_many :comments, foreign_key: :post_id
  has_many :commenters, through: :comments, source: :author

  validates :content, presence: true, length: { maximum: 300 }
  validates :author_id, presence: true

  def first_five_comments
    Comment.where(post_id: id).limit(5)
  end
end
