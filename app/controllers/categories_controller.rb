class CategoriesController < ApplicationController
  def index
    @categories = Category.find :all, :order => "position"
  end
  
  def show
    @category = current_category
    @job_type = current_job_type
    
    # add filter
    if @job_type
      conditions = {:conditions => {:job_type_id => @job_type.id}}
    end

    @jobs = @category.jobs.active.latest(conditions)
  end
  
  protected
  def current_category
    @current_category ||= Category.find_by_value(params[:id])
    return @current_category
  end

  def current_job_type
    @current_job_type ||= JobType.find_by_value(params[:job_type])
    return @current_job_type
  end

end
