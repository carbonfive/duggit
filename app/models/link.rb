class Link < ActiveRecord::Base

  belongs_to :user
  has_many :votes

  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :url, :presence => true

  def self.recent(args)
    order('created_at DESC').
      limit(args[:limit])
  end

  def self.by_title(title)
    where :title => title
  end

  def value
    votes.sum :value
  end

end
