class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :link

  validates :user_id, :presence => true
  validates :link_id, :presence => true
  validates :value, :inclusion => [-1, 1]
  validates :value, :uniqueness => { :scope => [:link_id, :user_id] }
  validate :not_link_submitter, :if => :link

 protected

  def not_link_submitter
    link_submitter = user_id == link.user_id
    if link_submitter
      errors[:user_id] << "You cannot vote for your own links" 
    end
  end

end
