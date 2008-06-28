class AddJobHunterParamRelationship < ActiveRecord::Migration
  def self.up
    create_table :job_hunters_job_params, :force => true do |t|
      t.integer :job_hunter_id
      t.integer :job_param_id
      t.timestamps
    end
  end

  def self.down
    drop_table :job_hunters_job_params
  end
end
