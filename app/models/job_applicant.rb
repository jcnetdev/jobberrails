class JobApplicant < ActiveRecord::Base
  
  belongs_to :job
  
  # allow attachments
  has_attachment :storage => :s3,
                 :path_prefix => "public/attachments"

  def self.new_default(init_values = {})
    self.new(init_values)
  end

end
