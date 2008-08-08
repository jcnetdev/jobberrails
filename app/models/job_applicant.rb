class JobApplicant < ActiveRecord::Base
  
  belongs_to :job, :counter_cache => true

  validates_presence_of :name
  validates_presence_of :email
  validates_as_email_address :email, :allow_blank => true
  
  has_attached_file :resume
  
  attr_protected :job_id
  
  def self.new_default(init_values = {})
    self.new(init_values)
  end
end