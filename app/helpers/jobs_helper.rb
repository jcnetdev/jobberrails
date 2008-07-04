module JobsHelper
  # list last viewed jobs (from session)
  def last_viewed_jobs
    unless @last_viewed_jobs
      @last_viewed_jobs = []
    end
    
    return @last_viewed_jobs
  end
  
  # display job display text
  def job_location_text(job)
    haml_tag :span, :class => "job-location" do
      puts job.company
      
      if job.location == "Anywhere"
        puts ", #{job.location}"
      elsif !job.location.blank?
        haml_tag :span, "in", :class => "la"
        puts " #{job.location.name}"
      end
    end
  end
  
  # display icon for job type
  def job_type_image(job_type)
    if job_type
      image_tag "job-types/#{job_type.value}.png", :alt => job_type.value
    end
  end
  
  
  def apply_html(job)
    "<br />"+ link_to("Apply Now!", job)+"<br /><br />"
  end
  
end
