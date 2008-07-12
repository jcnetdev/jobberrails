class JobHunter < ActiveRecord::Base
  has_and_belongs_to_many :job_params
  
  validates_presence_of :name
  validates_presence_of :email
  validates_as_email_address :email, :allow_blank => true
end
