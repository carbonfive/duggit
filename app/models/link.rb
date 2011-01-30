class Link < ActiveRecord::Base

  belongs_to :user
  has_many :votes

  def self.recent(args)
    order('created_at DESC').
      limit(args[:limit])
  end

  def value
    votes.sum :value
  end

end
