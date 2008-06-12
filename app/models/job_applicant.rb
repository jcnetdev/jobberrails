class JobApplicant < ActiveRecord::Base
  
  belongs_to :job
  
  # allow attachments
  has_attachment :storage => :s3,
                 :path_prefix => "public/attachments"

end
