class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :title, presence: true
  validates :text, presence: true

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
