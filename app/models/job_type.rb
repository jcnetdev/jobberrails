class JobType < ActiveRecord::Base
  def self.list
    find :all
  end
end
