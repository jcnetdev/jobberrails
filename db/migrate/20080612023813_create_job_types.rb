class CreateJobTypes < ActiveRecord::Migration
  def self.up
    create_table :job_types, :force => true do |t|
      t.string :name
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :job_types
  end
end
