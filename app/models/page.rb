class Page < ActiveRecord::Base
  validates_presence_of :url, :message => 'Please fill in the URL'
  validates_uniqueness_of :url, :message => 'The URL is already in use. Please select another URL'
  validates_presence_of :title, :message => 'Please fill in the Title'
  
  def to_param
    self.url
  end
end
