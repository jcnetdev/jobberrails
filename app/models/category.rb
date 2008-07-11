class Category < ActiveRecord::Base
  has_many :jobs
  
  validates_presence_of :name, :value
  validates_uniqueness_of :value
  
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
