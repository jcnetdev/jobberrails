class Category < ActiveRecord::Base
  acts_as_list
  has_many :jobs
  
  validates_presence_of :name, :value
  validates_uniqueness_of :value
  validates_length_of :value, :within => 4..30
  validates_format_of :value, :with => /^[-a-z0-9_]{4,30}$/
  
  def to_param
    self.value
  end

  def self.list
    find :all, :order => "position"
  end
  
  def self.to_select
    list.map do |category|
      [category.name, category.id]
    end
  end
end
