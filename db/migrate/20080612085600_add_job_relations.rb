class AddJobRelations < ActiveRecord::Migration
  def self.up
    add_column :jobs, :location_id, :integer
    add_column :jobs, :job_type_id, :integer
    add_column :jobs, :category_id, :integer
  end

  def self.down
    remove_column :jobs, :category_id
    remove_column :jobs, :job_type_id
    remove_column :jobs, :location_id
  end
end
