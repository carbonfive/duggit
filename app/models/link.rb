class Link < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'

  def author_name
    (author && author.username) || 'anonymous'
  end
end