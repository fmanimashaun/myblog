# The User class represents a user in the system. It has many posts, comments, and likes.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable
  has_many :posts,
           foreign_key: "author_id",
           inverse_of: "author",
           dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
