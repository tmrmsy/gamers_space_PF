class Post < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(search)
    return Post.all unless search
    Post.where(['content LIKE ?', "%#{search}%"])
  end

end
