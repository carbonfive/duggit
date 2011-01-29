class Link < ActiveRecord::Base

  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
  has_many :votes

  def self.recent(args)
    order('created_at DESC').
      limit(args[:limit])
  end

  def value
    votes.sum :value
  end

end
