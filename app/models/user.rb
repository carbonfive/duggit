class User < ActiveRecord::Base

  acts_as_authentic

  has_many :links
  has_many :votes

  def eligible_to_vote?(link)
    link.user_id != id
  end

end
