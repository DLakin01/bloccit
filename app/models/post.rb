class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true


  # In this section of code, we implement an internal ability to instantiate,
  # track, and sum up and down votes. Even though this is the Post model, we
  # simply right in the variable votes, since Post has access to Vote.rb as
  # its parent. In this case, "votes" is an implied "self.votes," referencing
  # the votes on a particular post instance.

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end
end
