class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories, :force => true do |t|
      t.string :name
      t.string :value
      t.integer :position, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
