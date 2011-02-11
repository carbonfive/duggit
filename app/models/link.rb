class Link < ActiveRecord::Base

  belongs_to :user

  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :url, :presence => true

  after_create :add_to_timeline

  def self.recent(args)
    options = { :reversed => true, :count => args[:limit] }
    ids = $cassandra.get(:user_links, 'all', options).collect { |_, id| id.to_i }
    where(:id => ids).order("created_at DESC")
  end

  def self.by_title(title)
    where :title => title
  end

  def votes
    Vote.for_link self
  end

  def value
    return 0 unless id

    $cassandra.get(:votes, id.to_s).reduce(0) do |count, (_, value)|
      count += value.to_i
    end
  end

  private

  def add_to_timeline
    value = { SimpleUUID::UUID.new => id.to_s }
    $cassandra.batch do
      $cassandra.insert :user_links, user.id.to_s, value
      $cassandra.insert :user_links, 'all', value
    end
  end

end
