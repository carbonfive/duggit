class User < ActiveRecord::Base

  acts_as_authentic

  has_many :links
  has_many :votes

  def eligible_to_vote?(value, args)
    vote = args[:on].votes.new :value => value
    vote.user = self
    vote.valid?
  end

end
