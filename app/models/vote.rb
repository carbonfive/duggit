class Vote

  include ActiveModel::Validations

  attr_accessor :user_id, :link_id, :value

  validates :user_id, :presence => true
  validates :link_id, :presence => true
  validates :value, :inclusion => [-1, 1]
  validate :not_link_submitter, :if => :link

  def initialize(args = {})
    @user_id = args[:user_id] || args['user_id']
    @link_id = args[:link_id] || args['link_id']
    @value   = args[:value]   || args['value']
  end

  def user
    return nil unless @user_id
    User.find @user_id
  end

  def user=(user)
    @user_id = user ? user.id : nil
  end

  def link
    return nil unless @link_id
    Link.find @link_id
  end

  def link=(link)
    @link_id = link ? link.id : nil
  end

  def save
    return false unless valid?

    $cassandra.insert :votes, @link_id.to_s, { @user_id.to_s => @value.to_s }
    true
  end

  def save!
    raise ActiveRecord::RecordInvalid.new(self) unless save
  end

  protected

  def not_link_submitter
    link_submitter = user_id == link.user_id
    if link_submitter
      errors[:user_id] << "You cannot vote for your own links" 
    end
  end

  def self.from_cassandra(link_id, c)
    user_id = c[0].to_i
    value = c[1].to_i
    Vote.new :user_id => user_id,
             :link_id => link_id,
             :value => value
  end

end
