class JobApplicant < ActiveRecord::Base
  
  belongs_to :job, :counter_cache => true
  
  # allow attachments
  has_attachment :storage => :file_system,
                 # :storage => :s3,
                 :path_prefix => "public/attachments"

  def self.new_default(init_values = {})
    self.new(init_values)
  end

end
