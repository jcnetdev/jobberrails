class Category < ActiveRecord::Base
  has_many :jobs

  def to_param
    self.value
  end

  def self.list
    find :all, :order => "position"
  end
  
  def self.to_select
    list.map do |category|
      [category.name, category.value]
    end
  end
  
end
