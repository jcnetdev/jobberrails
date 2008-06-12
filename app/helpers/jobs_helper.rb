module JobsHelper
  # list last viewed jobs (from session)
  def last_viewed_jobs
    unless @last_viewed_jobs
      @last_viewed_jobs = []
    end
    
    return @last_viewed_jobs
  end
end
