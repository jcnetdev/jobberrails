class Category < ActiveRecord::Base
  acts_as_list
  has_many :jobs
  
  validates_presence_of :name, :value
  validates_uniqueness_of :value
  validates_format_of :value, :with => /^[-a-z0-9_]{4,20}$/
  
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
