class Job < ActiveRecord::Base
  belongs_to :job_type
  belongs_to :category
  belongs_to :city
end
