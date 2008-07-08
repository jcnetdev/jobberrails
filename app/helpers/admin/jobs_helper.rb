module Admin::JobsHelper
  def activation_image_tag(job)
    activate = "activate"
    unless job.is_active
      activate = "de" + activate
    end
    image_tag("icon_#{activate}.gif", 
      :alt => activate.capitalize, 
      :id => "activate_#{job.id}")
  end
  
  def link_to_activate_deactivate_job(job)
    link_to_remote(activation_image_tag(job), {
      :url => admin_job_url(job.id), 
      :method => :put, 
      :loading => "Element.hide('activ_butt_#{job.id}');Element.show('loading_#{job.id}')", 
      :complete => "Element.hide('loading_#{job.id}');Element.show('activ_butt_#{job.id}')"}, 
      { :id => "activ_butt_#{job.id}"} )
  end
  
  def link_to_delete_job(job_id)
    link_to_remote(image_tag("icon-delete.png", :alt => 'Delete'), 
      :url => admin_job_url(job_id), 
      :confirm => 'Are you sure you want to delete this post?', 
      :method => :delete)
  end
  
  def saving_job_image_tag(job_id)
    image_tag("ajax-loader.gif", :alt => "Saving...", 
      :style => 'display:none', 
      :id => "loading_#{job_id}")
  end
end
