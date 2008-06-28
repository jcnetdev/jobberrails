class JobParam < ActiveRecord::Base
  belongs_to :job_param_category
  
  acts_as_list :scope => :job_param_category
  
end