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
    $cassandra.get(:votes, id.to_s).reduce(0) do |count, (_user_id, value)|
      count += value.to_i
    end
  end

end
