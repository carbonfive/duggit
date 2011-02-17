class User < ActiveRecord::Base

  acts_as_authentic

  def eligible_to_vote?(link)
    link.user_id != id
  end

end
