class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: 'posts'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
