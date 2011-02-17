class Link

  include ActiveModel::Validations

  attr_accessor :id, :user_id, :title, :url, :created_at

  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :url, :presence => true

  def self.recent(args)
    options = { :reversed => true, :count => args[:limit] }
    ids = $cassandra.get(:user_links, 'all', options).values
    where(:id => ids)
  end

  def self.by_title(title)
    where :title => title
  end

  def self.find(id)
    from_cassandra( $cassandra.get :links, id )
  end

  def self.where(args)
    from_cassandra( $cassandra.multi_get(:links, args[:id]).values )
  end

  def initialize(args = {})
    @user_id    = args[:user_id]    || args['user_id']
    @title      = args[:title]      || args['title']
    @url        = args[:url]        || args['url']
    @created_at = args[:created_at] || args['created_at'] || Time.new
  end

  def user
    return nil unless @user_id
    User.find @user_id
  end

  def user=(user)
    @user_id = user ? user.id : nil
  end

  def value
    return 0 unless id

    $cassandra.get(:votes, id.to_s).reduce(0) do |count, (_, value)|
      count += value.to_i
    end
  end

  def save
    return false unless valid?

    uuid = SimpleUUID::UUID.new
    @id = uuid.to_guid
    value = { 'user_id' => @user_id.to_s, 'title' => @title, 'url' => @url, 'created_at' => @created_at.to_f.to_s }
    pointer = { uuid => @id }

    $cassandra.batch do
      $cassandra.insert :links, @id, value
      $cassandra.insert :user_links, @user_id.to_s, pointer
      $cassandra.insert :user_links, 'all', pointer
    end

    true
  end

  def save!
    raise ActiveRecord::RecordInvalid.new(self) unless save
  end

  private

  def self.from_cassandra(c)
    if c.is_a? Array
      return c.collect { |item| from_cassandra(item) }
    end

    Link.new :user_id => c['user_id'].to_i,
             :title => c['title'],
             :url => c['url'],
             :created_at => Time.at(c['created_at'].to_f)
  end

end
