class Post < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy


end
