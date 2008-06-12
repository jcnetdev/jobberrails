class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs, :force => true do |t|
      t.string :title
      t.text :description
      t.string :company
      t.string :url
      t.string :apply
      t.boolean :is_temp
      t.boolean :is_active
      t.string :outside_location
      t.string :poster_email
      t.boolean :apply_online

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
