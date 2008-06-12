class AddJobDescriptionHtml < ActiveRecord::Migration
  def self.up
    add_column :jobs, :description_html, :text
    add_column :jobs, :formatting_type, :string
  end

  def self.down
    remove_column :jobs, :formatting_type
    remove_column :jobs, :description_html
  end
end
