class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.xml
  def index
    @jobs = Job.active(:order => "created_at DESC", :limit => 50)

    respond_to do |format|
      format.html # index.html.erb
      format.atom { render :layout => false }
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])
    @job.increment!(:view_count)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end
  
  def apply
    @job = Job.find(params[:id])
    
    @job_applicant = @job.job_applicants.build(params[:job_applicant])
    if @job_applicant.save
      session[:applied_id] = @job.id
      Notifier::deliver_somebodyapplied(@job.poster_email,@job_applicant.name, @job_applicant.message, @job_applicant.filename, @job_applicant.id)
      redirect_to job_url(@job)
    else
      render :action => "show"
    end
  end
  
  def report_spam
    @job = Job.find(params[:id])
    
    if @job.id == session[:reported_id]
      render :text => "<em>Your vote has already been registered. Thanks for voting.</em>"
    else
      @job.increment!(:report_count)
      session[:reported_id] = @job.id
      render :text => "Thank you, your vote was registered and is highly appreciated!"
    end
  end
  
  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @job = Job.new_default(params[:job])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  def verify
    @job = Job.find(params[:id])
    
    # todo:
    # add permission checking here
    
    if request.put?
      @job.verified = true
      
      # todo: add manual confirmation
      @job.confirmed = true
      @job.is_active = true
      
      @job.save!
      
      redirect_to confirm_job_url(@job)
    end
  end
  
  def confirm
    @job = Job.find(params[:id])
    
    # todo:
    # add permission checking here
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        flash[:notice] = 'Job was successfully created.'
        format.html { redirect_to verify_job_url(@job) }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
        Notifier::deliver_jobposted(@job.poster_email,@job.company)
        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])
    
    # todo:
    # add permission checking here

    respond_to do |format|
      if @job.update_attributes(params[:job])
        flash[:notice] = 'Job was successfully updated.'
        format.html { redirect_to(@job) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
end
