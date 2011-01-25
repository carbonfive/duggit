class User < ActiveRecord::Base
  acts_as_authentic

  has_many :links
  has_many :votes
end
