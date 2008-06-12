class Job < ActiveRecord::Base
  belongs_to :job_type
  belongs_to :category
  belongs_to :location
  
  has_many :job_applicants

  validates_presence_of :name
  validates_presence_of :description

  validates_presence_of :company
  validates_presence_of :poster_email

  
  # create a default populated job
  def self.new_default(init_values = {})
    Job.new({:job_type => JobType.first, :apply_online => true}.merge(init_values))
  end
  
  # switch label used for html forms
  def location_switch_label
    if outside_location.blank?
      "other"
    else
      "pick one from the list"
    end
  end

end
