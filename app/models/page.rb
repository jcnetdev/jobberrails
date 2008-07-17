class Page < ActiveRecord::Base
  validates_presence_of :url, :message => 'Please fill in the URL.'
  validates_uniqueness_of :url, :message => 'The URL is already in use. Please select another URL.'
  validates_presence_of :title, :message => 'Please fill in the Title.'
  validates_format_of :url, :with => /^[-a-z0-9_]{4,50}$/, :message => 'The URL must contain only alphanumerical characters, dashed and underscores.'
  
  def to_param
    self.url
  end
end
