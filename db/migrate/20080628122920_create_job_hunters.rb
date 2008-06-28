class CreateJobHunters < ActiveRecord::Migration
  def self.up
    create_table :job_hunters do |t|
      t.string :name
      t.string :email
      
      t.timestamps
    end
  end

  def self.down
    drop_table :job_hunters
  end
end
