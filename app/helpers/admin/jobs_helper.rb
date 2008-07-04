module Admin::JobsHelper
  def activation_image_tag(job)
    activate = "activate"
    unless job.is_active
      activate = "de" + activate
    end
    image_tag("icon_#{activate}.gif", :alt => activate.capitalize, :id => "activate_#{job.id}")
  end
end
