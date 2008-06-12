class AddVerifiedToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :verified, :boolean, :default => false
    add_column :jobs, :confirmed, :boolean, :default => false    
  end

  def self.down
    remove_column :jobs, :verified
  end
end
