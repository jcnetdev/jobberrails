module Admin::JobsHelper
  def activation_image_tag(job)
    activate = "activate"
    unless job.is_active
      activate = "de" + activate
    end
    image_tag("icon_#{activate}.gif", 
      :alt => activate.capitalize, 
      :id => job.dom_id("activate"))
  end
  
  def link_to_activate_deactivate_job(job)
    link_to_remote(activation_image_tag(job), {
      :url => admin_job_url(job), 
      :method => :put, 
      :loading => "Element.hide('#{job.dom_id("activ_butt")}');Element.show('#{job.dom_id("loading")}')", 
      :complete => "Element.hide('#{job.dom_id("loading")}');Element.show('#{job.dom_id("activ_butt")}')"}, 
      { :id => "#{job.dom_id("activ_butt")}"} )
  end
  
  def link_to_delete_job(job)
    link_to_remote(image_tag("icon-delete.png", :alt => 'Delete'), 
      :url => admin_job_url(job), 
      :confirm => 'Are you sure you want to delete this post?', 
      :method => :delete)
  end
  
  def saving_job_image_tag(job)
    image_tag("ajax-loader.gif", :alt => "Saving...", 
      :style => 'display:none', 
      :id => job.dom_id("loading"))
  end
end
