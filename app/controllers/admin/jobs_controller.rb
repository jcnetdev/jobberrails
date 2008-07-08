class Admin::JobsController < ApplicationController
  before_filter :login_required
  layout 'admin'
  
  # GET /admin/jobs
  def index
    @jobs = Job.find_all_by_is_active(false, :order => 'updated_at DESC')
  end
  
  # GET /admin/jobs/1
  def show
    @job = Job.find(params[:id])
  end
  
  # PUT /admin/jobs/1
  def update
    @job = Job.find(params[:id])
    flash_notice("Job has been activated/deactivated")

    respond_to do |format|
      if @job.update_attributes(:is_active => @job.is_active ? false : true)
        format.html { redirect_to admin_jobs_url }
        format.js # admin/jobs/update.js.rjs
      end
    end
  end  
  
  # DELETE /admin/jobs/1
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash_notice("Job has been deleted")
    
    respond_to do |format|
      format.html { redirect_to admin_jobs_url }
      format.js # admin/jobs/destroy.js.rjs
    end
  end
end
