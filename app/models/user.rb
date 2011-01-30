class User < ActiveRecord::Base

  acts_as_authentic

  has_many :links,
    :foreign_key => 'author_id'
  has_many :votes

  def eligible_to_vote_on?(link, args = {})
    submitter = link.author == self
    return false if submitter
    voted = link.voters.include? self
    return true unless voted
    if voted
      vote = votes.find_by_link_id link.id
      case args[:direction]
      when 'up'
        vote.value != 1
      when 'down'
        vote.value != -1
      end
    end
  end

end
