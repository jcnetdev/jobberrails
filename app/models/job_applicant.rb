class JobApplicant < ActiveRecord::Base
  
  belongs_to :job, :counter_cache => true

  validates_presence_of :name
  validates_presence_of :email
  
  # allow attachments
  has_attachment :storage => :file_system,
                 # :storage => :s3,
                 :path_prefix => "public/attachments"

  validates_as_attachment


  def self.new_default(init_values = {})
    self.new(init_values)
  end

end
