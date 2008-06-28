class AddCounterCacheToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :job_applicants_count, :integer, :default => 0
  end

  def self.down
    remove_column :jobs, :job_applicants_count
  end
end
