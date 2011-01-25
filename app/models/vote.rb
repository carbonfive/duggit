class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  validates :user_id, :presence => true
  validates :link_id, :presence => true
  validates :value, :presence => true, :inclusion => [-1, 0, 1]
  validate :uniqueness, :on => :create
  validate :ownership, :if => :link_id

  private

  def uniqueness
    votes = Vote.where :user_id => user_id, :link_id => link_id
    errors[:link_id] << "You have already voted for this link" unless votes.length == 0
  end

  def ownership
    errors[:user_id] << "You cannot vote for your own links" if user_id == link.author_id
  end
end