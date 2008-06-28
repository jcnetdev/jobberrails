class CreateJobParams < ActiveRecord::Migration
  def self.up
    create_table :job_params do |t|
      t.string :job_param_category_id
      t.string :param_value
      t.integer :position, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :job_params
  end
end
