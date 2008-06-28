class JobParamCategory < ActiveRecord::Base
  has_many :job_params, :order => "position"
  
  def self.options
    self.all :order => "position"
  end
  
  
end
