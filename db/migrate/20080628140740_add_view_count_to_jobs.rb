class AddViewCountToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :view_count, :integer, :default => 0
    add_column :jobs, :report_count, :integer, :default => 0
  end

  def self.down
    remove_column :jobs, :view_count
    remove_column :jobs, :report_count
  end
end
