class JobRequestsController < ApplicationController
  
  def new
    @job_hunter = JobHunter.new
  end
  
  def create
    @job_hunter = JobHunter.new(params[:job_hunter])
    
    if @job_hunter.save
      req_params = params["req_params"] || []
      req_params.each do |req_param_id|
        job_param = JobParam.find_by_id(req_param_id)
        @job_hunter.job_params << job_param if job_param
      end
      
      redirect_to :action => "success"
    else
      render :action => "new"
    end
  end
  
  def success
  end
  
end
