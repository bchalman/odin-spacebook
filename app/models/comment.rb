class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: "User"
  default_scope -> { order(created_at: :asc)}
  validates :content, presence: true, length: { maximum: 300 }
  validates :author_id, presence: true
  validates :post_id, presence: true
end
