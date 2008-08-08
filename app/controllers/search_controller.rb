class SearchController < ApplicationController
  
  def show
    @query = params[:keywords].to_s
    @category = Category.find_by_id(params[:cat_id]) unless params[:cat_id].blank?
      
    if @category
      # search in category
      @jobs = @category.jobs.active.with_content(@query)
    else
      # search all jobs
      @jobs = Job.active.with_content(@query)
    end
    
    
    # hide layout for ajax requests
    if request.xhr?
      render :partial => "search/search_results", :layout => false
    else
      params[:q] = ""
      render :layout => true
    end
  end

end
