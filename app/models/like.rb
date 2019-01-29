class Like < ApplicationRecord
  belongs_to :liker, class_name: "User"
  belongs_to :liked_post, class_name: "Post"

  validates :liker_id, presence: true, uniqueness: { scope: :liked_post_id }
  validates :liked_post_id, presence: true
end
