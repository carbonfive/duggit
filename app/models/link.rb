class Link < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
  has_many :votes

  def author_name
    (author && author.username) || 'anonymous'
  end

  def value
    return 0 if votes.empty?
    
    votes.collect(&:value).reduce(&:+)
  end
end