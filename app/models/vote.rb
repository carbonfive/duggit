class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :link

  validates :user_id, :presence => true
  validates :link_id, :presence => true
  validates :value, :presence => true, :inclusion => [-1, 1]
  validate :not_link_submitter, :if => :link
  validates :user_id, :uniqueness => { :scope => :link_id }

 protected

  def not_link_submitter
    link_submitter = user_id == link.author.id
    if link_submitter
      errors[:user_id] << "You cannot vote for your own links" 
    end
  end

end
