class Link < ActiveRecord::Base

  belongs_to :user

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
    Vote.count_for_link self
  end

end
