class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  validates :user_id, :presence => true
  validates :link_id, :presence => true
  validates :value, :presence => true, :vote_value => true
  validate :uniqueness, :on => :create

  private

  def uniqueness
    votes = Vote.where :user_id => user_id, :link_id => link_id
    errors[:link_id] << "You have already voted for this link" unless votes.empty?
  end
end