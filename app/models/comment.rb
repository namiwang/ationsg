class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  # attachment
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true

  # validation
  validates :comment, length: { in: 20..200 }
  validates :user, presence: true
  
end
