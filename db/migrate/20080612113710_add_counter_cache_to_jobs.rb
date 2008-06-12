class AddCounterCacheToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :job_applicants_size, :integer, :default => 0
  end

  def self.down
    remove_column :jobs, :job_applicants_size
  end
end
