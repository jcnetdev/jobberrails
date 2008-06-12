class Location < ActiveRecord::Base
  
  def self.list
    find(:all)
  end
  
  def self.to_select
    list.map do |location|
      [location.name, location.id]
    end
  end
end
