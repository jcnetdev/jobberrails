class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :null => false, :limit => 320
    end
  end
  
  def self.down
    drop_table :users
  end
end
