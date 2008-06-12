class Category < ActiveRecord::Base
  has_many :jobs

  def self.list
    find :all, :order => "position"
  end
  
  def to_param
    self.value
  end
  
end
