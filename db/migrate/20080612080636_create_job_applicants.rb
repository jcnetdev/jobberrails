class CreateJobApplicants < ActiveRecord::Migration
  def self.up
    create_table :job_applicants, :force => true do |t|
      t.integer :job_id
      
      t.string :name
      t.string :email
      t.string :message
      
      t.string :ip
      
      # File Attachment Fields
      t.string   "content_type"
      t.string   "filename"
      t.string   "thumbnail"
      t.integer  "size"
      t.integer  "width"
      t.integer  "height"
      
      t.timestamps
    end
  end

  def self.down
    drop_table :job_applicants
  end
end
