class CreateJobParamCategories < ActiveRecord::Migration
  def self.up
    create_table :job_param_categories do |t|
      t.string :name
      t.integer :position, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :job_param_categories
  end
end
